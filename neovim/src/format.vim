" 通过外部工具格式化文件

" 根据文件后缀名，设置不同的外部格式化工具
:autocmd BufNewFile,BufRead *.json set formatprg=jq\ .
execute("autocmd BufNewFile,BufRead *.java set formatprg=astyle\\ --style=java\\ --indent=spaces=" . &tabstop . "\\ --mode=java")
:autocmd BufNewFile,BufRead *.py   set formatprg=autopep8\ --max-line-length\ 10000\ -
execute("autocmd BufNewFile,BufRead *.lua  set formatprg=stylua\\ -\\ --indent-type\\ Spaces\\ --indent-width\\ " . &tabstop . "\\ --call-parentheses\\ None\\ --quote-style\\ AutoPreferDouble")
:autocmd BufNewFile,BufRead *.tex  set formatprg=latexindent
:autocmd BufNewFile,BufRead *.xml  set formatprg=xmllint\ --encode\ UTF-8\ --format\ -

execute("autocmd BufNewFile,BufRead *.cpp  set formatprg=astyle\\ --style=java\\ --indent=spaces=" . &tabstop . "\\ --pad-oper\\ -N\\ -C\\ --indent-labels\\ -xw\\ -xW\\ -w\\ --mode=c")
execute("autocmd BufNewFile,BufRead *.c    set formatprg=astyle\\ --style=java\\ --indent=spaces=" . &tabstop . "\\ --pad-oper\\ -N\\ -C\\ --indent-labels\\ -xw\\ -xW\\ -w\\ --mode=c")

execute("autocmd BufNewFile,BufRead *.sh   set formatprg=shfmt\\ -i\\ " . &tabstop)
execute("autocmd BufNewFile,BufRead *.zsh  set formatprg=shfmt\\ -i\\ " . &tabstop)

execute("autocmd BufNewFile,BufRead *.js   set formatprg=prettier\\ --parser\\ typescript\\ --print-width\\ 160\\ --tab-width\\ " . &tabstop)
execute("autocmd BufNewFile,BufRead *.ts   set formatprg=prettier\\ --parser\\ typescript\\ --print-width\\ 160\\ --tab-width\\ " . &tabstop)

execute("autocmd BufNewFile,BufRead *.css  set formatprg=prettier\\ --parser\\ css\\ --print-width\\ 160\\ --tab-width\\ " . &tabstop)
execute("autocmd BufNewFile,BufRead *.scss set formatprg=prettier\\ --parser\\ scss\\ --print-width\\ 160\\ --tab-width\\ " . &tabstop)
execute("autocmd BufNewFile,BufRead *.less set formatprg=prettier\\ --parser\\ less\\ --print-width\\ 160\\ --tab-width\\ ". &tabstop)
execute("autocmd BufNewFile,BufRead *.md   set formatprg=prettier\\ --parser\ markdown\\ --print-width\\ 160\\ --tab-width\\ ". &tabstop)
execute("autocmd BufNewFile,BufRead *.vue  set formatprg=prettier\\ --parser\\ vue\\ --print-width\\ 160\\ --tab-width\\ " . &tabstop)
execute("autocmd BufNewFile,BufRead *.html set formatprg=prettier\\ --parser\\ html\\ --print-width\\ 160\\ --tab-width\\ " . &tabstop)

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
