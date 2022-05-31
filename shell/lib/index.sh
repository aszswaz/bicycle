#!/bin/zsh

# 本文件夹下的 shell 脚本，并不作为独立的工具使用，仅仅只是给别的脚本提供通用的function、alias
# author: aszswaz
# date: 2022-03-09 16:15:01

# 打印错误信息
function print_error() {
    echo -e "\033[31m" $@ "\033[0m" >&2
}

# 给 chromium 设置代理
function chromium_set_proxy() {
    command_path="/usr/bin/chromium"
    [[ ! -e "$command_path" ]] && print_error "Please install chromium first." && exit 1
    proxy="$http_proxy"
    [[ $proxy == "" ]] && proxy="$https_proxy"

    new_command=""
    if [[ $proxy != "" ]]; then
        new_command="$command_path --proxy-server='$proxy'"
    else
        new_command="$command_path"
    fi
    echo "run command: ${new_command}"
    eval "$new_command"
    unset command_path proxy new_command
}
