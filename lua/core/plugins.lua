--- Plugins Module.
-- This module provides an interface to manage and setup plugins.
-- @module Plugins

-- Usage:
-- local plugins = require('core.plugins')
-- plugins.add({...}) -- add a plugin
-- plugins.setup() -- setup all plugins

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

local Plugins = {}
Plugins._plugins = {}

function Plugins.add(plugin)
  table.insert(Plugins._plugins, plugin)
end

function Plugins.setup()
  local lazy = require('lazy')
  lazy.setup(Plugins._plugins)
end

return Plugins
