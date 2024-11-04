return {
  -- ... other plugins ...

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- null-ls dependency
    config = function()
      local null_ls = require("null-ls")

      -- Create an augroup for formatting
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          -- Formatting with black
          null_ls.builtins.formatting.black.with({
            extra_args = { "--line-length", "90" }, -- adjust line length if needed
          }),
          -- Linting with flake8
          null_ls.builtins.diagnostics.flake8.with({
            extra_args = { "--max-line-length", "90" }, -- adjust as needed
          }),
          null_ls.builtins.diagnostics.luacheck.with({
          }),
        },
        -- Format on save
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },

  -- ... other plugins ...
}
