-- LazyVim Plugin Configuration Example

-- Return an empty table early if the condition is true (for example loading)
if true then
  return {}
end

return {
  -- Example of a disabled plugin setup (commented out)
  -- { "rose-pine/neovim", name = "rose-pine" },

  -- Configuration for Trouble.nvim
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true }, -- Enable diagnostic signs
    enabled = false, -- Plugin is disabled; enable as needed
  },

  -- Configuration for nvim-cmp with additional emoji completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" }) -- Add emoji source to completion options
    end,
  },

  -- Enhancements for Telescope with a custom keymap
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- Unified LSP configuration for Pyright, TSServer, and Gopls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {}, -- Basic Python setup
        tsserver = { -- TypeScript setup using typescript.nvim for enhanced functionality
          init = function()
            require("lazyvim.util").lsp.on_attach(function(_, buffer)
              vim.keymap.set(
                "n",
                "<leader>co",
                "typescriptorganizeimports",
                { buffer = buffer, desc = "Organize Imports" }
              )
              vim.keymap.set("n", "<leader>cr", "typescriptrenamefile", { desc = "Rename File", buffer = buffer })
            end)
          end,
          setup = function(_, opts)
            require("typescript").setup({ server = opts })
            return true
          end,
        },
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
  },

  -- Example of overriding lualine configuration
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        -- Custom lualine configuration here
      }
    end,
  },

  -- Switching to mini.starter for the startup screen
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- Configuration for automated tool installation with Mason
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
