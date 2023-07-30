local logger = require('core.log')

local M = {}

function M.setup()
  require('editor.colorscheme')
  require('editor.file-explorer')
  require('editor.file-browser')
end

return M
