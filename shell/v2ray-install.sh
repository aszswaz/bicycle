#!/bin/sh

# 这个脚本用于对 v2ray，进行一些常规的初始化操作，比如安装 neovim

alias curl="curl -L -fsSL"

if ! command -v yum >>/dev/null; then
    echo -e "\033[92myum not found\033[0m"
    exit 1
fi

set -e

# 安装 git 和 zsh
if ! command -v git >>/dev/null; then
    sudo yum install -y git
fi
if ! command -v zsh >>/dev/null; then
    sudo yum install -y zsh
fi
# 安装 oh-my-zsh
if [[ ! -e $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 安装 neovim
if ! command -v nvim >>/dev/null; then
    curl https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.tar.gz --output nvim-linux64.tar.gz
    tar zxvf nvim-linux64.tar.gz
    sudo mv nvim-linux64 /usr/local/share/nvim-linux64
    sudo ln -s /usr/local/share/nvim-linux64/bin/nvim /usr/local/bin/nvim
    command -v vi >>/dev/null && rm $(command -v vi)
    sudo ln -s /usr/local/share/nvim-linux64/bin/nvim /usr/local/bin/vi
fi

# 安装 unzip
if ! command -v unzip >>/dev/null; then
    sudo yum install -y unzip
fi

# 安装 v2ray
if ! command -v v2ray >>/dev/null; then
    curl https://github.com/v2fly/v2ray-core/releases/download/v4.45.2/v2ray-linux-64.zip
    unzip v2ray-linux-64.zip -d /usr/local/share/v2ray
    sudo ln -s /usr/local/share/v2ray/v2ray /usr/local/bin/v2ray
    sudo nvim /usr/local/share/v2ray/systemd/system/v2ray.service
    sudo ln -s /usr/local/share/v2ray/systemd/system/v2ray.service  /usr/lib/systemd/system/v2ray.service
    sudo systemctl daemon-reload
    sudo systemctl enable v2ray
    rm v2ray-linux64.tar.gz
fi
