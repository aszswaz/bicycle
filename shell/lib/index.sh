#!/bin/zsh

# 本文件夹下的 shell 脚本，并不作为独立的工具使用，仅仅只是给别的脚本提供通用的function、alias
# author: aszswaz
# date: 2022-03-09 16:15:01

# 打印错误信息
function print_error() {
    echo -e "\033[31m" $@ "\033[0m" >&2
}
