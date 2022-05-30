-- 有些插件是使用 lua 编写的，通过 vim-plug 安装之后，需要通过 lua 的 require 加载

-- 文件管理器插件
require("nvim-tree").setup({
    -- 启用 git
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
        -- 所有行的缩进层级展现插件
    },
})

-- 文本缩进层级显示设置
require("indent_blankline").setup({
    show_end_of_line = true,
})

-- 终端插件，仓库：https://github.com/akinsho/toggleterm.nvim
require("toggleterm").setup({
    open_mapping = [[<C-t><C-e>]],
    hide_numbers = true,
    shade_terminals = true,
    -- 终端的深色程度
    shading_factor = "1",
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_szie = true,
    -- 终端窗口出现的位置
    direction = "float",
    close_on_exit = true,
    -- 设置默认 SHELL
    shell = vim.o.shell,
    -- 气泡终端设置选项，主要是设置边框
    float_opts = {
        border = "single",
        width = 300,
        height = 60,
        -- 透明度
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})
