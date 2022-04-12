#!/bin/zsh

WORK_DIR=$(pwd)
cd $(dirname $0)

BIN_PATH="$(dirname $0)/bin"
if [[ ! $PATH =~ $BIN_PATH ]]; then
    export PATH="${PATH}:${BIN_PATH}"
fi
source "$(dirname $0)/alias/index.zsh"

# 设置文件夹背景色
eval "$(dircolors ./dir_colors)"
[ ! -e "${HOME}/.dir_colors" ] && ln -s "$(pwd)/dir_colors" "${HOME}/.dir_colors"

cd "$WORK_DIR"
