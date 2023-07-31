return require('core.package').extend({
  require('editor.components.explorer'),
  require('editor.components.file-browser'),
  require('editor.components.status-bar'),
  require('editor.components.hint'),
  require('editor.components.diagnostics'),
})
