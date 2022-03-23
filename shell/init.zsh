#!/bin/zsh

BIN_PATH="$(dirname $0)/bin"
if [[ ! $PATH =~ $BIN_PATH ]]; then
    export PATH="${PATH}:${BIN_PATH}"
fi
source "$(dirname $0)/alias/index.zsh"
