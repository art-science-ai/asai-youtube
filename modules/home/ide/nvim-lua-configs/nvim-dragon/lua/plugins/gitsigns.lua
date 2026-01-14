-- =====================================================================
-- GITSIGNS: Git integration for buffers
-- =====================================================================
--
-- Shows git signs in the buffer gutter (added, modified, deleted lines).
-- Integrates seamlessly with your buffer for immediate visual feedback
-- on uncommitted changes.
--
-- Features:
--   - Line-level git status indicators
--   - Stage/unstage individual hunks
--   - Navigate between changes
--   - Blame information on demand
--   - Preview changes inline
--
-- Default keymaps (in buffer):
--   - ]c / [c - Next/prev hunk
--   - <Leader>hs - Stage hunk
--   - <Leader>hu - Undo stage hunk
--   - <Leader>hr - Reset hunk
--   - <Leader>hb - Blame line
--   - <Leader>hd - Diff hunk
--   - <Leader>hp - Preview hunk
--
-- Note: Keymaps can be customized; defaults shown above
--
-- =====================================================================

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    current_line_blame = false,  -- Set to true to show blame on current line
    preview_config = {
      border = "rounded",
      style = "minimal",
    },
  },
}
