return require('core.plugins').extend({
  require('plugins.language.autocomplete'),
  require('plugins.language.lsp'),
  require('plugins.language.linter'),
  require('plugins.language.syntax'),
})
