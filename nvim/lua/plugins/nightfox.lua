return {
 {
    "EdenEast/nightfox.nvim",
    config = function()
      -- Optional: Customize nightfox settings if needed
      require("nightfox").setup({
        options = {
          -- Example options
          transparent = false, -- Enable/disable transparent background
          styles = {
            comments = "italic", -- Style for comments
            keywords = "bold",   -- Style for keywords
          },
        },
      })
      
      -- Set the colorscheme to carbonfox
      vim.cmd("colorscheme carbonfox")
    end,
  },
  -- Add other plugins here
}
 
