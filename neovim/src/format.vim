" 通过外部工具格式化文件

:autocmd BufNewFile,BufRead *.json set formatprg=jq\ .
:autocmd BufNewFile,BufRead *.java set formatprg=astyle\ --style=java\ --indent=spaces=4\ --mode=java
:autocmd BufNewFile,BufRead *.py   set formatprg=autopep8\ --max-line-length\ 10000\ -
:autocmd BufNewFile,BufRead *.lua  set formatprg=stylua\ -\ --indent-type\ Spaces\ --indent-width\ 4\ --call-parentheses\ None\ --quote-style\ AutoPreferDouble
:autocmd BufNewFile,BufRead *.tex  set formatprg=latexindent
:autocmd BufNewFile,BufRead *.xml  set formatprg=xmllint\ --encode\ UTF-8\ --format\ -

:autocmd BufNewFile,BufRead *.cpp  set formatprg=astyle\ --style=java\ --indent=spaces=4\ --pad-oper\ -N\ -C\ --indent-labels\ -xw\ -xW\ -w\ --mode=c
:autocmd BufNewFile,BufRead *.c    set formatprg=astyle\ --style=java\ --indent=spaces=4\ --pad-oper\ -N\ -C\ --indent-labels\ -xw\ -xW\ -w\ --mode=c

:autocmd BufNewFile,BufRead *.sh   set formatprg=shfmt\ -i\ 4
:autocmd BufNewFile,BufRead *.zsh  set formatprg=shfmt\ -i\ 4

:autocmd BufNewFile,BufRead *.js   set formatprg=prettier\ --parser\ typescript\ --print-width\ 160\ --tab-width\ 4
:autocmd BufNewFile,BufRead *.ts   set formatprg=prettier\ --parser\ typescript\ --print-width\ 160\ --tab-width\ 4

:autocmd BufNewFile,BufRead *.css  set formatprg=prettier\ --parser\ css\ --print-width\ 160\ --tab-width\ 4
:autocmd BufNewFile,BufRead *.scss set formatprg=prettier\ --parser\ scss\ --print-width\ 160\ --tab-width\ 4
:autocmd BufNewFile,BufRead *.less set formatprg=prettier\ --parser\ less\ --print-width\ 160\ --tab-width\ 4
:autocmd BufNewFile,BufRead *.md   set formatprg=prettier\ --parser\ markdown\ --print-width\ 160\ --tab-width\ 4
:autocmd BufNewFile,BufRead *.vue  set formatprg=prettier\ --parser\ vue\ --print-width\ 160\ --tab-width\ 4
:autocmd BufNewFile,BufRead *.html set formatprg=prettier\ --parser\ html\ --print-width\ 160\ --tab-width\ 4

" 根据文件类型，调用不同的外部命令，格式化文件
" @Deprecated
:function! FileFormat()
    " 获取光标所在行
    let cursorLine = line(".")
    let filetype = &filetype
    " 缩进宽度
    let tab_width = &tabstop

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
