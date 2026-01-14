-- =====================================================================
-- MINI.PAIRS: Auto-pairs for brackets, quotes, etc.
-- =====================================================================
--
-- Automatically inserts closing pairs for:
--   - Brackets: (), [], {}
--   - Quotes: "", '', ``
--   - And more
--
-- Smart behavior:
--   - Skips closing pair if cursor is before it
--   - Deletes pair when backspacing opening pair
--   - Works in insert mode only
--
-- =====================================================================

return {
  "echasnovski/mini.pairs",
  version = false,
  event = "InsertEnter",
  config = function()
    require("mini.pairs").setup()
  end,
}
