-- https://github.com/rcarriga/nvim-notify
local notify = {
    "rcarriga/nvim-notify",
    keys = {{
        "<leader>un",
        function()
            require("notify").dismiss({
                silent = true,
                pending = true
            })
        end,
        desc = "Dismiss all Notifications"
    }},
    opts = {
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end
    },
    event = "VeryLazy"
}

-- https://github.com/stevearc/dressing.nvim
local dressing = {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
            require("lazy").load({
                plugins = {"dressing.nvim"}
            })
            return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
            require("lazy").load({
                plugins = {"dressing.nvim"}
            })
            return vim.ui.input(...)
        end
    end
}

-- https://github.com/nvim-lualine/lualine.nvim
local statusline = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy"
}

local indentscope = {
    "echasnovski/mini.indentscope",
    version = "0.9.0",
    event = {"BufReadPre", "BufNewFile"},
    opts = {
        -- symbol = "▏",
        symbol = "│",
        options = {
            try_as_border = true
        }
    },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {"help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify", "toggleterm",
                       "lazyterm"},
            callback = function()
                vim.b.miniindentscope_disable = true
            end
        })
    end
}

return {notify, dressing, statusline, indentscope}
