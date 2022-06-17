" 通过外部工具格式化文件

" 根据文件后缀名，设置不同的外部格式化工具
execute("autocmd FileType json                            set formatprg=jq\\ .")
execute("autocmd FileType java                            set formatprg=astyle\\ --style=java\\ --indent=spaces=" . &tabstop . "\\ --mode=java")
execute("autocmd FileType python                          set formatprg=autopep8\\ --max-line-length\\ 10000\\ -")
execute("autocmd FileType lua                             set formatprg=stylua\\ -\\ --indent-type\\ Spaces\\ --indent-width\\ " . &tabstop . "\\ --call-parentheses\\ None\\ --quote-style\\ AutoPreferDouble")
execute("autocmd FileType tex,latex                       set formatprg=latexindent")
execute("autocmd FileType xml                             set formatprg=xmllint\\ --encode\\ UTF-8\\ --format\\ -")
execute("autocmd FileType cpp,c                           set formatprg=astyle\\ --style=java\\ --indent=spaces=" . &tabstop . "\\ --pad-oper\\ -N\\ -C\\ --indent-labels\\ -xw\\ -xW\\ -w\\ --mode=c")
execute("autocmd FileType sh,zsh,bash                     set formatprg=shfmt\\ -i\\ " . &tabstop)
execute("autocmd FileType typescript,javascript,js        set formatprg=prettier\\ --parser\\ typescript\\ --print-width\\ 160\\ --tab-width\\ " . &tabstop)
execute("autocmd FileType css,scss,less,markdown,vue,html set formatprg=prettier\\ --parser\\ " . &filetype . "\\ --print-width\\ 160\\ --tab-width\\ " . &tabstop)

:function! FileFormat()
    " 获取当前行号
    let cl = line(".")
    let m = mode()
    " 执行格式化，ggvG 为全选，gq 是调用上方 formatprg 设置的外部工具
    if m == "v"
        " normal! 用于模拟键盘输入，这里是用于调用快捷键
        normal! ggGgq
    else
        normal! ggvGgq
    endif
    " 光标回到到原本的行
    execute("normal! " . cl . "G")
:endfunction
