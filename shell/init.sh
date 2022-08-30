#!/bin/sh -e

cd "$(dirname $0)"

source ./lib/index.sh

log_info "init shell..."

# 建立项目的软链接
[[ ! -e "$HOME/.bicycle" ]] && ln -s "$PROJECT_DIR" "$HOME/.bicycle"

# 替换 $HOME/.config/fish/config.fish
if [[ -L "$HOME/.config/fish/config.fish" ]]; then
    if [[ $(readlink "$HOME/.config/config.fish") != "$PWD/fish.fish" ]]; then
        rm "$HOME/.config/fish/config.fish"
        ln -s "$PWD/fish.fish" "$HOME/.config/fish/config.fish"
    fi
else
    [[ -e "$HOME/.config/fish/config.fish" ]] && rm "$HOME/.config/fish/config.fish"
    ln -s "$PWD/fish.fish" "$HOME/.config/fish/config.fish"
fi

# 安装 oh-my-fish
if [[ ! -e $HOME/.config/fish/conf.d/omf.fish ]]; then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

log_info "init shell success"
