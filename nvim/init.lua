-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})
