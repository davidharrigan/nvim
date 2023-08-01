local M = {}

M.extend = function(plugins)
  local self = {}
  for _, p in ipairs(plugins) do
    vim.list_extend(self, p)
  end
  return self
end

return M
