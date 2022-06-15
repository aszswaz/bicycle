" 插件的配置

" 快捷键的配置
" 打开文件管理器，此功能依赖于文件管理器插件
:nnoremap <C-e> :NvimTreeToggle<cr>
:inoremap <C-e> <esc>:NvimTreeToggle<cr>
" 刷新文件管理器
:nnoremap <C-r> :NvimTreeRefresh<cr>
:inoremap <C-r> <esc>:NvimTreeRefresh<cr>

" 状态栏主题配置
:let g:lightline = {
        \ 'colorscheme': 'onedark',
        \ 'active': {
            \ 'left': [ [ 'mode', 'paste' ], [ 'user', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
            \ 'user': 'Username',
            \ 'gitbranch': 'Gitbranchicon'
        \ }
    \ }

" dashboard-nvim 插件配置
:let g:dashboard_default_executive = 'fzf'

" vim-bookmarks 插件配置
:highlight BookmarkSign ctermbg=NONE ctermfg=160
:highlight BookmarkLine ctermbg=194 ctermfg=NONE
:let g:bookmark_sign = '⚑'
:let g:bookmark_highlight_lines = 1

" barbar.nvim 配置
" 向左或向右切换标签页
:nnoremap <silent> <A-Left>   :BufferPrevious<cr>
:inoremap <silent> <A-Left>   <esc>:BufferPrevious<cr>
:tnoremap <silent> <A-Left>   <C-\><C-n>:BufferPrevious<cr>
:nnoremap <silent> <A-Right>  :BufferNext<cr>
:inoremap <silent> <A-Right>  <esc>:BufferNext<cr>
:tnoremap <silent> <A-Right>  <C-\><C-n>:BufferNext<cr>
" 切换到指定标签页
:nnoremap <silent> <A-1>      :BufferGoto 1<CR>
:nnoremap <silent> <A-2>      :BufferGoto 2<CR>
:nnoremap <silent> <A-3>      :BufferGoto 3<CR>
:nnoremap <silent> <A-4>      :BufferGoto 4<CR>
:nnoremap <silent> <A-5>      :BufferGoto 5<CR>
:nnoremap <silent> <A-6>      :BufferGoto 6<CR>
:nnoremap <silent> <A-7>      :BufferGoto 7<CR>
:nnoremap <silent> <A-8>      :BufferGoto 8<CR>
:nnoremap <silent> <A-9>      :BufferLast<CR>
" 保存文件、关闭缓冲区并关闭标签页
:nnoremap <silent> <A-c>      :call CloseTab()<cr>
:inoremap <silent> <A-c>      <esc>:call CloseTab()<cr>
" 置项标签页
:nnoremap <silent> <A-p>      :BufferPin<cr>
:inoremap <silent> <A-p>      <esc>:BufferPin<cr>
