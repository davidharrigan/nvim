
local M = {}

M.plugins = {
  {
    "folke/persistence.nvim",
    tag = 'v1.1.0',
    event = "BufReadPre",
  }
}

M.setup = function()
  require("persistence").setup ({
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } ,
  })
end

M.keymaps = function()
    -- { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    -- { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    -- { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
end

return M
