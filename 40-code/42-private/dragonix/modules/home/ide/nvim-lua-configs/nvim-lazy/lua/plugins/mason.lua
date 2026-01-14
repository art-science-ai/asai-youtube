-- Disable Mason - LSPs managed by Nix via nixCats
return {
  -- Override LazyVim's Mason plugin specs to disable them
  {
    "LazyVim/LazyVim",
    opts = {
      -- Disable Mason in LazyVim
      mason = false,
    },
  },
  -- Disable Mason plugins (both old and new names)
  { "williamboman/mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
}
