local M = {}

M.plugins = {
  {
    'folke/persistence.nvim',
    tag = 'v1.1.0',
    opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' } },

    -- lazy load on
    event = 'BufReadPre',
    keys = {
      {
        '<leader>qs',
        function()
          require('persistence').load()
        end,
        { desc = 'Restore Session' },
      },
      {
        '<leader>ql',
        function()
          require('persistence').load({ last = true })
        end,
        { desc = 'Restore Last Session' },
      },
      {
        '<leader>qd',
        function()
          require('persistence').stop()
        end,
        { desc = "Don't Save Current Session" },
      },
    },
  },
}

-- M.autocmds = function()
--   vim.api.nvim_create_autocmd('VimEnter', {
--     group = vim.api.nvim_create_augroup('restore_session', { clear = true }),
--     callback = function()
--       if vim.fn.getcwd() ~= vim.env.HOME then
--         require('persistence').load()
--       end
--     end,
--     nested = true,
--   })
-- end

return M
