local M = {}

local servers = {
  'lua_ls',
  'gopls',
}

M.plugins = {
  {
    'neovim/nvim-lspconfig',
    tag = 'v0.1.6',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        tag = 'v1.6.1',
        build = ':MasonUpdate',
      },
      {
        'williamboman/mason-lspconfig.nvim',
        tag = 'v1.12.0',
      },
      'folke/neodev.nvim',
    },
  },
}

M.setup = function()
  require('mason').setup()
  require('neodev').setup()

  require('mason-lspconfig').setup({ ensure_installed = servers })

  require('mason-lspconfig').setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      require('lspconfig')[server_name].setup({})
    end,
  })
end

return M
