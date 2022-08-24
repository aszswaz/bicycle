WORK_DIR="$PWD"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
# oh-my-zsh 主题 https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fino-time"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# 自定义脚本设置
bicycle_path="$HOME/.bicycle"
cd "$bicycle_path"

cd "shell"
source "alias/index.sh"
source "$bicycle_path/bicycle-config/profile.sh"
source "$bicycle_path/bicycle-config/alias.sh"

# 设置文件夹背景色
eval "$(dircolors dir_colors)"
[[ ! -e "${HOME}/.dir_colors" ]] && ln -s "$PWD/dir_colors" "${HOME}/.dir_colors"

# gdb 调试信息库
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

[[ $PWD != $WORK_DIR ]] && cd "$WORK_DIR"
unset bicycle_path WORK_DIR
