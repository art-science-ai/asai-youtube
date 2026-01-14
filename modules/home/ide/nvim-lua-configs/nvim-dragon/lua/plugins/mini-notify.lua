-- =====================================================================
-- MINI.NOTIFY: Notification system
-- =====================================================================
--
-- Provides a notification system for showing messages to the user.
-- Used to display auto-save and auto-reload status messages.
--
-- Features:
--   - Non-intrusive notifications that don't block workflow
--   - Automatic dismissal after timeout
--   - Multiple notification levels (INFO, WARN, ERROR)
--   - History tracking of all notifications
--
-- Integration points:
--   - autocmds.lua: Shows auto-save and auto-reload notifications
--   - Can be used by any plugin or config for user feedback
--
-- Usage:
--   local notify = require("mini.notify")
--   notify.add("Message here", "INFO")  -- Shows notification
--   notify.show_history()                -- View past notifications
--
-- =====================================================================

return {
  "echasnovski/mini.notify",
  version = false,
  config = function()
    local notify = require("mini.notify")
    notify.setup({
      -- Content options
      content = {
        -- Format function for notification content
        -- Returns the message as-is without modification
        format = function(notif)
          return notif.msg
        end,
        -- Sort notifications by time (most recent at bottom)
        -- Safe comparison that handles nil timestamps
        sort = function(notif_arr)
          table.sort(notif_arr, function(a, b)
            -- Handle nil timestamps by treating them as 0
            local ts_a = a.ts or 0
            local ts_b = b.ts or 0
            return ts_a < ts_b
          end)
          return notif_arr
        end,
      },

      -- Notification window options
      window = {
        -- Position notifications in bottom-right corner
        -- This keeps them out of the way while coding
        config = function()
          local has_statusline = vim.o.laststatus > 0
          local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
          return {
            anchor = "SE",
            col = vim.o.columns,
            row = vim.o.lines - pad,
            border = "rounded",
            focusable = false,
          }
        end,
        -- Maximum width for notification window
        max_width_share = 0.382, -- Golden ratio for aesthetics
        -- Show newer notifications below older ones
        winblend = 0, -- Fully opaque notifications
      },

      -- LSP progress notification integration
      -- Shows LSP server initialization and work progress
      lsp_progress = {
        enable = true,
        -- Duration to show LSP notifications (ms)
        duration_last = 1000,
      },
    })

    -- Override default vim.notify to use mini.notify
    -- This redirects all Neovim notifications through mini.notify
    -- for consistent notification experience
    vim.notify = notify.make_notify()
  end,
}
