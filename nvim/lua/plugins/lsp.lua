return {
  -- LSP Zero and its dependencies
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" }
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      -- LSP Server Setup
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "gopls", "sqls" },
        handlers = {
          ["sqls"] = function()
            require("lspconfig").sqls.setup({
              settings = {
                sqls = {
                  connections = {
                    {
                      driver = "postgres",
                      dataSourceName = "postgresql://postgres.koujgmhkmgztznwqdmet:Outdoors1%211944%21@aws-0-us-east-2.pooler.supabase.com:6543/postgres"
                    }
                  }
                }
              }
            })
          end,
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end
        }
      })

      -- nvim-cmp Setup
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete()
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }
        }, {
          { name = "buffer" },
          { name = "path" }
        })
      })

      -- Setup filetype-specific configurations
      cmp.setup.filetype("sql", {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
          { name = "buffer" }
        })
      })

      -- Define the on_attach function to set keymaps
      lsp_zero.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        -- Key mappings
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "x" }, "<F3>", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
      end)

      -- Setup LSP servers
      lsp_zero.setup()
    end
  },

  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = true, -- Enable Treesitter integration
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" }
          -- Add more language-specific configurations if needed
        }
        -- Additional configuration options...
      })

      -- Integration with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
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
        "sql"
      }
    }
  }
}

