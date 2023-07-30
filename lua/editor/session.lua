
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
    -- https://neovim.io/doc/user/options.html#'sessionoptions'
    options = { "curdir", "winsize" },
  })
end

M.keymaps = function()
  vim.keymap.set('n', "<leader>qs", function() require("persistence").load() end, {desc = "Restore Session" })
  vim.keymap.set('n', "<leader>ql", function() require("persistence").load({ last = true }) end, {desc = "Restore Last Session" })
  vim.keymap.set('n', "<leader>qd", function() require("persistence").stop() end, {desc = "Don't Save Current Session" })
end

M.autocmds = function()
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
    callback = function()
      if vim.fn.getcwd() ~= vim.env.HOME then
        require("persistence").load()
      end
    end,
    nested = true,
  })
end

return M
