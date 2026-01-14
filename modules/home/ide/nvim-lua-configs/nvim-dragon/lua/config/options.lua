-- =====================================================================
-- OPTIONS: Vim options and settings
-- =====================================================================
--
-- This file contains essential vim options for core functionality.
-- Following the principle: minimal config, use defaults where possible.
--
-- Sections:
--   1. Core editor: Line numbers, indentation, search
--   2. AI workflow: Auto-reload timing
--   3. Integration: Clipboard, splits
--
-- =====================================================================

-- =====================================================================
-- CORE EDITOR SETTINGS
-- =====================================================================

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation (use 2 spaces)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Text wrapping
vim.opt.wrap = true
vim.opt.linebreak = true

-- =====================================================================
-- AI WORKFLOW TIMING
-- =====================================================================

-- Critical for auto-reload and auto-save responsiveness
vim.opt.updatetime = 250 -- CursorHold trigger time (ms) for auto-save/reload
vim.opt.timeoutlen = 300 -- Time to wait for next key in sequence (ms)
                         -- mini.clue shows hints instantly (0ms delay)
                         -- then you have 300ms to press the next key
vim.opt.autoread = true  -- Enable auto-reload

-- =====================================================================
-- INTEGRATION
-- =====================================================================

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Better defaults
vim.opt.signcolumn = "yes" -- Prevent text shifting
vim.opt.termguicolors = true -- Enable 24-bit color
vim.opt.undofile = true -- Persistent undo
