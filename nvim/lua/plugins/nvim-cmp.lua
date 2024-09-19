return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip", -- Ensure that LuaSnip is installed
    "saadparwaiz1/cmp_luasnip", -- Add this if you want snippets in completion
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip") -- Make sure LuaSnip is properly required

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- LuaSnip configuration
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- Snippet source
      }),
    })
  end,
}
