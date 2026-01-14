-- =====================================================================
-- MINI.ICONS: Icon provider
-- =====================================================================
--
-- Provides icons for files, filetypes, LSP kinds, and more.
-- Used by lazy.nvim, telescope, neo-tree, and other plugins.
--
-- Also mocks nvim-web-devicons for plugin compatibility.
--
-- =====================================================================

return {
  "echasnovski/mini.icons",
  version = false,
  config = function()
    require("mini.icons").setup()

    -- Mock nvim-web-devicons for plugins without mini.icons support
    MiniIcons.mock_nvim_web_devicons()
  end,
}
