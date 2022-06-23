#!/bin/zsh -e

source "$SHELL_LIB/index.sh"

cd $(dirname $0)
log_info "init python ..."

pacman_install python python-pip
pip install -r requirements.txt

# 将可执行的 python 文件链接到 ../bin 目录
for file in $(find ! -path '*/venv/*' -name '*.py'); do
    if [ -x $file ]; then
        link_target="$BIN_PATH/$(basename $file)"
        file=$(realpath $file)
        if [[ -e $link_target ]]; then
            if [[ $(readlink $link_target) != $file ]]; then
                rm $link_target
                ln -s $file $link_target
            fi
        else
            ln -s $file "$link_target"
        fi
    fi
done

log_info "init python success"
