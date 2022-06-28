#!/bin/zsh -e

source "$SHELL_LIB/index.sh"

cd $(dirname $0)

log_info "init shell..."

# 建立项目的软链接
[[ ! -e "$HOME/.bicycle" ]] && ln -s "$PROJECT_DIR" "$HOME/.bicycle"

# 安装 oh-my-zsh
if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 替换 .zshrc
if [[ -e "$HOME/.zshrc" ]]; then
    if [[ $(readlink "$HOME/.zshrc") != "$PWD/.zshrc" ]]; then
        rm "$HOME/.zshrc"
        ln -s "$PWD/zshrc" "$HOME/.zshrc"
    fi
else
    ln -s "$PWD/zshrc.sh" "$HOME/.zshrc"
fi

log_info "init shell success"
