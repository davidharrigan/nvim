-- :help nvim-tree-netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable / disable debug mode
local logger = require('core.log')
logger.enable_debug()

vim.g.mapleader = ' '

require('manage').init()
