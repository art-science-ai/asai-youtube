return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      -- Detect system theme on macOS
      local is_dark = vim.fn.system([[defaults read -g AppleInterfaceStyle 2>/dev/null]]):match("Dark")
      local flavour = is_dark and "macchiato" or "frappe"

      opts.flavour = flavour
      opts.background = { light = "frappe", dark = "macchiato" }
      return opts
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
