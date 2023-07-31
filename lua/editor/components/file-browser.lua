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
      { '<leader>ff', builtin('find_files'),  desc = 'Find files' },
      { '<leader>fg', builtin('live_grep'),   desc = 'Grep (root dir)' },
      { '<leader>fb', builtin('buffers'),     desc = 'Buffers' },
      { '<leader>fr', builtin('oldfiles'),    desc = 'Recent' },

      -- git
      { '<leader>gc', builtin('git_commits'), desc = 'commits' },
      { '<leader>gs', builtin('git_status'),  desc = 'status' },
    },
  },
}

return M
