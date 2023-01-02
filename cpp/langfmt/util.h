#ifndef UTIL_H
#define UTIL_H

#include <stdlib.h>

typedef struct scanner {
    size_t index;
    char *content;
    size_t content_len;
} scanner;

void new_scanner(scanner *self, char *content);

/**
 * 从终端读取文本
 */
char *read_in();

/**
 * 获取指定位置的关键词
 */
char *get_keyword(scanner *self);

#endif
