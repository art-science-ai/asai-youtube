-- =====================================================================
-- MINI.EXTRA: Extra functionality for mini.nvim modules
-- =====================================================================
--
-- Provides additional pickers, text objects, and other extensions
-- for mini.nvim modules.
--
-- Extra pickers available:
--   - commands: Neovim commands (Ex commands)
--   - keymaps: All defined keymaps
--   - options: Vim options
--   - and many more...
--
-- See: https://github.com/echasnovski/mini.extra
--
-- =====================================================================

return {
  "echasnovski/mini.extra",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.extra").setup()
  end,
}
