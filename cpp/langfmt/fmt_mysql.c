#include "fmt_mysql.h"
#include "util.h"
#include <stdio.h>
#include <stdlib.h>

int fmt_mysql() {
    int status = 0;
    char *content, *first_keyword;
    scanner scan;

    content = read_in();
    if (!content) {
        fprintf(stderr, "Failed to read text.");
        goto finally;
    }
    new_scanner(&scan, content);
    first_keyword = get_keyword(&scan);
    if (!first_keyword) {
        fprintf(stderr, "Failed to get first keyword.");
        goto finally;
    }

finally:
    if (content) free(content);
    if (first_keyword) free(first_keyword);
    return status;
}
