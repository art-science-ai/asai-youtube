-- =====================================================================
-- MINI.CLUE: Keybinding hints and discovery
-- =====================================================================
--
-- mini.clue shows available keybindings as you type key sequences,
-- making it easy to discover commands without memorizing everything.
--
-- Features:
--   - Shows hints after a configurable delay
--   - Lightweight and fast (pure Lua)
--   - Integrates with mini.nvim ecosystem
--   - Supports custom triggers and clue groups
--
-- Usage:
--   - Start typing a key sequence (like <leader>)
--   - After a delay, available completions appear
--   - Continue typing to narrow down or execute
--
-- =====================================================================

return {
  "echasnovski/mini.clue",
  version = false,
  event = "VeryLazy",
  config = function()
    local miniclue = require("mini.clue")
    miniclue.setup({
      -- Window configuration
      window = {
        -- Show hints immediately after trigger key (0ms delay)
        -- This provides instant feedback when pressing leader or other trigger keys
        -- Combined with timeoutlen=300, gives you 300ms to see hints and press next key
        delay = 0,
        config = {
          width = "auto",
          border = "rounded",
        },
      },

      -- Trigger groups: Define when to show hints
      triggers = {
        -- Leader key sequences
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key sequences
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key sequences
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },

        -- Brackets
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
      },

      -- Clues: Provide descriptions for key groups
      clues = {
        -- Leader key groups (defined in config/keymaps.lua)
        -- This uses the global Config.leader_group_clues table
        -- to keep group definitions centralized with their keymaps
        (_G.Config or {}).leader_group_clues,

        -- Mini.nvim clues (built-in patterns)
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    })
  end,
}
