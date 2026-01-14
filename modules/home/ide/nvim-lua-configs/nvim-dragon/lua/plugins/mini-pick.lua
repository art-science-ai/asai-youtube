-- =====================================================================
-- MINI.PICK: Command palette and fuzzy finder
-- =====================================================================
--
-- Provides VSCode-like command discovery and file finding.
-- Custom pickers are registered here, keymaps are in config/keymaps.lua
--
-- Built-in pickers (mini.pick):
--   - buffers: Open buffers
--   - files: Find files (respects .gitignore)
--   - grep_live: Live grep through files
--   - help: Help tags
--   - history: Command/search history
--   - hl_groups: Highlight groups
--   - resume: Resume last picker
--
-- Extra pickers (mini.extra - requires separate plugin):
--   - commands: Neovim Ex commands
--   - keymaps: All defined keymaps
--   - options: Vim options
--   - registers: Register contents
--
-- Custom pickers (defined below):
--   - files_hidden: Find files including hidden/dotfiles
--
-- =====================================================================

return {
  "echasnovski/mini.pick",
  version = false,
  event = "VeryLazy",
  config = function()
    local pick = require("mini.pick")
    pick.setup({
      -- Window configuration
      window = {
        -- Make picker window larger and more usable
        config = function()
          local height = math.floor(0.618 * vim.o.lines) -- Golden ratio
          local width = math.floor(0.8 * vim.o.columns)
          return {
            anchor = 'NW',
            height = height,
            width = width,
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
            border = 'rounded',
          }
        end,
      },

      -- Options for the picker buffer
      options = {
        -- Enable line wrapping for long results
        use_cache = false,
      },
    })

    -- Enable wrapping in picker windows after they open
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'minipick',
      callback = function()
        vim.wo.wrap = true
        vim.wo.linebreak = true -- Wrap at word boundaries
      end,
    })

    -- ===================================================================
    -- CUSTOM PICKERS
    -- ===================================================================

    -- Register custom picker for files with hidden/dotfiles included
    -- This uses ripgrep with --hidden flag to show dotfiles
    pick.registry.files_hidden = function()
      return pick.builtin.cli({
        command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        source = { name = "Files (with hidden)" },
      })
    end

    -- Note: Keymaps for all pickers are defined in config/keymaps.lua
    -- This keeps all keybindings centralized and easy to manage
  end,
}
