#include <unistd.h>
#include "options.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

static void help(int code) {
    FILE *out = stderr;
    fprintf(out, "Usage: fsort [options...]\n");
    fprintf(out, "  -d <dir> Specifies the folder, the default is the working directory.\n");
    fprintf(out, "\n");
    fprintf(out, "For the files in the specified folder,\n");
    fprintf(out, "sort the files according to the creation time of the files,\n");
    fprintf(out, "and change the file names to serial numbers.\n");
    exit(code);
}

options_t *parse_opt(int argc, char *const argv[]) {
    options_t *options = malloc(sizeof(options_t));
    memset(options, 0, sizeof(options_t));

    int optc;
    while ((optc = getopt(argc, argv, "d:h")) != -1) {
        switch (optc) {
        case 'd':
            if (!realpath(optarg, options->dir)) {
                perror(optarg);
                exit(EXIT_FAILURE);
            }
            break;
        case 'h':
            help(EXIT_SUCCESS);
            break;
        default:
            help(EXIT_FAILURE);
            break;
        }
    }

    if (!strlen(options->dir)) {
        if (!getcwd(options->dir, sizeof(options->dir))) {
            perror(NULL);
            exit(EXIT_FAILURE);
        }
    }
    return options;
}

void free_options(options_t *opt) {
    free(opt);
}
