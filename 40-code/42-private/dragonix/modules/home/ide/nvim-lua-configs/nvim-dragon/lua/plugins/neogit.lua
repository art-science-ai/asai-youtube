-- =====================================================================
-- NEOGIT: Magit-inspired git interface
-- =====================================================================
--
-- A Neovim-native git client inspired by Emacs Magit.
-- Provides an intuitive interface for staging, committing, and managing branches.
--
-- Features:
--   - Status buffer showing git state and changes
--   - Easy staging/unstaging of changes
--   - Commit workflow with message editor
--   - Branch management and switching
--   - Push/pull operations
--   - Merge, rebase, cherry-pick, and more
--
-- Commands:
--   - :Neogit - Open main status buffer
--   - :Neogit commit - Open commit buffer
--   - :Neogit push - Push changes
--   - :Neogit pull - Pull changes
--
-- Note: Keymaps are defined in config/keymaps.lua
--
-- =====================================================================

return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-mini/mini.pick",           -- optional - picker integration
    "sindrets/diffview.nvim",        -- optional - diff integration
  },
  opts = {
    -- Use default mappings within the neogit buffer
    -- Sensible defaults for git operations
    integrations = {
      diffview = true,  -- Enable diffview integration for viewing diffs
    },
  },
}
