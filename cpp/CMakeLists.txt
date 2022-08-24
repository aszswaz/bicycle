# 要求 cmake 版本
cmake_minimum_required(VERSION 3.22.2)
project(bicycle)

# 编译命令输出到 complie_commands.json，让 ccls 等工具可以提供辅助
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# gdb 调试设置
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -O0 -g3 -ggdb")
set(CMAKE_C_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -O0 -g3 -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
set(CMAKE_C_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
# C++ 标准
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 11)

# 子模块
add_subdirectory(./src/message)
add_subdirectory(./src/fsort)
add_subdirectory(./src/v2ray-ping)

# 程序的安装命令
install(TARGETS message)
install(TARGETS fsort)
install(TARGETS v2ray-ping)
