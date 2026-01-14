-- lua/plugins/snacks.lua (LazyVim plugin spec)
return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = false, -- Disable snacks explorer, using yazi instead
      },
      picker = {
        sources = {
          explorer = {
            -- preview uses the main editor area
            layout = { preview = "main" },
          },
        },
      },
    },
  },
}
