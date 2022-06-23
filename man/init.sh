#!/bin/zsh

# 把自定义脚本的手册安装到系统当中

source "$SHELL_LIB/index.sh"

cd $(dirname $0)

# 手册压缩文件保存路径
MAN_DIR="/usr/share/man/zh_CN/man1"
MAN_FILEPATH="${MAN_DIR}/bicycle.1.gz"

log_info "Document dir:" $PWD "; Manual output path:" $MAN_FILEPATH

set -e
if [[ ! -d ${MAN_DIR} ]]; then
    sudo mkdir "${MAN_DIR}"
elif [[ -e "${MAN_FILEPATH}" ]]; then
    # 删除原文件
    sudo rm "${MAN_FILEPATH}"
fi


# 打包所有 Markdown 文档
file_count=$(ls -l | grep "\.md$" | wc -l)
if [[ $file_count > 0 ]]; then
    for file in $(pwd)/*.md; do
        man_code="${man_code}\n$(< $file)"
    done
    unset file
    echo $man_code | gzip -c - >> /dev/shm/bicycle.1.gz
    sudo mv /dev/shm/bicycle.1.gz $MAN_FILEPATH
fi
set +e
