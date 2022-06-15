" 自定义函数

" 插件中的 gitbranch#name 函数只返回分支名称，这里加上一个 unicode 的电路图标表示 git 图标
:function! Gitbranchicon()
    let branchname=gitbranch#name()
    if empty(branchname)
        return ""
    else
        return " " . branchname
    endif
:endfunction

" 显示用户名称
:function! Username()
    return $USER
:endfunction

" 根据文件类型，调用不同的外部命令，格式化文件
:function! FileFormat()
    " 获取光标所在行
    let cursorLine = line(".")
    let filetype = &filetype
    " 缩进宽度
    let tab_width = 4

    " 根据当前缓冲区的文件类型，格式化文件
    if filetype == 'json'
        execute "%!jq ."
    elseif filetype == 'cpp' || filetype == "c"
        execute "%!astyle --style=java --indent=spaces=" . tab_width . " --pad-oper -N -C --indent-labels -xw -xW -w --mode=c"
    elseif filetype == "java"
        execute "%!astyle --style=java --indent=spaces=" . tab_width . " --mode=java"
    elseif filetype == 'sh' || filetype == "zsh"
        execute "%!shfmt -i " . tab_width
    elseif filetype == 'javascript' || filetype == "js" || filetype == "typescript" || filetype == "ts"
        execute "%!prettier --parser typescript --print-width 160 --tab-width " . tab_width
    elseif filetype == 'css' || filetype == "scss" || filetype == "less" || filetype == "graphql" || filetype == "markdown" || filetype == "vue" || filetype == "html"
        execute "%!prettier --parser " . filetype . " --print-width 160 --tab-width " . tab_width
    elseif filetype == 'python'
       execute "%!autopep8 --max-line-length 10000 -"
    elseif filetype == 'lua'
        execute "%!stylua - --indent-type Spaces --indent-width " . tab_width . " --call-parentheses None --quote-style AutoPreferDouble"
    elseif filetype == 'tex' || filetype == "plaintex"
        execute "%!latexindent"
    elseif filetype == "xml"
        execute "%!xmllint --encode \"UTF-8\" --format -"
    else
        echo "Formatting of " . filetype  . " files is not currently supported."
        return
    endif

    " 控制光标回到原位
    execute cursorLine
:endfunction

" 关闭当前标签，其实是关闭 vim 的 buffer，但是 romgrk/barbar.nvim 插件会把 buffer 作为标签页，所以关闭 buffer 相当于关闭标签页
:function! CloseTab()
    " 获得当前 buffer 的序号
    let current_buffer = bufnr("%")
    " 如果当前 buffer 已被用户修改，先保存到文件
    if getbufinfo(current_buffer)[0].changed
        execute "w"
    endif
    " 关闭 buffer
    execute "BufferClose"
:endfunction
