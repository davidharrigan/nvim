return require('core.package').extend({
  require('editor.language.lsp'),
  require('editor.language.linter'),
  require('editor.language.syntax'),
})
