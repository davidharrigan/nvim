-- file explorer
-- uses nvim-neo-tree/neo-tree.nvim plugin.
-- 
-- see default configuration here: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua
-- recipies: https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipies
-- keymaps
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', {
    desc = 'toggle file explorer'
})

local plugins = require('core.plugins')
plugins.add({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"},
    opts = {
        sources = {"filesystem", "buffers", "git_status", "document_symbols"},
        open_files_do_not_replace_types = {"terminal", "Trouble", "qf", "Outline"},
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = {
                enabled = true
            },
            use_libuv_file_watcher = true
        },
        window = {
            mappings = {
                ["<space>"] = "none",
                ['e'] = function()
                    vim.api.nvim_exec('Neotree focus filesystem left', true)
                end,
                ['b'] = function()
                    vim.api.nvim_exec('Neotree focus buffers left', true)
                end,
                ['g'] = function()
                    vim.api.nvim_exec('Neotree focus git_status left', true)
                end
            }
        },
        default_component_configs = {
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander"
            }
        },
        event_handlers = {{
            event = "file_opened",
            handler = function(file_path)
                -- auto close
                -- vimc.cmd("Neotree close")
                -- OR
                require("neo-tree.command").execute({
                    action = "close"
                })
            end
        }}
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)
        vim.api.nvim_create_autocmd("TermClose", {
            pattern = "*lazygit",
            callback = function()
                if package.loaded["neo-tree.sources.git_status"] then
                    require("neo-tree.sources.git_status").refresh()
                end
            end
        })
    end
})
