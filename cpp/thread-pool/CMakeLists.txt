set(MODULE_NAME thread_pool)
message(STATUS "module: ${MODULE_NAME}")
set(
    SOURCE
    thread_pool.c
)

add_library(${MODULE_NAME} SHARED ${SOURCE})
add_library(${MODULE_NAME}_static STATIC ${SOURCE})
set_target_properties(${MODULE_NAME} PROPERTIES CLEAN_DIRECT_OUTPUT 1)
set_target_properties(${MODULE_NAME}_static PROPERTIES OUTPUT_NAME ${MODULE_NAME})
set_target_properties(${MODULE_NAME}_static PROPERTIES CLEAN_DIRECT_OUTPUT 1)

target_link_libraries(${MODULE_NAME} container_static)
target_link_libraries(${MODULE_NAME}_static container_static)

if (CMAKE_BUILD_TYPE STREQUAL debug)
    # unit test
    add_executable(
        ${MODULE_NAME}_test
        test/main.c
        ${SOURCE}
    )
    set_target_properties(${MODULE_NAME}_test PROPERTIES OUTPUT_NAME ${MODULE_NAME})
    set_target_properties(${MODULE_NAME}_test PROPERTIES CLEAN_DIRECT_OUTPUT 1)
    target_link_libraries(${MODULE_NAME}_test container_static)
endif()
