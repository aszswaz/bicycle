#!/bin/zsh

# 在计算机上进行初始化，以使用仓库中的脚本、neovim 配置等。

# 切换路径到 init.sh 脚本所在文件夹
cd $(dirname $0)

source ./shell/lib/index.sh

# 判断系统内核名称
kernel=$(command uname -s)
if [[ $kernel == "" ]]; then
    echo "Unknown OS." >&2
    exit $?
elif [[ $kernel != "Linux" ]]; then
    echo "The script is only available on Linux systems." >&2
    exit 1
fi

# 判断 Linux 发行版名称
release=$(command uname -r)
echo "Kernel:" "${kernel}" ",release:" "${release}"
if [[ ${release} == "" ]]; then
    echo "Unknown release." >&2
    exit 1
elif [[ ! $release =~ "MANJARO" ]]; then
    echo "Warning: This repository is recommended to be used under the Manjaro operating system." >&2
fi

# 判断脚本解释器
if [[ $SHELL != "/usr/bin/zsh" ]]; then
    echo "Warning: It is recommended to use zsh as the shell interpreter to execute scripts in the repository." >&2
fi

# 应用 neovim 的配置
NEOVIM_CONFIG="${HOME}/.config/nvim"
if [[ ! -e ${NEOVIM_CONFIG} ]]; then
    # 建立软链接
    ln -s "$(pwd)/neovim" "${NEOVIM_CONFIG}"
fi

# 把 Linux 手册安装到系统
sudo ./man/init.sh

# 检查系统中是否存在执行脚本，所需的软件
COMMANDS=(curl jq git python realpath cmake gcc makepkg)
for item in $COMMANDS; do
    if ! command -v $item >>/dev/null; then
        print_error "Please install ${item}."
        exit 1
    fi
done

# 把 shell/init.zsh 添加到 ~/.zshrc 当中
zshrc=$(<~/.zshrc)
shell_init="$(pwd)/shell/init.zsh"
if [[ ! "${zshrc}" =~ "${shell_init}" ]]; then
    zshrc="${zshrc}\nsource ${shell_init}"
fi
# 把私有配置文件的加载，添加到 ~/.zshrc
if [[ ! "${zshrc}" =~ "${HOME}/.config/bicycle-config/init.zsh" ]]; then
    test -d "${HOME}/.config/bicycle-config" || git clone 'ssh://git@gitea.aszswaz.cn:3001/aszswaz/bicycle-config.git' "${HOME}/.config/bicycle-config"
    zshrc="${zshrc}\nsource ${HOME}/.config/bicycle-config/init.zsh"
fi

# 设置环境变量
script="[[ \$PATH == *${PWD}/bin* ]] || export PATH=\"\${PATH}:${PWD}/bin\""
[[ "$zshrc" == *$script* ]] || zshrc="${zshrc}\n${script}"
echo "${zshrc}" >~/.zshrc

# 编译 CPP 程序
./cpp/init.zsh
# 应用 emacs 的配置文件
./emacs/init.sh
# 初始化 Python env 环境
./python/install.sh
