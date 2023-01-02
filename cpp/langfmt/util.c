#include "util.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

void new_scanner(scanner *self, char *content) {
    self->index = 0;
    self->content = content;
    self->content_len = strlen(content);
}

char *read_in() {
    char *str = NULL, buff[BUFSIZ];
    size_t read_len = 0,
           str_len = 0,
           new_size = 0;

    if (isatty(STDIN_FILENO)) return NULL;

    // 从终端读取文本
    while (!feof(stdin)) {
        read_len = fread(&buff, 1, sizeof(buff), stdin);
        new_size = read_len + str_len + 1;
        str = realloc(str, new_size);
        if (!str) return NULL;
        memset(&str[str_len], 0, read_len + 1);
        memcpy(&str[str_len], &buff, read_len);
        str_len += read_len;
    }

    return str;
}

char *get_keyword(scanner *self) {
    size_t i, mem_size;
    char *keyword;

    for (i = self->index; i < self->content_len; i++) {
        // 防止连续的空格导致取到空关键词的情况
        if (self->content[i] == ' ' && self->content[i - 1] != ' ') {
            mem_size = i - self->index + 1;
            keyword = (char *) malloc(mem_size);
            if (!keyword) return NULL;
            memset(keyword, 0, mem_size);
            memcpy(keyword, &self->content[self->index], i - self->index);
            break;
        }
    }
    self->index = i + 1;
    return keyword;
}
