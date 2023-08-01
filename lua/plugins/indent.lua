return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '▏',
      filetype_exclude = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
      config = function()
        require('indent_blankline').setup()
      end,
    },
  },
  {
    'echasnovski/mini.indentscope',
    tag = 'v0.9.0',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = '▏',
      options = { try_as_border = true },
    },
  },
}
