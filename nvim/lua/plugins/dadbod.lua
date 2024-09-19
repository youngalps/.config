return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      { "kristijanhusak/vim-dadbod-ui" }, -- Optional: For UI
      { "kristijanhusak/vim-dadbod-completion" }, -- Optional: For SQL completion
    },
    config = function()
      -- Optional: Keybindings and configuration for vim-dadbod
      vim.g.db_ui_save_location = "~/.config/nvim/db_ui" -- Set save location for UI
    end,
  },
}
