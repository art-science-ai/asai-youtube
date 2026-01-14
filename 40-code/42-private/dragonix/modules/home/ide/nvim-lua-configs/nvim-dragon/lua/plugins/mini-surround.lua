-- =====================================================================
-- MINI.SURROUND: Surround text with pairs
-- =====================================================================
--
-- Add, delete, replace, find, highlight surrounding text objects.
-- Works with quotes, brackets, tags, function calls, and more.
--
-- Default keymaps (customizable):
--   - sa: Add surrounding (e.g., saiw" surrounds word with quotes)
--   - sd: Delete surrounding (e.g., sd" deletes surrounding quotes)
--   - sr: Replace surrounding (e.g., sr"' replaces " with ')
--   - sf/sF: Find surrounding (move to next/prev)
--   - sh: Highlight surrounding
--
-- =====================================================================

return {
  "echasnovski/mini.surround",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.surround").setup({
      -- Default mappings are good, use defaults
      -- Add surrounding: sa + motion/text-object + character
      -- Delete surrounding: sd + character
      -- Replace surrounding: sr + old-char + new-char
      -- Find surrounding: sf/sF + character
      -- Highlight surrounding: sh + character
    })
  end,
}
