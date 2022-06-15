-- packer，github：https://github.com/wbthomason/packer.nvim

vim.cmd [[packadd packer.nvim]]

-- 使用 packer 管理插件
return require("packer").startup(function()
    -- 让 packer 自己管理自己
    use 'wbthomason/packer.nvim'
    -- dashboard-nvim，nvim 的起动界面，github：https://github.com/glepnir/dashboard-nvim
    use 'glepnir/dashboard-nvim'
end)
