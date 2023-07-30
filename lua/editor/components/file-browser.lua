local M = {}

local builtin = function(b, opts)
  return function()
    opts = opts or {}
    return require('telescope.builtin')[b](opts)
  end
end

M.plugins = {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true, -- default setup

    -- lazy load on
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', builtin('find_files'), {} },
      { '<leader>fg', builtin('live_grep'),  {} },
      { '<leader>fb', builtin('buffers'),    {} },
      { '<leader>fh', builtin('help_tags'),  {} },
    },
  },
}

return M
