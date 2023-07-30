local M = {}

M.plugins = {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons'},
  }
}

M.setup = function()
  require('lualine').setup()
end

return M

