#!/bin/zsh

# 在计算机上进行初始化，以使用仓库中的脚本、neovim 配置等。

# 切换路径到 init.sh 脚本所在文件夹
WORK_DIR="$PWD"
cd $(dirname $0)

export PORJECT_DIR="$PWD"
export BIN_PATH="$PWD/bin"
export SHELL_LIB="$PWD/shell/lib"

source "$SHELL_LIB/index.sh"

# 判断系统内核名称
kernel=$(uname -s)
if [[ $kernel == "" ]]; then
    log_error "Unknown OS."
    exit $?
elif [[ $kernel != "Linux" ]]; then
    log_error "The script is only available on Linux systems."
    exit 1
fi

# 判断 Linux 发行版名称
release=$(uname -r)
echo "Kernel:" "${kernel}" ",release:" "${release}"
if [[ ${release} == "" ]]; then
    log_error "Unknown release." >&2
    exit 1
elif [[ ! $release =~ "MANJARO" ]]; then
    log_error "This repository is recommended to be used under the Manjaro operating system."
    exit 1
fi

# 判断脚本解释器
if [[ $SHELL != "/usr/bin/zsh" ]]; then
    log_error "It is recommended to use zsh as the shell interpreter to execute scripts in the repository."
    exit 1
fi

[[ ! -e "bin" ]] && mkdir bin
# 使用 gdb 的初始化设置
[[ ! -e "$HOME/.gdbinit" ]] && ln -s "$PWD/gdbinit" "$HOME/.gdbinit"

# 获取子模块
git submodule init

# 任何一步执行失败，立刻退出脚本，避免忽略或累积错误
./shell/init.sh
# 把 Linux 手册安装到系统
./man/init.sh
# 编译 CPP 程序
./cpp/init.sh
# 应用 emacs 的配置文件
./emacs/init.sh
# 初始化 Python env 环境
./python/init.sh
# 初始化 neovim
./neovim/init.sh
# 初始化个人私有配置
./bicycle-config/init.sh

cd "$WORK_DIR"
