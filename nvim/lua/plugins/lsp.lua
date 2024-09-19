-- Unified LSP configuration for Pyright and Gopls
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {}, -- Basic Python setup

        gopls = { -- Go language server with additional settings
          cmd = { "gopls", "serve" },
          settings = {
            gopls = {
              analyses = { unusedparams = true },
              staticcheck = true,
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8", -- List of tools to be automatically installed
      },
    },
  },
}
