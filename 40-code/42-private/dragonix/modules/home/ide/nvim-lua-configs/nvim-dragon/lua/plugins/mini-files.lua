-- =====================================================================
-- MINI.FILES: File explorer
-- =====================================================================
--
-- Lightweight file explorer that fits the mini ecosystem.
-- Navigate, create, delete, rename, move files and directories.
--
-- Features:
--   - Opens in a floating window or split
--   - Keyboard-driven navigation
--   - File manipulation (create, delete, rename, copy, move)
--   - Integration with mini.icons
--
-- Usage:
--   - <leader>e: Toggle file explorer
--   - Enter: Open file/directory
--   - -: Go up to parent directory
--   - g.: Toggle hidden files
--
-- =====================================================================

return {
  "echasnovski/mini.files",
  version = false,
  opts = {
    -- Use default settings with icons
    windows = {
      preview = true, -- Show preview window
      width_preview = 50,
    },
    options = {
      use_as_default_explorer = true, -- Replace netrw
    },
  },
}
