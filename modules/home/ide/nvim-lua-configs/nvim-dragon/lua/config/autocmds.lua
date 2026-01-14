-- =====================================================================
-- AUTOCMDS: Essential autocommands for AI workflow
-- =====================================================================
--
-- Minimal autocmds for working with AI agents in split terminals.
--
-- Sections:
--   1. Auto-reload: Detect external file changes from AI edits
--   2. Auto-save: Prevent data loss when switching focus
--
-- =====================================================================

-- =====================================================================
-- AUTO-RELOAD: Detect external changes (AI agent edits)
-- =====================================================================
--
-- When working with AI agents in a split terminal, files may be edited
-- externally. These autocmds ensure those changes are visible immediately
-- in Neovim without manual reloading.
--
-- Strategy:
--   - Enable autoread globally
--   - Trigger checktime on focus, buffer entry, and cursor hold
--   - checktime only reloads if buffer hasn't changed locally
--
-- =====================================================================

local reload_group = vim.api.nvim_create_augroup("AutoReload", { clear = true })

-- Track if we've already notified about a reload to avoid spam
local last_reload_notify = {}

-- Show notification when file is reloaded from external changes
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = reload_group,
  desc = "Notify when file is auto-reloaded from external changes",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local short_name = vim.fn.fnamemodify(filename, ":t")

    -- Avoid duplicate notifications for the same file within 2 seconds
    local now = vim.fn.reltimefloat(vim.fn.reltime())
    if last_reload_notify[bufnr] and (now - last_reload_notify[bufnr]) < 2 then
      return
    end
    last_reload_notify[bufnr] = now

    -- Lazy load mini.notify and show notification with timeout
    local ok, notify = pcall(require, "mini.notify")
    if ok then
      -- Show notification with 2 second duration
      local notif_id = notify.add("󰑓 Reloaded: " .. short_name, "INFO")
      -- Schedule removal after 2 seconds
      vim.defer_fn(function()
        notify.remove(notif_id)
      end, 2000)
    end
  end,
})

-- Check for external changes when gaining focus
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

-- Check for external changes when cursor is idle
vim.api.nvim_create_autocmd("CursorHold", {
  group = reload_group,
  desc = "Check for external file changes on cursor hold",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- =====================================================================
-- AUTO-SAVE: Prevent data loss
-- =====================================================================
--
-- Automatically save files when losing focus or after inactivity.
-- This prevents losing work when switching to AI agents or other tasks.
--
-- Strategy:
--   - Save all modified buffers on focus loss
--   - Save current buffer after inactivity (CursorHold)
--   - Only save normal file buffers (not terminals, help, etc.)
--   - Trigger statusline refresh to show save indicator
--
-- Note: Save status is shown in statusline, not as notifications
--       This provides persistent visibility without being intrusive.
--
-- =====================================================================

local save_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- Save all modified buffers when losing focus
vim.api.nvim_create_autocmd("FocusLost", {
  group = save_group,
  desc = "Auto-save all buffers on focus loss",
  callback = function()
    vim.cmd("silent! wall")
    -- Refresh statusline to update save indicator
    vim.cmd("redrawstatus")
  end,
})

-- Save current buffer after inactivity
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = save_group,
  desc = "Auto-save current buffer after inactivity",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
      -- Refresh statusline to update save indicator
      vim.cmd("redrawstatus")
    end
  end,
})

-- Refresh statusline when buffer is modified/unmodified
-- This ensures the save indicator updates immediately when typing
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  group = save_group,
  desc = "Refresh statusline on buffer modification",
  callback = function()
    vim.cmd("redrawstatus")
  end,
})

-- =====================================================================
-- OPTIONAL ENHANCEMENTS: Uncomment if needed
-- =====================================================================
--
-- These are common quality-of-life improvements that can be enabled later.
-- Keeping them commented to maintain minimal configuration.
--
-- [[
-- local editor_group = vim.api.nvim_create_augroup("EditorEnhancements", { clear = true })
--
-- -- Restore cursor position when opening a file
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = editor_group,
--   desc = "Restore cursor position when opening file",
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     local lcount = vim.api.nvim_buf_line_count(0)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })
--
-- -- Highlight yanked text briefly
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   group = editor_group,
--   desc = "Highlight yanked text",
--   callback = function()
--     vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
--   end,
-- })
--
-- -- Create parent directories when saving a file
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = editor_group,
--   desc = "Auto-create parent directories when saving",
--   callback = function(event)
--     if event.match:match("^%w%w+://") then
--       return -- Skip for URLs like oil://
--     end
--     local file = vim.loop.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
--   end,
-- })
--
-- -- Disable auto-comment on new line
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = editor_group,
--   desc = "Disable auto-comment on new line",
--   callback = function()
--     vim.opt.formatoptions:remove({ "c", "r", "o" })
--   end,
-- })
-- ]]
