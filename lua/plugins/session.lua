return {
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
        desc = 'Restore Session',
      },
      {
        '<leader>ql',
        function()
          require('persistence').load({ last = true })
        end,
        desc = 'Last Session',
      },
      {
        '<leader>qd',
        function()
          require('persistence').stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
