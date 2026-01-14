-- =====================================================================
-- MINI.COMMENT: Fast and flexible commenting
-- =====================================================================
--
-- Comment/uncomment lines and blocks with a single keymap.
-- Treesitter-aware for multi-language files.
--
-- Default keymaps:
--   - gcc: Toggle comment on current line
--   - gc: Toggle comment on motion/visual selection
--     Examples:
--       gcip: Comment inner paragraph
--       gc2j: Comment current line + 2 lines below
--       gcG: Comment from current line to end of file
--
-- Visual mode:
--   - gc: Comment selection
--
-- =====================================================================

return {
  "echasnovski/mini.comment",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.comment").setup({
      -- Use default mappings (gcc, gc)
      -- Treesitter integration is automatic
    })
  end,
}
