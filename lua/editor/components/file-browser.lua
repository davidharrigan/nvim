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
    opts = {
      defaults = {
        layout_config = { height = 0.9, width = 0.95 },
        layout_strategy = 'horizontal',
      },
    },

    -- lazy load on
    cmd = 'Telescope',
    keys = {
      -- find
      { '<leader>ff', builtin('find_files'), desc = 'Find files' },
      { '<leader>fg', builtin('live_grep'), desc = 'Grep (root dir)' },
      { '<leader>fb', builtin('buffers'), desc = 'Buffers' },
      { '<leader>fr', builtin('oldfiles'), desc = 'Recent' },

      -- git
      { '<leader>gc', builtin('git_commits'), desc = 'commits' },
      { '<leader>gs', builtin('git_status'), desc = 'status' },

      -- search
      { '<leader>sc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>sC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
      { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Document diagnostics' },
      { '<leader>sD', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace diagnostics' },
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
      { '<leader>sw', builtin('grep_string', { word_match = '-w' }), desc = 'Word (root dir)' },
      { '<leader>sW', builtin('grep_string', { cwd = false, word_match = '-w' }), desc = 'Word (cwd)' },
      {
        '<leader>sw',
        builtin('grep_string'),
        mode = 'v',
        desc = 'Selection (root dir)',
      },
      {
        '<leader>sW',
        builtin('grep_string', { cwd = false }),
        mode = 'v',
        desc = 'Selection (cwd)',
      },
      {
        '<leader>ss',
        builtin('lsp_document_symbols', {
          symbols = {
            'Class',
            'Function',
            'Method',
            'Constructor',
            'Interface',
            'Module',
            'Struct',
            'Trait',
            'Field',
            'Property',
          },
        }),
        desc = 'Goto Symbol',
      },
      {
        '<leader>sS',
        builtin('lsp_dynamic_workspace_symbols', {
          symbols = {
            'Class',
            'Function',
            'Method',
            'Constructor',
            'Interface',
            'Module',
            'Struct',
            'Trait',
            'Field',
            'Property',
          },
        }),
        desc = 'Goto Symbol (Workspace)',
      },
    },
  },
}

return M
