-- =====================================================================
-- CATPPUCCIN: Colorscheme with system theme sync
-- =====================================================================
--
-- Auto-syncs with macOS system theme (light/dark)
-- Uses frappe for light mode and macchiato for dark mode
--
-- =====================================================================

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Load before other plugins
  opts = function(_, opts)
    -- Detect system theme on macOS using osascript
    local dark_mode = vim.fn.system([[osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode']])
    local is_dark = dark_mode:match("true")

    local flavour
    if is_dark then
      flavour = "macchiato"  -- Dark mode
    else
      -- flavour = "frappe"     -- Light mode
      flavour = "macchiato"  -- Dark mode
    end

    opts.flavour = flavour
    return opts
  end,
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
