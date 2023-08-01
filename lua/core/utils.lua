function _G.reload_nvim_conf()
  local modules = { 'core', 'config', 'editor' }

  for name, _ in pairs(package.loaded) do
    for _, mod in ipairs(modules) do
      if name:match('^' .. mod) then
        package.loaded[name] = nil
        break
      end
    end
  end

  dofile(vim.env.MYVIMRC)
end

function _G.reload_plugins()
  local m = require('manage')
  m.reload()
end

vim.api.nvim_command('command! ReloadConfig lua reload_nvim_conf()')
vim.api.nvim_command('command! ReloadPlugins lua reload_plugins()')
