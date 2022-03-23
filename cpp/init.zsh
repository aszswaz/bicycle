#!/bin/zsh

cd $(dirname $0)

# 编译并安装项目
[ -d "./builder" ] || mkdir builder
cd builder/
cmake -DCMAKE_INSTALL_PREFIX="$(realpath ../../)" ../
make
make install
cd ../
rm -rf ./builder
