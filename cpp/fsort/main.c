#include "options.h"
#include <stdio.h>
#include <dirent.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>
#include <ref_array.h>
#include <sys/stat.h>
#include <errno.h>

// Errors from operating system API calls.
#define system_error(expression, prefix) \
    if (expression) { \
        perror(prefix); \
        stats_code = EXIT_FAILURE; \
        goto finally; \
    }

#define ref_array_error(code) \
    if (code) { \
        fprintf(stderr, "%s\n", strerror(code)); \
        goto finally; \
    }

typedef struct ref_array ref_array_t;

typedef struct file_info {
    char old_path[PATH_MAX];
    char tmp_path[PATH_MAX];
    char suffix[NAME_MAX];
    struct timespec ctime;
} file_info_t;

/**
 * Get all files in a directory.
 */
static ref_array_t *list_dir(const char *path) {
    DIR *dir;
    struct dirent *de;
    ref_array_t *file_infos;
    int stats_code = EXIT_SUCCESS;
    char old_path[PATH_MAX], new_path[PATH_MAX];
    struct stat stat_buf;
    file_info_t *file_info;
    char *suffix;

    dir = opendir(path);
    system_error(!dir, path);
    stats_code = ref_array_create(&file_infos, sizeof(file_info_t), 10, NULL, NULL);
    ref_array_error(stats_code);

    while((de = readdir(dir))) {
        if (de->d_type != DT_REG) continue;
        file_info = malloc(sizeof(file_info_t));
        memset(file_info, 0, sizeof(file_info_t));
        memset(old_path, 0, PATH_MAX);
        memset(new_path, 0, PATH_MAX);
        memset(&stat_buf, 0, sizeof(struct stat));
        snprintf(old_path, PATH_MAX, "%s/%s", path, de->d_name);
        snprintf(new_path, PATH_MAX, "%s/%s.tmp", path, de->d_name);
        system_error(stat(old_path, &stat_buf) == -1, old_path);
        // Prevent file name conflicts.
        system_error(rename(old_path, new_path) == -1, old_path);
        // Linux does not support file creation time, and the file modify time is the most stable, as the creation time.
        file_info->ctime = stat_buf.st_mtim;
        strcpy(file_info->old_path, old_path);
        strcpy(file_info->tmp_path, new_path);
        suffix = strrchr(de->d_name, '.');
        if (suffix) strcpy(file_info->suffix, suffix);
        stats_code = ref_array_append(file_infos, file_info);
        ref_array_error(stats_code);
        free(file_info);
    }

finally:
    if (dir) closedir(dir);
    if (!stats_code)
        return file_infos;
    else
        return NULL;
}

void file_sort(char *const path, ref_array_t *rfinfos) {
    file_info_t **finfos;
    const uint32_t len = ref_array_len(rfinfos);
    uint32_t i, j;
    file_info_t *finfo;
    char format[NAME_MAX], new_name[NAME_MAX], new_path[PATH_MAX];
    uint32_t digit = 2;
    uint32_t number;

    if (!len) {
        fprintf(stderr, "Directory %s has no files.\n", path);
        return;
    } else if (len >= 100) {
        number = len / 100;
        while ((number /= 10)) digit++;
    }
    sprintf(format, "%%0%dd%%s", digit);

    finfos = malloc(sizeof(size_t) * len);
    memset(finfos, 0, sizeof(size_t) * len);
    for (i = 0; i < len; i++) finfos[i] = ref_array_get(rfinfos, i, NULL);

    for (i = 0; i < len; i++) {
        for (j = i + 1; j < len; j++) {
            if (finfos[i]->ctime.tv_sec >= finfos[j]->ctime.tv_sec && finfos[i]->ctime.tv_nsec > finfos[j]->ctime.tv_nsec) {
                finfo = finfos[i];
                finfos[i] = finfos[j];
                finfos[j] = finfo;
            }
        }
    }

    for (i = 0; i < len; i++) {
        memset(new_name, 0, NAME_MAX);
        memset(new_path, 0, PATH_MAX);
        sprintf(new_name, format, i + 1, finfos[i]->suffix);
        sprintf(new_path, "%s/%s", path, new_name);
        fprintf(stdout, "%s -> %s\n", finfos[i]->old_path, new_path);
        if (rename(finfos[i]->tmp_path, new_path) == -1) {
            fprintf(stderr, "%s -> %s: %s\n", finfos[i] -> old_path, new_path, strerror(errno));
            goto finally;
        }
    }

finally:
    if (finfos) free(finfos);
}

int main(int argc, char *const argv[]) {
    options_t *opt = parse_opt(argc, argv);
    ref_array_t *file_infos = list_dir(opt->dir);
    file_sort(opt->dir, file_infos);
    ref_array_destroy(file_infos);
    free_options(opt);
}
