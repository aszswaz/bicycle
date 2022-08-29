#include "thread_pool.h"
#include <stdbool.h>
#include "../container/array_list.h"
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <errno.h>
#include <stdio.h>

#define PTHREAD_ERROR(expression) \
    code = expression; \
    if (code) { \
        errno = code; \
        goto error; \
    }

typedef struct task {
    thread_run run;
    void *args;
    struct task *next;
} task_t;

/**
 * Thread Pool
 */
struct thread_pool {
    bool shutdown;
    array_list_t *threads;
    pthread_cond_t tasks_ready;
    pthread_mutex_t tasks_lock;
    task_t *next;
};

/**
 * The start entry function of the thread.
 */
static void *thread_pool_poll(void *args) {
    int code;
    const char *errmsg;
    task_t *task;
    thread_pool_t *self = (thread_pool_t *)args;

    while(!self->shutdown) {
        PTHREAD_ERROR(pthread_mutex_lock(&self->tasks_lock));
        if (!self->next) {
            PTHREAD_ERROR(pthread_cond_signal(&self->tasks_ready));
        }
        task = self->next;
        if (task) {
            self->next = task->next;
            PTHREAD_ERROR(pthread_mutex_unlock(&self->tasks_lock));
            task->run(task->args);
            free(task);
        } else {
            PTHREAD_ERROR(pthread_mutex_unlock(&self->tasks_lock));
            continue;
        }
    }

    return NULL;
error:
    errmsg = strerror(code);
    fprintf(stderr, "%s %d: %s\n", __FILE_NAME__, __LINE__, errmsg);
    return NULL;
}

static void thread_pool_free(thread_pool_t *self) {
    if (self->threads) array_list_free(self->threads);

    task_t *next = self->next, *intermediate;
    while(next) {
        intermediate = next->next;
        free(next);
        next = intermediate;
    }

    pthread_cond_destroy(&self->tasks_ready);
    pthread_mutex_destroy(&self->tasks_lock);
    free(self);
}

thread_pool_t *thread_pool_new(uint16_t total) {
    thread_pool_t *self;
    int code;
    pthread_t *thread_id;

    self = malloc(sizeof(thread_pool_t));
    if (!self) goto error;
    memset(self, 0, sizeof(thread_pool_t));
    self->threads = array_list_new(total, free);
    if (!self->threads) goto error;

    PTHREAD_ERROR(pthread_cond_init(&self->tasks_ready, NULL));
    PTHREAD_ERROR(pthread_mutex_init(&self->tasks_lock, NULL));

    for (uint16_t i = 0; i < total; i++) {
        thread_id = malloc(sizeof(pthread_t));
        if (!thread_id) goto error;
        PTHREAD_ERROR(pthread_create(thread_id, NULL, thread_pool_poll, self));
    }

    return self;
error:
    thread_pool_free(self);
    return NULL;
}

void thread_pool_shutdown(thread_pool_t *self) {
    pthread_t *thread_id;

    if (self->shutdown) return;
    self->shutdown = 1;

    pthread_mutex_lock(&self->tasks_lock);
    pthread_cond_broadcast(&self->tasks_ready);
    pthread_mutex_unlock(&self->tasks_lock);

    uint32_t size = array_list_size(self->threads);
    for (uint32_t i = 0; i < size; i++) {
        thread_id = array_list_get(self->threads, i);
        pthread_join(*thread_id, NULL);
    }

    thread_pool_free(self);
}

int thread_pool_execute(thread_pool_t *self, thread_run run, void *args) {
    task_t *task, *next;
    int code;

    if (!run) return EINVAL;

    task = malloc(sizeof(task_t));
    if (!task) return errno;
    memset(task, 0, sizeof(task_t));

    task->run = run;
    task->args = args;

    PTHREAD_ERROR(pthread_mutex_lock(&self->tasks_lock));
    next = self->next;
    if (next) {
        while(next->next) next = next->next;
        next->next = task;
    } else {
        self->next = task;
        PTHREAD_ERROR(pthread_cond_signal(&self->tasks_ready));
    }

    PTHREAD_ERROR(pthread_mutex_unlock(&self->tasks_lock));
    return 0;
error:
    return code;
}
