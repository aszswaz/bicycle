#!/bin/zsh -e

cd "$(dirname $0)"

source ./lib/index.sh

log_info "init shell..."

# 建立项目的软链接
[[ ! -e "$HOME/.bicycle" ]] && ln -s "$PROJECT_DIR" "$HOME/.bicycle"

# 安装 oh-my-zsh
if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 替换 .zshrc
if [[ -L "$HOME/.zshrc" ]]; then
    if [[ $(readlink "$HOME/.zshrc") != "$PWD/zshrc.sh" ]]; then
        rm "$HOME/.zshrc"
        ln -s "$PWD/zshrc.sh" "$HOME/.zshrc"
    fi
else
    [[ -e "$HOME/.zshrc" ]] && rm "$HOME/.zshrc"
    ln -s "$PWD/zshrc.sh" "$HOME/.zshrc"
fi

log_info "init shell success"
