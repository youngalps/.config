-- Treesitter configuration with extended language support
return
-- Treesitter configuration with extended language support
{
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local languages = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    }
    vim.list_extend(opts.ensure_installed, languages)
  end,
}
