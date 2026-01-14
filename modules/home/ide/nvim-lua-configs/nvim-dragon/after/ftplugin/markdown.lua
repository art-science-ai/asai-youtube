-- =====================================================================
-- MARKDOWN: Filetype-specific settings for Markdown files
-- =====================================================================
--
-- This file contains filetype-specific configuration for Markdown files.
-- It automatically loads when opening .md files and overrides Neovim's
-- default markdown ftplugin which sets shiftwidth=4 and tabstop=4.
--
-- Common markdown settings:
--   - Override indentation to match project standard (2 spaces)
--   - Enable text wrapping
--   - Enable spell checking
--   - Set conceallevel for prettier rendering
--   - Adjust tab settings
--
-- =====================================================================

-- Override indentation to match project standard (2 spaces)
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- Common markdown enhancements
vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
