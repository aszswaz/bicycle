#!/bin/zsh

source "$SHELL_LIB/index.sh"

cd $(dirname $0)

pacman_install cmake make gcc

log_info "init cpp..."
# 编译并安装项目
[ -d "./builder" ] || mkdir builder
cd builder/
cmake -DCMAKE_INSTALL_PREFIX="$PORJECT_DIR" ../
make
make install
cd ../
log_info "init cpp success"
