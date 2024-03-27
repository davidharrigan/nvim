return {
  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    enabled = "false",
  },

  -- notification popup
  {
    "rcarriga/nvim-notify",
    opts = {
      level = 3,
      render = "minimal",
      stages = "static",
    },
  },

  -- colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}