
local M = {}

M.plugins = {
  {
  'rmagatti/auto-session',
    tag = 'v2.0.1',
  }
}

M.setup = function()
  require("auto-session").setup ({
  log_level = "error",
})
end

return M
