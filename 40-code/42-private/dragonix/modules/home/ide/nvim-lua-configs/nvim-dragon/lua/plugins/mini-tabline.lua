-- =====================================================================
-- MINI.TABLINE: Buffer/tab line
-- =====================================================================
--
-- Minimal buffer and tab line showing open buffers at the top.
-- Lightweight alternative to bufferline.nvim.
--
-- =====================================================================

return {
  "echasnovski/mini.tabline",
  version = false,
  config = function()
    local tabline = require("mini.tabline")
    tabline.setup({
      -- Show icons for buffers (requires mini.icons)
      show_icons = true,

      -- Set tab format (show buffer number, icon, name)
      set_vim_settings = true,

      -- Tab display options
      tabpage_section = "right", -- Show tab pages on the right
    })
  end,
}
