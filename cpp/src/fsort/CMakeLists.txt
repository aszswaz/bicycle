set(MODULE_NAME "fsort")

message(STATUS ${MODULE_NAME})

add_executable(
    ${MODULE_NAME}
    main.c
    options.c
)

target_link_libraries(${MODULE_NAME} ref_array)
