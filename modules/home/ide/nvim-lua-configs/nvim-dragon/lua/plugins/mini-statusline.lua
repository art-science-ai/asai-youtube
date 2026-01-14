-- =====================================================================
-- MINI.STATUSLINE: Status line with save indicator
-- =====================================================================
--
-- Customized statusline showing mode, filename, git info, diagnostics,
-- cursor position, and importantly: saved/unsaved status indicator.
--
-- Layout (left to right):
--   [Mode] filename [+] | Git branch | LSP diagnostics | Position
--          ^^^^^^^^ ^^^
--          |        └── Save indicator: [●] = unsaved, [ ] = saved
--          └─────────── Relative path to file
--
-- Features:
--   - Custom save indicator: Shows [●] for modified, nothing when saved
--   - Integrates with autocmds.lua auto-save behavior
--   - Git branch indicator (if in git repo)
--   - LSP diagnostic counts with severity icons
--   - Current line/column and percentage through file
--   - Mode-based colors (NORMAL=blue, INSERT=green, etc.)
--
-- Customization points:
--   - content.active: Main function that builds statusline content
--   - Each section is customizable via mini.statusline API
--   - Icons require mini.icons plugin
--
-- =====================================================================

return {
  "echasnovski/mini.statusline",
  version = false,
  config = function()
    local statusline = require("mini.statusline")

    -- Custom function to show save status indicator
    -- Returns: [●] for unsaved buffers, empty string for saved buffers
    -- This works by checking vim's 'modified' flag for the current buffer
    local function save_indicator()
      -- Only show indicator for normal file buffers
      -- Exclude special buffers like terminals, help, quickfix, etc.
      if vim.bo.buftype ~= "" then
        return ""
      end

      -- Check if buffer has unsaved changes
      if vim.bo.modified then
        return "[●]" -- Filled circle = unsaved changes
      else
        return "" -- Empty when saved (cleaner look than showing [○])
      end
    end

    statusline.setup({
      -- Enable icons from mini.icons for file types, git, diagnostics
      use_icons = true,

      -- Let mini.statusline configure vim settings for best experience
      -- Sets: laststatus=3 (global statusline), statusline format
      set_vim_settings = true,

      -- Custom content function to integrate save indicator
      -- This function is called to build the statusline content
      content = {
        -- Active window statusline (the focused window)
        active = function()
          -- Get built-in statusline components
          local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
          local git = statusline.section_git({ trunc_width = 75 })
          local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
          local filename = statusline.section_filename({ trunc_width = 140 })
          local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
          local location = statusline.section_location({ trunc_width = 75 })
          local search = statusline.section_searchcount({ trunc_width = 75 })

          -- Add our custom save indicator after filename
          local save_status = save_indicator()

          -- Combine sections with appropriate separators
          -- Format: [mode] filename [save] | git | diagnostics | search | fileinfo | location
          -- The %< means this is where truncation starts if line is too long
          -- The %= separates left-aligned from right-aligned content
          return statusline.combine_groups({
            { hl = mode_hl, strings = { mode } }, -- Mode with color
            { hl = "MiniStatuslineFilename", strings = { filename } }, -- Filename
            { hl = "MiniStatuslineFileinfo", strings = { save_status } }, -- Save indicator
            "%<", -- Truncation point
            { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } }, -- Git + diagnostics
            "%=", -- Separator: left-aligned vs right-aligned
            { hl = "MiniStatuslineFileinfo", strings = { search, fileinfo } }, -- Search + file info
            { hl = mode_hl, strings = { location } }, -- Location with mode color
          })
        end,

        -- Inactive window statusline (unfocused windows)
        -- Uses default implementation which shows just filename
        -- This provides visual distinction between focused and unfocused
        inactive = nil, -- nil = use default
      },
    })
  end,
}
