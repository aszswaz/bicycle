#!/bin/zsh

source "$SHELL_LIB/index.sh"

cd $(dirname $0)

pacman_install cmake make gcc

log_info "init cpp..."
# 编译并安装项目
[ -d "./builder" ] || mkdir builder
cd builder/
cmake -DCMAKE_INSTALL_PREFIX="$BIN_PATH" ../
make
make install
cd ../
rm -rf ./builder
log_info "init cpp success"
