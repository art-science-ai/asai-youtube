-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Basic Settings
vim.opt.wrap = true
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

vim.opt.autochdir = false -- Don't change directory automatically

-- Diagnostic Display
-- Show diagnostics only in gutter (sign column), not inline
vim.diagnostic.config({
  virtual_text = false, -- Disable inline diagnostic text
  signs = true, -- Show signs in gutter
  underline = true, -- Underline problematic code
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true, -- Sort by severity
})

