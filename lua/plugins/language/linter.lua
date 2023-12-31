vim.api.nvim_command('command! Format lua vim.lsp.buf.format({ async = false })')

return {
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = { 'stylua', 'jq' },
        handlers = {},
      })

      -- format on save
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      require('null-ls').setup({
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,

    -- lazy load on
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Format',
  },
}
