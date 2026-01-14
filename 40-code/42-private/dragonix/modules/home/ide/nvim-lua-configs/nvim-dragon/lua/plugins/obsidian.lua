-- =====================================================================
-- OBSIDIAN.NVIM: Obsidian integration
-- =====================================================================
--
-- Integrates Neovim with Obsidian for note-taking workflows.
--
-- Features:
--   - Link completion and navigation
--   - Daily notes
--   - Template support
--   - Search and grep through notes
--   - Follow links with gf
--   - Note creation and management
--
-- Commands:
--   - :ObsidianOpen - Open note in Obsidian app
--   - :ObsidianNew - Create new note
--   - :ObsidianSearch - Search notes
--   - :ObsidianToday - Open today's daily note
--   - :ObsidianYesterday - Open yesterday's daily note
--   - :ObsidianTemplate - Insert template
--
-- =====================================================================

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  -- Only load when in Obsidian vault (adjust path to your vault)
  event = {
    -- Uncomment and adjust these paths to your Obsidian vault(s)
    -- "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian/**.md",
    -- "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required dependency
  },
  opts = {
    workspaces = {
      -- Define your Obsidian workspace(s) here
      -- Example:
      -- {
      --   name = "personal",
      --   path = "~/Documents/Obsidian/Personal",
      -- },
      -- {
      --   name = "work",
      --   path = "~/Documents/Obsidian/Work",
      -- },
    },

    -- Optional: Daily notes configuration
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      template = nil, -- Set to template name if you have one
    },

    -- Optional: Template configuration
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Completion of wiki links
    completion = {
      nvim_cmp = true, -- Enable nvim-cmp integration
      min_chars = 2,
    },

    -- Follow links with gf
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },

    -- Note ID generation (use title for human-readable names)
    note_id_func = function(title)
      -- If title is provided, use it as the ID (slugified)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- Otherwise generate a timestamp ID
        return tostring(os.time())
      end
    end,

    -- Disable frontmatter management (optional)
    disable_frontmatter = false,

    -- Use markdown syntax highlighting
    note_frontmatter_func = function(note)
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
  },
  -- Note: Keymaps are defined in config/keymaps.lua
}
