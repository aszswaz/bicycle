#!/bin/zsh

cd $(dirname $0)

pip install -r requirements.txt

# 将可执行的 python 文件链接到 ../bin 目录
for file in $(find ! -path '*/venv/*' -name '*.py'); do
    if [ -x $file ] && [ ! -e "../bin/$(basename $file)" ]; then
        ln -s "$(realpath $file)" "../bin/$(basename $file)"
    fi
done
