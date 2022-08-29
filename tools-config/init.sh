#!/bin/sh -e

cd "$(dirname $0)"

source ../shell/lib/index.sh

log_info "init tools-config."

# emacs
if [[ -L "$HOME/.emacs" ]]; then
    if [[ "$(readlink "$HOME/.emacs")" != "$PWD/emacs.el" ]]; then
        rm "$HOME/.emacs"
        ln -s "$PWD/emacs.el" "$HOME/.emacs"
    fi
else
    [[ -e "$HOME/.emacs" ]] && rm "$HOME/.emacs"
    ln -s "$PWD/emacs.el" "$HOME/.emacs"
fi

# gdb
if [[ -L "$HOME/.gdbinit" ]]; then
    if [[ "$(readlink "$HOME/.gdbinit")" != "$PWD/gdbinit" ]]; then
        rm "$HOME/.gdbinit"
        ln -s "$PWD/gdbinit" "$HOME/.gdbinit"
    fi
else
    [[ -e "$HOME/.gdbinit" ]] && rm "$HOME/.gdbinit"
    ln -s "$PWD/gdbinit" "$HOME/.gdbinit"
fi

log_info "init tools-config success"
