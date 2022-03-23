# 编译命令输出到 complie_commands.json，让 ccls 等工具可以提供辅助
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

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
