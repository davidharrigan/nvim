-- file browser
-- https://github.com/nvim-neo-tree/neo-tree.nvim
local neotree = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim"},
    config = function()
        local neotree = require("neo-tree")
        neotree.setup({
            close_if_last_window = true,
            name = {
                trailing_slash = true,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName"
            },
            window = {
                width = 50,
                mappings = {
                    ["l"] = "open",
                    ["h"] = "close_node"
                }
            },
            filesystem = {
                follow_current_file = true
            }
        })
    end
}

-- fuzzy finder
-- https://github.com/nvim-telescope/telescope.nvim
local telescope = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = {
                i = {
                    ["<c-t>"] = function(...)
                        return require("trouble.providers.telescope").open_with_trouble(...)
                    end,
                    ["<a-t>"] = function(...)
                        return require("trouble.providers.telescope").open_selected_with_trouble(...)
                    end,
                    ["<a-i>"] = function()
                        local action_state = require("telescope.actions.state")
                        local line = action_state.get_current_line()
                        Util.telescope("find_files", {
                            no_ignore = true,
                            default_text = line
                        })()
                    end,
                    ["<a-h>"] = function()
                        local action_state = require("telescope.actions.state")
                        local line = action_state.get_current_line()
                        Util.telescope("find_files", {
                            hidden = true,
                            default_text = line
                        })()
                    end,
                    ["<C-f>"] = function(...)
                        return require("telescope.actions").preview_scrolling_down(...)
                    end,
                    ["<C-b>"] = function(...)
                        return require("telescope.actions").preview_scrolling_up(...)
                    end
                },
                n = {
                    ["q"] = function(...)
                        return require("telescope.actions").close(...)
                    end
                }
            }
        }
    }
}

local gitsigns = {
    "lewis6991/gitsigns.nvim",
    event = {"BufReadPre", "BufNewFile"},
    opts = {
        signs = {
            add = {
                text = "▎"
            },
            change = {
                text = "▎"
            },
            delete = {
                text = ""
            },
            topdelete = {
                text = ""
            },
            changedelete = {
                text = "▎"
            },
            untracked = {
                text = "▎"
            }
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, {
                    buffer = buffer,
                    desc = desc
                })
            end

            -- stylua: ignore start
            map("n", "<leader>ghb", function()
                gs.blame_line({
                    full = true
                })
            end, "Blame Line")
            map('n', '<leader>gb', gs.toggle_current_line_blame, "Toggle Blame Line")
            map("n", "<leader>ghd", gs.diffthis, "Diff This")
            map("n", "<leader>ghD", function()
                gs.diffthis("~")
            end, "Diff This ~")
            map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end
    }
}

-- Automatically highlights other instances of the word under your cursor. This works with LSP, Treesitter, and regexp matching to find the other instances.
-- https://github.com/RRethy/vim-illuminate
local illuminate = {
    "RRethy/vim-illuminate",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = {"lsp"}
        }
    },
    config = function(_, opts)
        require("illuminate").configure(opts)

        local function map(key, dir, buffer)
            vim.keymap.set("n", key, function()
                require("illuminate")["goto_" .. dir .. "_reference"](false)
            end, {
                desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference",
                buffer = buffer
            })
        end

        map("]]", "next")
        map("[[", "prev")

        -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                map("]]", "next", buffer)
                map("[[", "prev", buffer)
            end
        })
    end,
    keys = {{
        "]]",
        desc = "Next Reference"
    }, {
        "[[",
        desc = "Prev Reference"
    }}
}

local trouble = {
    "folke/trouble.nvim",
    cmd = {"TroubleToggle", "Trouble"},
    opts = {
        use_diagnostic_signs = true
    },
    keys = {{
        "<leader>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Document Diagnostics (Trouble)"
    }, {
        "<leader>xX",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics (Trouble)"
    }, {
        "<leader>xL",
        "<cmd>TroubleToggle loclist<cr>",
        desc = "Location List (Trouble)"
    }, {
        "<leader>xQ",
        "<cmd>TroubleToggle quickfix<cr>",
        desc = "Quickfix List (Trouble)"
    }, {
        "[q",
        function()
            if require("trouble").is_open() then
                require("trouble").previous({
                    skip_groups = true,
                    jump = true
                })
            else
                local ok, err = pcall(vim.cmd.cprev)
                if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                end
            end
        end,
        desc = "Previous trouble/quickfix item"
    }, {
        "]q",
        function()
            if require("trouble").is_open() then
                require("trouble").next({
                    skip_groups = true,
                    jump = true
                })
            else
                local ok, err = pcall(vim.cmd.cnext)
                if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                end
            end
        end,
        desc = "Next trouble/quickfix item"
    }}
}

return {neotree, telescope, gitsigns, whichkey, illuminate, trouble}
