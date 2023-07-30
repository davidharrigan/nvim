require('config.options')
require('config.autocmds')
require('config.keymaps')

local files = { 'options', 'autocmds', 'keymaps' }
for _, cfg in ipairs(files) do
  require('config.' .. cfg)
end
