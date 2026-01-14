-- =====================================================================
-- nvim-dragon: Personal Neovim configuration
-- =====================================================================
--
-- This is the entry point for the nvim-dragon configuration.
--
-- Structure:
--   - lua/config/  : Core configuration (options, keymaps, lazy)
--   - lua/plugins/ : Plugin specifications (one file per plugin)
--   - after/       : Loads last (LSP configs, ftplugin, snippets)
--   - snippets/    : Global snippets
--
-- The philosophy:
--   - Every line is readable and documented
--   - Modular: Clear separation of concerns
--   - Minimal: Only what you need
--   - Nix-integrated: LSPs managed via Nix, not Mason
--
-- =====================================================================

-- Load core configuration
require("config.options")  -- Vim options
require("config.keymaps")  -- Key mappings
require("config.autocmds") -- Autocommands
require("config.lazy")     -- Plugin manager
