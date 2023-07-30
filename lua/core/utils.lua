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

vim.api.nvim_command('command! ReloadConfig lua reload_nvim_conf()')
