-- file explorer
-- uses nvim-neo-tree/neo-tree.nvim plugin.
--
-- see default configuration here: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua
-- recipies: https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipies
vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*lazygit',
  callback = function()
    if package.loaded['neo-tree.sources.git_status'] then
      require('neo-tree.sources.git_status').refresh()
    end
  end,
})

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
    config = function()
      local neotree = require('neo-tree')
      neotree.setup({
        sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
        open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'Outline' },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = {
            ['<space>'] = 'none',
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
        },
      })
    end,

    -- lazy load on
    keys = {
      {
        '<leader>fe',
        function()
          require('neo-tree.command').execute({ toggle = true })
        end,
        desc = 'Explorer',
      },
      { '<leader>e', '<leader>fe', desc = 'Explorer', remap = true },
    },
  },
}
