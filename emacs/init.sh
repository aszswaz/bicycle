#!/bin/zsh

[[ ! -e "$HOME/.emacs" ]] && ln -s "$PWD/emacs.el" "$HOME/.emacs"
