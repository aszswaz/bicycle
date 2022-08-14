set(MODULE_NAME "message")

message(STATUS ${MODULE_NAME})

add_executable(
    ${MODULE_NAME}
    main.cpp
    src/MessageOptions.cpp
    src/NotifyUser.cpp
)

# 添加依赖
# QT5
find_package(Qt5 COMPONENTS Widgets REQUIRED)
target_link_libraries(${MODULE_NAME} PRIVATE Qt5::Widgets)
