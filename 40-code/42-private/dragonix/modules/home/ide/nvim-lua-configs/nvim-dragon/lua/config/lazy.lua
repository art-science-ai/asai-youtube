-- =====================================================================
-- LAZY: Plugin manager setup
-- =====================================================================
--
-- This file bootstraps and configures lazy.nvim, the plugin manager.
--
-- lazy.nvim features:
--   - Automatic lazy-loading of plugins
--   - Fast startup times
--   - Lockfile for reproducible installs
--   - Beautiful UI for managing plugins
--
-- Commands:
--   :Lazy - Open plugin manager UI
--   :Lazy update - Update all plugins
--   :Lazy sync - Install missing and update plugins
--
-- =====================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Import plugins from lua/plugins/
  -- Each file in lua/plugins/ should return a plugin spec
  { import = "plugins" },
})
