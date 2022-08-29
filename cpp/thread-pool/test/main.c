#include <stdio.h>
#include "../thread_pool.h"
#include "../../container/array_list.h"

int main() {
    array_list_t *list;

    list = array_list_new(10, NULL);

    array_list_add(list, "Hello World");
    printf("array size: %d\n", array_list_size(list));

    array_list_free(list);
}
