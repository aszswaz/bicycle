#!/bin/zsh

source "$SHELL_LIB/index.sh"

cd $(dirname $0)
log_info "init emacs..."

if [[ -e "$HOME/.emacs" ]]; then
    if [[ $(readlink "$HOME/.emacs") != "$PWD/emacs.el" ]]; then
        rm "$HOME/.emacs"
        ln -s "$PWD/emacs.el" "$HOME/.emacs"
    fi
else
    ln -s "$PWD/emacs.el" "$HOME/.emacs"
fi
log_info "init emacs success"
