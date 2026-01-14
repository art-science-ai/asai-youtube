-- =====================================================================
-- YAZI: Terminal file manager
-- =====================================================================
--
-- A fast, blazing terminal file manager integrated with Neovim.
-- Complements mini.files with a different UX for those who prefer
-- a traditional terminal-based file browser.
--
-- Features:
--   - Opens as a floating terminal window
--   - Full yazi functionality (sorting, filtering, previewing)
--   - File operations (copy, move, delete, rename)
--   - Integration with Neovim buffers (open files directly)
--
-- Usage:
--   - <leader>y: Open yazi at current file directory
--   - <leader>Y: Open yazi at cwd
--   - In yazi: press 'o' to open file in Neovim
--
-- =====================================================================

return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  opts = {
    -- Open yazi in a floating window
    open_for_dir = false, -- Don't auto-open for directories
    keymaps = {
      show_help = '?',
    },
  },
}
