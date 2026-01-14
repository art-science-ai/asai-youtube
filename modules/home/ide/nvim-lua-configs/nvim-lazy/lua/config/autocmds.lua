-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Minimal autosave
vim.opt.autowriteall = true -- write on buffer/command transitions

vim.api.nvim_create_autocmd("FocusLost", { -- also save when leaving Neovim
  callback = function()
    local ok, err = pcall(vim.cmd, "wall")
    if not ok then
      vim.notify("Autosave failed: " .. err, vim.log.levels.ERROR)
    end
  end,
})

-- Additional trigger for terminal multiplexers where FocusLost doesn't fire
-- Save after 4.0 seconds of inactivity (CursorHold timeout)
vim.opt.updatetime = 4000
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.bo.modifiable and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
      local ok, err = pcall(vim.cmd, "silent update")
      if not ok then
        vim.notify("Autosave failed: " .. err, vim.log.levels.ERROR)
      end
    end
  end,
})

-- Enable auto-reload when files are changed outside of Neovim
vim.o.autoread = true

-- Check for file changes when regaining focus or after idle
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})

-- Notify when a file was reloaded due to external changes
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function(args)
    vim.notify("File changed on disk. Reloaded: " .. args.file, vim.log.levels.WARN)
  end,
})
