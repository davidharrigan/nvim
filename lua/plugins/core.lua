local telescope = require("telescope.builtin")

return {
  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    enabled = "false",
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader><space>",
        telescope.find_files,
        { cwd = vim.uv.cwd(), hidden = true, desc = "Find Files (Root Dir)" },
      },
      {
        "<leader>/",
        telescope.live_grep,
        { cwd = vim.uv.cwd(), desc = "Live Grep (Root Dir)" },
      },

      -- find
      { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      -- find project files
      {
        "<leader>fpg",
        telescope.find_files,
        {
          find_command = {
            "rg",
            "--files",
            "--glob=**/*.go",
          },
          desc = "Find Go files",
        },
      },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      })
    end,
  },

  -- notification popup
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "minimal",
      stages = "static",
    },
  },
}
