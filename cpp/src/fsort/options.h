#ifndef OPTIONS
#define OPTIONS

#include <limits.h>

typedef struct options {
    char dir[PATH_MAX];
} options_t;

options_t *parse_opt(int argc, char *const argv[]);

void free_options(options_t *opt);

#endif
