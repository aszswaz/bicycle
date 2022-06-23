#!/bin/zsh -e

source "$SHELL_LIB/index.sh"

cd "$(dirname $0)"
log_info "init neovim..."

# 这些软件包都在 neovim 的脚本中应用，主要的软件包介绍如下
# astyle：格式化 C、C++、Java 代码
# autopep8：格式化 Python 代码
# stylua：格式化 lua 代码
# texlive-latexindent-meta：格式化 latex 代码
# libxml2：用于操作 xml 的，主要使用的是软件包中的 xmllint，用来格式化 xml
# shfmt：格式化 shell 代码
# prettier：格式化 js、html、css、scss、less 代码
# xclip：这是一个 C 的依赖库，neovim 需要通过它才能把选中内容发送到系统剪切板
yay_install 'neovim-qt' 'git' 'curl' \
            'jq' 'astyle' 'autopep8' 'stylua' 'texlive-latexindent-meta' \
            'libxml2' 'shfmt' 'prettier' \
            'xclip'

# 当前文件夹映射到 nvim 的默认配置文件路径
if [[ ! -e "$HOME/.config/nvim" ]]; then
    ln -s "$PWD" "$HOME/.config/nvim"
fi

# 添加 vim 包管理器当当前用户和 root 用户
# packer，github：https://github.com/wbthomason/packer.nvim
nvim_share="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
packer_path="$nvim_share/site/pack/packer/start/packer.nvim"
[[ ! -e "$packer_path" ]] && git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_path"
# vim-plug，github：https://github.com/junegunn/vim-plug
vim_plug_path="$nvim_share/site/autoload/plug.vim"
[[ ! -e "$vim_plug_path" ]] && curl --disable -fLo "$vim_plug_path" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 将 maven 配置应用到 root 账户
sudo zsh -c "[[ ! -e '/root/.config' ]] && mkdir '/root/.config' || exit 0"
sudo zsh -c "[[ ! -e '/root/.local/share' ]] && mkdir '/root/.local/share' || exit 0"
sudo zsh -c "[[ ! -e '/root/.config/nvim' ]] && ln -s '$PWD' '/root/.config/nvim' || exit 0"
sudo zsh -c "[[ ! -e '/root/.local/share/nvim' ]] && ln -s '$nvim_share' '/root/.local/share/nvim' || exit 0"
log_info "init neovim sucess"
