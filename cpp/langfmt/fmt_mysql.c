#include "fmt_mysql.h"
#include "util.h"
#include <stdio.h>

int fmt_mysql() {
    char *str = read_in();
    if (str) {
        printf("%s", str);
    }
    return 0;
}
