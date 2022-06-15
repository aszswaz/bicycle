" 自定义函数

" 插件中的 gitbranch#name 函数只返回分支名称，这里加上一个 unicode 的电路图标表示 git 图标
function! Gitbranchicon()
    let branchname=gitbranch#name()
    if empty(branchname)
        return ""
    else
        return " " . branchname
    endif
endfunction

" 显示用户名称
function! Username()
    return $USER
endfunction

" 根据文件类型，调用不同的外部命令，格式化文件
function! FileFormat()
    " 获取光标所在行
    let cursorLine = line(".")
    let filetype = &filetype

    " 根据当前缓冲区的文件类型，格式化文件
    if filetype == 'json'
        %!jq .
    elseif filetype == 'cpp' || filetype == "c"
        %!astyle --style=java --indent=spaces=4 --pad-oper -N -C --indent-labels -xw -xW -w --mode=c
    elseif filetype == "java"
        %!astyle --style=java --indent=spaces=4 --mode=java
    elseif filetype == 'sh' || filetype == "zsh"
        %!shfmt -i 4
    elseif filetype == 'javascript' || filetype == "js" || filetype == "typescript"
        %!js-beautify
    elseif filetype == 'python'
        %!autopep8 --max-line-length 10000 -
    elseif filetype == 'lua'
        %!stylua - --indent-type Spaces --indent-width 4
    elseif filetype == 'tex' || filetype == "plaintex"
        %!latexindent
    elseif filetype == "xml"
        %!xmllint --format -
    else
        echo "Formatting of " . filetype  . " files is not currently supported."
        return
    endif

    " 控制光标回到原位
    execute cursorLine
endfunction

" 关闭当前标签，其实是关闭 vim 的 buffer，但是 romgrk/barbar.nvim 插件会把 buffer 作为标签页，所以关闭 buffer 相当于关闭标签页
function! CloseTab()
    let current_buffer = bufnr("%")
    " 如果当前 buffer 已被用户修改，先保存到文件
    if getbufinfo(current_buffer)[0].changed
        execute "w"
    endif
    " 关闭 buffer
    execute "BufferClose"
endfunction
