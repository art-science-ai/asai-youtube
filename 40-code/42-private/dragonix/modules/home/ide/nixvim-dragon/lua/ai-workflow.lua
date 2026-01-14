-- =============================================================================
-- AI Workflow: Auto-Save & Auto-Reload
-- =============================================================================
--
-- Purpose: Seamless collaboration with AI tools (Claude Code, etc.)
--   - Auto-save: Saves your changes when you switch to the AI terminal
--   - Auto-reload: Reloads files when AI modifies them externally
--   - Notifications: Clear feedback for save/reload events
--
-- How it works:
--   1. FocusLost -> saves all modified buffers (you switched away from nvim)
--   2. CursorHold -> saves current buffer after 250ms of inactivity
--   3. FocusGained/BufEnter/CursorHold -> checks for external changes
--   4. FileChangedShellPost -> notifies when a file was reloaded
--
-- Requirements:
--   - vim.o.autoread = true (enables automatic buffer reload)
--   - vim.o.updatetime = 250 (controls CursorHold timing)
--   - mini.notify plugin (for notifications, with vim.notify fallback)
--
-- =============================================================================

-- Initialize mini.notify and override vim.notify to prevent duplicates
-- This ensures all notifications go through mini.notify's system
local notify_ok, mini_notify = pcall(require, "mini.notify")
if notify_ok then
  vim.notify = mini_notify.make_notify()
end

-- =============================================================================
-- AUTO-RELOAD: Detect external changes from AI agents
-- =============================================================================
--
-- When AI tools edit files externally, we need to:
--   1. Detect the change (via checktime on various events)
--   2. Reload the buffer (handled by vim's autoread option)
--   3. Notify the user (via mini.notify with debouncing)
--
-- =============================================================================

local reload_group = vim.api.nvim_create_augroup("AutoReload", { clear = true })

-- Debounce table: prevents notification spam when multiple events fire
-- Key: buffer number, Value: timestamp of last notification
local last_reload_notify = {}

-- Notify when a file is reloaded from external changes
-- Uses debouncing to prevent duplicate notifications within 2 seconds
-- Shows prominent notification for 4 seconds
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = reload_group,
  desc = "Notify when file is auto-reloaded from external changes",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local short_name = vim.fn.fnamemodify(filename, ":t")

    -- Debounce: skip if we notified about this buffer within 2 seconds
    local now = vim.fn.reltimefloat(vim.fn.reltime())
    if last_reload_notify[bufnr] and (now - last_reload_notify[bufnr]) < 2 then
      return
    end
    last_reload_notify[bufnr] = now

    -- Show notification (vim.notify is already overridden to use mini.notify)
    -- Mini.notify will auto-dismiss based on its configuration
    vim.notify("󰑓 File reloaded: " .. short_name, vim.log.levels.INFO)
  end,
})

-- Check for external changes on focus gain (when you switch back to nvim)
vim.api.nvim_create_autocmd("FocusGained", {
  group = reload_group,
  desc = "Check for external file changes on focus",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Check for external changes when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  group = reload_group,
  desc = "Check for external file changes on buffer enter",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Check for external changes when cursor is idle (updatetime = 250ms)
vim.api.nvim_create_autocmd("CursorHold", {
  group = reload_group,
  desc = "Check for external file changes on cursor hold",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- =============================================================================
-- AUTO-SAVE: Prevent data loss when switching to AI agents
-- =============================================================================
--
-- Automatically saves files when:
--   1. You lose focus (switch to AI terminal)
--   2. Cursor is idle for 250ms
--
-- Safety features:
--   - Only saves normal file buffers (not terminals, help, etc.)
--   - Uses silent! to prevent errors on unsaveable buffers
--   - Checks buffer is modified before writing (avoids unnecessary I/O)
--
-- =============================================================================

local save_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- Track last save notification time to prevent spam
local last_save_notify = 0

-- Save all modified buffers when losing focus (switching to AI terminal)
vim.api.nvim_create_autocmd("FocusLost", {
  group = save_group,
  desc = "Auto-save all buffers on focus loss",
  callback = function()
    -- Count how many buffers were modified before saving
    local modified_count = 0
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].modified and vim.bo[bufnr].buftype == "" then
        modified_count = modified_count + 1
      end
    end

    -- silent! prevents errors on special buffers (terminals, etc.)
    vim.cmd("silent! wall")
    vim.cmd("redrawstatus")

    -- Show notification if files were actually saved
    if modified_count > 0 then
      local now = vim.fn.reltimefloat(vim.fn.reltime())
      -- Debounce: only notify once per second
      if now - last_save_notify >= 1 then
        last_save_notify = now
        local msg = modified_count == 1
          and "💾 Saved 1 file"
          or string.format("💾 Saved %d files", modified_count)
        vim.notify(msg, vim.log.levels.INFO)
      end
    end
  end,
})

-- Save current buffer after inactivity (250ms, controlled by updatetime)
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = save_group,
  desc = "Auto-save current buffer after inactivity",
  callback = function()
    -- Only save if:
    --   1. Buffer is modified (has unsaved changes)
    --   2. Buffer is a normal file (not terminal, help, etc.)
    --   3. Buffer has a filename (not a scratch buffer)
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      local filename = vim.fn.expand("%:t")
      vim.cmd("silent! write")
      vim.cmd("redrawstatus")

      -- Optional: Show very brief save indication (commented out by default)
      -- Uncomment if you want notification on every auto-save
      -- vim.notify("💾 " .. filename, vim.log.levels.INFO)
    end
  end,
})

-- Refresh statusline when buffer is modified
-- This ensures the [●] indicator updates immediately when you type
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  group = save_group,
  desc = "Refresh statusline on buffer modification",
  callback = function()
    vim.cmd("redrawstatus")
  end,
})
