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
