return {
  -- LSP Zero and its dependencies
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required for LSP
      { 'williamboman/mason.nvim' },           -- Optional: LSP installer
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional: Bridge between mason and lspconfig

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- The completion plugin
      { 'hrsh7th/cmp-nvim-lsp' },     -- LSP source for nvim-cmp
      { 'hrsh7th/cmp-buffer' },       -- Buffer source for nvim-cmp
      { 'hrsh7th/cmp-path' },         -- Path source for nvim-cmp
      { 'saadparwaiz1/cmp_luasnip' }, -- Snippets source for nvim-cmp

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Snippets plugin
      { 'rafamadriz/friendly-snippets' }, -- Collection of snippets
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- Ensure Mason is set up (optional)
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'pyright', 'gopls', 'sqls' }, -- Ensure these servers are installed
        handlers = {
          -- Default handler for all installed servers
          function(server_name)
            require('lspconfig')[server_name].setup {} -- Replace {} with your specific configurations if needed
          end,
        },
      })




      -- Setup nvim-cmp
      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_mappings = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-k>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      })

      -- Setup Dadbod
      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })


      -- Define the on_attach function to set keymaps
      lsp_zero.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        -- Key mappings
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', function()
          vim.lsp.buf.format({ async = true })
        end, opts)
        vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
      end)

      -- Setup LSP servers
      lsp_zero.setup()
    end,
  },

  -- Other Plugins...
}
