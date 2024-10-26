vim.api.nvim_create_user_command("GoFiles", function()
  require("telescope.builtin").find_files({
    find_command = {
      "rg",
      "--files",
      "--glob=**/*.go",
    },
  })
end, { desc = "find go files" })
