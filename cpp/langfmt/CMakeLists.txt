set(MODULE_NAME "langfmt")
message(STATUS "module: ${MODULE_NAME}")

add_executable(
    ${MODULE_NAME}
    main.c
    util.c
    fmt_mysql.c
)
