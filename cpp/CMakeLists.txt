# 要求 cmake 版本
cmake_minimum_required(VERSION 3.22.2)
project(bicycle)

message(STATUS "cmake binary directory: ${CMAKE_BINARY_DIR}")

# Compile commands are output to "compile_commands.json", so that tools such as "ccls" can provide assistance.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# Set gcc compile options.
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -Wall -g3 -ggdb")
set(CMAKE_C_FLAGS_DEBUG "$ENV{CFLAGS} -Wall -g3 -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
set(CMAKE_C_FLAGS_RELEASE "$ENV{CFLAGS} -O3 -Wall")

# submodule
add_subdirectory(./message)
add_subdirectory(./fsort)
add_subdirectory(./v2ray-ping)
add_subdirectory(./container)
add_subdirectory(./thread-pool)
add_subdirectory(./langfmt)

# The target that needs to be installed when "make install" is executed.
install(TARGETS message)
install(TARGETS fsort)
install(TARGETS v2ray-ping)
install(TARGETS container)
install(TARGETS thread_pool)
install(TARGETS langfmt)
