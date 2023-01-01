#include <stdlib.h>
#include <string.h>
#include "fmt_mysql.h"

int main(int argc, char *const *argv) {
    char *type;
    int code;

    if (argc == 1)
        type = "mysql";
    else
        type = argv[argc];

    if (!strcmp(type, "mysql"))
        code = fmt_mysql();

    if (!code)
        return EXIT_SUCCESS;
    else
        return EXIT_FAILURE;
}
