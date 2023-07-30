local M = {}

-- load config
require('config')

-- packages
local packages = require('core.package').extend({
  require('core'),
  require('editor'),
})

M.init = function()
  -- If lazy.nvim is not installed, install it from GitHub.
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  local lazy = require('lazy')
  lazy.setup(packages.plugins)
end

M.load = function()
  packages.setup()
  packages.keymaps()
  packages.autocmds()
end

return M
