#!/bin/zsh

cd "$(dirname $0)"

# 要想使用 neovim 所必须拥有的二进制
require_commands=('git' 'curl' 'lolcat')
# 通过包管理器安装软件包
if command -v pacman >>/dev/null 2>&1; then
    sudo pacman -Sy
    for require_command in ${require_commands}; do
        if ! command -v "${require_command}" >>/dev/null 2>&1; then
            sudo pacman -S "${require_command}" || exit 1
        fi
    done
else
    # 没有发现任何包管理器
    for require_command in ${require_commands}; do
        if ! command -v "$require_command" >>/dev/null 2>&1; then
            echo "\033[33mCommand ${require_command} is not installed.\033[0m"
            exit 1
        fi
    done
fi

# 当前文件夹映射到 nvim 的默认配置文件路径
if [[ ! -e "$HOME/.config/nvim" ]]; then
    ln -s "$PWD" "$HOME/.config/nvim"
fi

# 添加 vim 包管理器
# packer，github：https://github.com/wbthomason/packer.nvim
PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
[[ ! -e "$PACKER_PATH" ]] && git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_PATH"
# vim-plug，github：https://github.com/junegunn/vim-plug
VIM_PLUG_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
[[ ! -e "$VIM_PLUG_PATH" ]] && curl --disable -fLo "$VIM_PLUG_PATH" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
