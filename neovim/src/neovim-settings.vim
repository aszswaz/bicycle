" neovim 的基本配置
" 开启语法高亮
:syntax on
" 设置制表符的宽度为4个空格

:set tabstop=4
" 缩进应该跨越的宽度，0表示复制 tabstop 的值，-1 表示复制 shiftwidth 的值
:set softtabstop=0
" shiftwidth 给出用于移位命令的宽度，例如 << , >>和 == .特殊值 0 表示复制 'tabstop' 的值。
:set shiftwidth=0
" 设置 expandtab，缩进总是只使用空格字符。否则，按 <Tab>插入尽可能多的制表字符，并用空格字符完成缩进宽度。
:set expandtab
" 移动文本时将缩进舍入为 'shiftwidth' 的倍数
:set shiftround
" 重现上一行的缩进
:set autoindent
" 设置光标距离窗口最下面的最小行数，比如一个 vim 屏幕的最下方是第 66 行，那么当光标到达第 61 行时就开始向上翻滚。
:set scrolloff=5

" 显示行号
:set number
" 开启光标所在位置的行和列高亮
:set cursorcolumn
:set cursorline

" vim 其他杂项设置
" 关闭备份
:set nobackup
" 编码设置
:set enc=utf-8
:set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
:set langmenu=zh_CN.UTF-8
:set helplang=cn
:set magic
" 配置括号的高亮，ctermbg为背景色，ctermfg为文字颜色
" 开启正则
:hi MatchParen ctermbg=NONE ctermfg=green
" 设置状态栏显示文件名和文件路径
:set laststatus=2
" 自动换行
:set nowrap
" 文件在外部被修改，自动更新
:set autoread
" neovim 会在文本长度达到 78 时，自动添加 \n 拆行，如果直接 :set textwidth=0 那么 textwidth 会在其他的脚本当中被设置为 78，所以这里通过关闭文本格式化的方式，达到禁用该功能的目的
:set fo-=t
" 设置鼠标可点击
:set mouse=a
" 设置新的分屏出现的位置，如果是垂直分屏，新的分屏出现在右边，如果是水平分屏，新的分屏在下边
:set splitright
:set splitbelow
" 一直显示标签栏，默认值为 1，表示存在两个标签时才会显示标签栏
:set showtabline=2
" 启用真彩色
:set termguicolors
" gdb debug 设置，让 GDB 窗口出现在右侧
:let g:termdebug_popup = 0
:let g:termdebug_wide = 163

" 以下是快捷键配置，n开头代表普通模式下的快捷键，i开头是编辑模式下的快捷键，nore是不递归快捷键，map是快捷键映射
" vim普通状态下的保存，<cr>表示回车，执行 :w 命令
:nnoremap <C-s>      :w<cr>
" vim 编辑状态下的保存：<esc>退出编辑模式，:w 保存，<cr> 回车，a 回到编辑模式
:inoremap <C-s>      <esc>:w<cr>a
" 一次性保存所有打开的文件，并关闭 VIM
:nnoremap <C-q>      :wa<cr>:qa!<cr>
:inoremap <C-q>      <esc>:wa<cr>:qa!<cr>
" 撤销
:nnoremap <C-z>      :u<cr>
:inoremap <C-z>      <esc>:u<cr>a
" 重做
:nnoremap <A-z>      :redo<cr>
:inoremap <A-z>      <esc>:redo<cr>a
" 普通模式删除行
:nnoremap <C-y>      dd<End>
" 编辑模式删除行，并吧光标移动到行尾
:inoremap <C-y>      <esc>ddA
" 复制行，yy是复制，p是在新的一行粘贴
:nnoremap <C-d>      yyp<End>
:inoremap <C-d>      <esc>yypA
:inoremap <C-v>      <esc>"+pa
" 复制选中文本到系统剪切板
:vnoremap <C-c>      "+y
" 剪切选中文本到系统剪切板
:vnoremap <C-x>      "+d
" 从剪切板粘贴内容到VIM
:nnoremap <C-v>      "+p
:tnoremap <C-v>      <C-\><C-n>"+pa

" 创建新的标签页
:nnoremap <A-t>      :tabnew<cr>
:inoremap <A-t>      <esc>:tabnew<cr>
:tnoremap <A-t>      <C-\><C-n>:tabnew<cr>
" 向左或向右切换标签页
:nnoremap <A-Left>   :tabNext<cr>
:inoremap <A-Left>   <esc>:tabNext<cr>
:tnoremap <A-Left>   <C-\><C-n>:tabNext<cr>
:nnoremap <A-Right>  :tabnext<cr>
:inoremap <A-Right>  <esc>:tabnext<cr>
:tnoremap <A-Right>  <C-\><C-n>:tabnext<cr>
" 保存文件、关闭缓冲区并关闭标签页
:nnoremap <A-c>      :w<cr>:bd<cr>
:inoremap <A-c>      <esc>:w<cr>:bd<cr>
" 关闭其他标签页
:nnoremap <A-o>      :tabonly<cr>
:inoremap <A-o>      <esc>:tabonly<cr>
:tnoremap <A-o>      <C-\><C-n>:tabonly<cr>

" 上移一整行
:nnoremap <C-Up>     :m -2<cr>
:inoremap <C-Up>     <esc>:m -2<cr>A
" 下移一整行
:nnoremap <C-Down>   :m +1<cr>
:inoremap <C-Down>   <esc>:m +1<cr>A

" 根据文件类型格式化文件
:nnoremap <C-f>      :call FileFormat()<cr>
:inoremap <C-f>      <esc>:call FileFormat()<cr>
" 翻译单词
:inoremap <C-t><C-s> <esc>:TranslateW<cr>A
:nnoremap <C-t><C-s> <esc>:TranslateW<cr>
:vnoremap <C-t><C-s> :TranslateW<cr>
" 移动光标到第一个非空格字符
:nnoremap <Home>     ^
:inoremap <Home>     <esc>^i
" 全选
:nnoremap <C-a>      ggvG
:inoremap <C-a>      ggvG
" 退出终端模式
:tnoremap <esc>      <C-\><C-n>

" 写出文件之前，删除尾部空格
:autocmd BufWritePre * :%s/\s\+$//e
