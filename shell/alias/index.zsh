#!/bin/zsh

# 将手机屏幕投影到电脑，需要安装 adb 和 scrcpy
alias android_screen='nohup scrcpy --turn-screen-off 2>&1 >> /dev/null &'
# 指定解压zip文件时，使用的文件编码，防止出现中文乱码
alias unzip="unzip -O UTF-8"
# 一个简单的 http 命令行服务器
alias httpserver="python -m http.server 8080"

# 编辑这个脚本
alias edit_public_alias="nvim $0; source $0"

# 覆盖cp命令
alias cp="cp -v -r"
# 覆盖rm命令，递归删除文件夹
alias rm="rm -r"
# 列出文档仓库中所有的文本文件
alias doc_ls="find ${DOCUMENT_HOME} ! -regex '.*/\.git/.*' ! -path '*/node_modules/*' ! -ipath '*/dist/*' ! -name '*.jpg' ! -name '*.zip' ! -name '*.svg' ! -name '*.png' -type f"

# maven 编译项目时指定使用 jdk8
alias mvn="JAVA_HOME=/usr/lib/jvm/java-8-openjdk/ mvn"

# cmake 项目编译
alias cmake_build="cmake -S ./ -B ./builder && cmake --build ./builder"
# 为 C、C++ 代码生成函数、全局变量、宏的索引，供 VIM 使用
alias ctags="ctags -I __THROW --extras=+F --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R"
# 生成系统中，所有库的索引，这个可以用于 vim，让 vim 跳转到函数、全局变量、宏的声明位置
alias systags="ctags -f ~/.config/nvim/systags /usr/include /usr/local/include"
# 生成 C、C++ 项目的代码索引
alias srctags="ctags -f tags ./src ./lib"
# Cmake 项目生成 Makefile
alias cmake_make="cmake -S ./ -B ./builder -DCMAKE_EXPORT_COMPILE_COMMANDS=on && test -e compile_commands.json || ln ./builder/compile_commands.json compile_commands.json"

# 输出文件树时，忽略文件夹
alias tree="tree -I '.git' -I 'node_modules' -I 'electron-builder'"
# 加载 node_modules/bin 到 PATH
alias source_node_bin="test -d ./node_modules/.bin && NODE_BIN='$(pwd)/node_modules/.bin' && test '$NODE_BIN' '=~' '$PATH' || PATH=$PATH:$NODE_BIN"

# mongodb 的链接信息都存储在 ~/.mongorc.js 中所以这里就不需要在参数中进行指定
alias mongo="mongo --nodb"
alias mongosh="mongosh --nodb"
