local M = {}

M.extend = function(packages)
  packages = packages or {}

  local self = {}
  self.plugins = {}

  for _, pkg in ipairs(packages) do
    if pkg.plugins then
      vim.list_extend(self.plugins, pkg.plugins)
    end
  end

  function self.setup()
    for _, pkg in ipairs(packages) do
      if pkg.setup then
        pkg.setup()
      end
    end
  end

  function self.autocmds()
    for _, pkg in ipairs(packages) do
      if pkg.autocmds then
        pkg.autocmds()
      end
    end
  end

  return self
end

return M
