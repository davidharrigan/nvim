local lspconfig = require("lspconfig")

return {
  --
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = false,
      },
    },
  },
  -- Tiltfile
  -- {
  --   "neovim/nvim-lspconfig",
  --   ---@class PluginLspOpts
  --   opts = {
  --     ---@type lspconfig.options
  --     servers = {
  --       tilt_ls = {},
  --     },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "starlark",
      })
      return opts
    end,
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)

      -- additional config
      vim.treesitter.language.register("starlark", "tiltfile")
    end,
  },

  -- Go
  -- Extends: { import = "lazyvim.plugins.extras.lang.go" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "go",
        "gomod",
        "gowork",
        "gosum",
      })
      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "golangci-lint",
        "golangci-lint-langserver",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        golangci_lint_ls = {
          cmd = { "golangci-lint-langserver" },
          root_dir = require("lspconfig").util.root_pattern(".git", "go.mod"),
          init_options = {
            -- command = { "golangci-lint", "run", "--out-format", "json" },
            command = (function()
              local root = require("lspconfig").util.root_pattern(".git", "go.mod")(vim.fn.getcwd())
              local config_exists = vim.loop.fs_stat(root .. "/.golangci-lint.yaml") ~= nil
              if config_exists ~= "" then
                return { "golangci-lint", "run", "-c", ".golangci-lint.yaml", "--out-format", "json" }
              else
                return { "golangci-lint", "run", "--enable-all", "--disable", "depguard", "--out-format", "json" }
              end
            end)(),
          },
        },
        gopls = {
          keys = {
            -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
            { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
          },
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = false,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              buildFlags = { "-tags=integration" },
              usePlaceholders = false,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
    },
    setup = {
      gopls = function(_, opts)
        -- workaround for gopls not supporting semanticTokensProvider
        -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        LazyVim.lsp.on_attach(function(client, _)
          if client.name == "gopls" then
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end
        end)
        -- end workaround
      end,
    },
  },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-golang"] = {
          go_test_args = { "-tags=integration" },
        },
      },
    },
  },

  -- Svelte
  {

    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "svelte-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "svelte",
      },
    },
  },
}
