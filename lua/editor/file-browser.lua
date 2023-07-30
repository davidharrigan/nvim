local plugins = require('core.plugins')

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})

plugins.add({
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = { 'nvim-lua/plenary.nvim' },
})
