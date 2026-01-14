-- =====================================================================
-- RENDER-MARKDOWN.NVIM: Enhanced markdown rendering
-- =====================================================================
--
-- Improves viewing Markdown files in Neovim with enhanced rendering
-- of headings, code blocks, tables, lists, checkboxes, and more.
--
-- =====================================================================

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.nvim", -- Uses mini.icons from the mini suite
  },
  ft = "markdown", -- Only load for markdown files
  opts = {}, -- Use plugin defaults
}