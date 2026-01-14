-- =====================================================================
-- CORE CONFIGURATION
-- =====================================================================
-- Load core settings: options, keymaps, autocommands
require('core.options')
require('core.keymaps')
require('core.autocommands')

-- =====================================================================
-- PLUGIN MANAGER SETUP
-- =====================================================================

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- [[ Plugin Setup ]]
-- NOTE: Plugins can be added as:
--   - Simple strings: 'owner/repo'
--   - Tables with options: { 'owner/repo', opts = {} }
--   - Tables with custom config: { 'owner/repo', config = function() ... end }
--   - See `:help lazy.nvim-plugin-spec` for full documentation
--
-- All custom plugins are organized in lua/plugins/
-- The { import = 'plugins' } line below auto-loads all files from that directory

require('lazy').setup({
  -- Import all plugins from lua/plugins/
  -- (includes autopairs, neo-tree, gitsigns, and all custom plugins)
  { import = 'plugins' },
}, {
  -- UI Configuration
  ui = {
    -- Use Nerd Font icons if available, otherwise use Unicode fallbacks
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂',
      init = '⚙', keys = '🗝', plugin = '🔌', runtime = '💻',
      require = '🌙', source = '📄', start = '🚀', task = '📌', lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
