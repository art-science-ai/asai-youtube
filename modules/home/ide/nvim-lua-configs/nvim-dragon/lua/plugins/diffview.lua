-- =====================================================================
-- DIFFVIEW: Single tabpage interface for diffs
-- =====================================================================
--
-- Fast and seamless way to cycle through diffs for all modified files.
-- Great for reviewing changes before committing.
--
-- Features:
--   - Tabpage-based diff interface
--   - Cycle through diffs for modified files
--   - File history viewing
--   - Integrates with neogit
--
-- Commands:
--   - :DiffviewOpen - Open diff view
--   - :DiffviewClose - Close diff view
--   - :DiffviewToggleFiles - Toggle file panel
--   - :DiffviewFocusFiles - Focus on file panel
--
-- Note: Optional but recommended for git workflows
--
-- =====================================================================

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    -- Use sensible defaults
    -- See https://github.com/sindrets/diffview.nvim for configuration options
  },
}
