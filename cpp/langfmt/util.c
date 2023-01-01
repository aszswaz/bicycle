#include "util.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

char *read_in() {
    char *str = NULL, buff[BUFSIZ];
    size_t read_len = 0,
           str_len = 0,
           new_size = 0;

    if (isatty(STDIN_FILENO)) {
        fprintf(stderr, "please enter the text to be formatted!\n");
        return NULL;
    }

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
