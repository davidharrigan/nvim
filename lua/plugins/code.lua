return {
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        lsp = {
          focus = true,
          win = { position = "bottom" },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    keys = {
      {
        "<leader>tt",
        function()
          local neotest = require("neotest")
          neotest.output_panel.clear()
          neotest.run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
      {
        "<leader>tT",
        function()
          local neotest = require("neotest")
          neotest.output_panel.clear()
          neotest.run.run(vim.uv.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tr",
        function()
          local neotest = require("neotest")
          neotest.output_panel.clear()
          neotest.run.run()
        end,
        desc = "Run Nearest",
      },
    },
  },
}
