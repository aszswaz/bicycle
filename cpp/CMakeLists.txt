# 要求 cmake 版本
cmake_minimum_required(VERSION 3.22.2)
project(bicycle)

# C++ 标准
set(CMAKE_CXX_STANDARD 14)
# 编译命令输出到 complie_commands.json，让 ccls 等工具可以提供辅助
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# 子模块
add_subdirectory(./src/message)

# 程序的安装命令
install(TARGETS message)
