-- =====================================================================
-- KEYMAPS: Key mappings and bindings
-- =====================================================================
--
-- This file contains all custom keymaps in a centralized location.
-- Following the MiniMax approach: all leader mappings are defined here
-- rather than scattered across plugin files.
--
-- This makes it easy to:
--   - See all available keymaps at once
--   - Prevent conflicts
--   - Maintain consistent patterns
--   - Document your workflow
--
-- =====================================================================

-- =====================================================================
-- MISC
-- =====================================================================

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- =====================================================================
-- NAVIGATION: Visual line movement for soft-wrapped text
-- =====================================================================
-- When wrap is enabled, j/k normally move by file lines (ignoring visual wrapping)
-- These remaps make j/k move by screen lines (respecting visual wrapping)
vim.keymap.set({ 'n', 'x' }, 'j', 'gj', { desc = 'Move down by visual line' })
vim.keymap.set({ 'n', 'x' }, 'k', 'gk', { desc = 'Move up by visual line' })
vim.keymap.set({ 'n', 'x' }, 'gj', 'j', { desc = 'Move down by file line' })
vim.keymap.set({ 'n', 'x' }, 'gk', 'k', { desc = 'Move up by file line' })

-- General navigation: center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "J", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "K", "<C-u>zz", { desc = "Half page up (centered)" })

-- stylua: ignore start

-- Lazy toggle functions
function _G.toggle_horizontal_term()
  local toggleterm = get_toggleterm_functions()
  toggleterm.horizontal()
end

function _G.toggle_vertical_term()
  local toggleterm = get_toggleterm_functions()
  toggleterm.vertical()
end

function _G.toggle_float_term()
  local toggleterm = get_toggleterm_functions()
  toggleterm.float()
end
-- The next part (until `-- stylua: ignore end`) is aligned manually for easier
-- reading. Consider preserving this or remove `-- stylua` lines to autoformat.

-- Helper functions for more concise leader mappings
local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end

local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end


-- =====================================================================
-- LEADER MAPPINGS & GROUPS
-- =====================================================================
--
-- Two-key leader mappings: first key = semantic group, second = action.
-- Example: <Leader>f = "find" group, <Leader>ff = "find files"
--
-- Convention: lowercase = global, uppercase = local/buffer-specific
-- Example: <Leader>fs = workspace symbols, <Leader>fS = document symbols
--
-- Leader groups below are registered for mini.clue to display keybinding hints.
-- Add an entry here whenever you create a new leader group.
--
_G.Config = _G.Config or {}
_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>o', desc = '+Obsidian' },
  { mode = 'n', keys = '<Leader>q', desc = '+Quit/Session' },
  { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
}

-- =====================================================================
-- BUFFER OPERATIONS
-- =====================================================================
-- <Leader>b: Buffer navigation and management
nmap_leader('bn', '<Cmd>bnext<CR>',     'Next buffer')
nmap_leader('bp', '<Cmd>bprevious<CR>', 'Previous buffer')

-- =====================================================================
-- EXPLORE/EDIT
-- =====================================================================
-- <Leader>e: File explorer (mini.files)
nmap_leader('e', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0))
end, 'File explorer (current file)')

nmap_leader('E', function()
  require('mini.files').open(vim.loop.cwd())
end, 'File explorer (cwd)')

-- =====================================================================
-- FIND
-- =====================================================================
-- <Leader>f: Fuzzy finding with mini.pick
nmap_leader('ff', '<Cmd>Pick files_hidden<CR>',          'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>',             'Grep live')
nmap_leader('fb', '<Cmd>Pick buffers<CR>',               'Buffers')
nmap_leader('fh', '<Cmd>Pick help<CR>',                  'Help tags')
nmap_leader('fk', '<Cmd>Pick keymaps<CR>',               'Keymaps')
nmap_leader('fc', '<Cmd>Pick commands<CR>',              'Commands')
nmap_leader('fr', '<Cmd>Pick resume<CR>',                'Resume picker')
nmap_leader('fH', '<Cmd>Pick hl_groups<CR>',             'Highlight groups')
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',     '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',     '":" history')

-- =====================================================================
-- GIT
-- =====================================================================
-- <Leader>g: Git operations with neogit, diffview, and gitsigns
nmap_leader('gg', '<Cmd>Neogit<CR>',                      'Git status')
nmap_leader('gc', '<Cmd>Neogit commit<CR>',               'Commit')
nmap_leader('gp', '<Cmd>Neogit push<CR>',                 'Push')
nmap_leader('gP', '<Cmd>Neogit pull<CR>',                 'Pull')
nmap_leader('gb', '<Cmd>Neogit branch<CR>',               'Branch')
nmap_leader('gd', '<Cmd>DiffviewOpen<CR>',                'Diff view')
nmap_leader('gD', '<Cmd>DiffviewClose<CR>',               'Close diff view')

-- =====================================================================
-- OBSIDIAN
-- =====================================================================
-- <Leader>o: Obsidian note-taking integration
nmap_leader('oo', '<Cmd>ObsidianOpen<CR>',       'Open in Obsidian')
nmap_leader('on', '<Cmd>ObsidianNew<CR>',        'New note')
nmap_leader('os', '<Cmd>ObsidianSearch<CR>',     'Search notes')
nmap_leader('ot', '<Cmd>ObsidianToday<CR>',      'Today\'s note')
nmap_leader('oy', '<Cmd>ObsidianYesterday<CR>',  'Yesterday\'s note')
nmap_leader('oT', '<Cmd>ObsidianTemplate<CR>',   'Insert template')

-- =====================================================================
-- YAZI
-- =====================================================================
-- <Leader>y: Terminal file manager (yazi)
nmap_leader('y', function()
  require('yazi').yazi({ vim.fn.expand('%:p:h') })
end, 'Yazi (current file)')

nmap_leader('Y', function()
  require('yazi').yazi({ vim.loop.cwd() })
end, 'Yazi (cwd)')

-- =====================================================================
-- QUIT/SESSION
-- =====================================================================
-- <Leader>q: Quit, save, and session management
nmap_leader('qq', '<Cmd>qa<CR>',             'Quit all')
nmap_leader('qQ', '<Cmd>qa!<CR>',            'Quit all (force)')
nmap_leader('qw', '<Cmd>wqa<CR>',            'Save and quit all')
nmap_leader('qd', '<Cmd>q!<CR>',             'Quit without saving')
nmap_leader('qr', '<Cmd>source $MYVIMRC<CR>', 'Reload config')
nmap_leader('qR', function()
  vim.cmd('source $MYVIMRC')
  vim.notify('Config reloaded!', vim.log.levels.INFO)
end, 'Reload config (with notification)')

-- =====================================================================
-- TOGGLE
-- =====================================================================
-- <Leader>t: Feature toggles (line numbers, diagnostics, etc.)
-- Toggleterm keymaps moved to plugin file for lazy loading

-- stylua: ignore end
