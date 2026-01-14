-- auto-save
-- https://github.com/pocco81/auto-save.nvim

return {
  'pocco81/auto-save.nvim',
  event = { 'InsertLeave', 'TextChanged' },
  opts = {
    enabled = true,
    execution_message = {
      enabled = true,
      message = function()
        return ('Auto-saved at ' .. vim.fn.strftime('%H:%M:%S'))
      end,
      dim = 0.18,
      cleaning_interval = 1250,
    },
    trigger_events = {
      immediate_save = { 'BufLeave', 'FocusLost' },
      defer_save = { 'InsertLeave', 'TextChanged' },
      cancel_deferred_save = { 'InsertEnter' },
    },
    condition = function(buf)
      local fn = vim.fn
      local utils = require('auto-save.utils.data')

      -- Don't save for special buffers or filetypes
      if fn.getbufvar(buf, '&modifiable') == 1 and utils.not_in(fn.getbufvar(buf, '&filetype'), {}) then
        return true
      end
      return false
    end,
    write_all_buffers = false,
    debounce_delay = 1000,
    callbacks = {
      enabling = nil,
      disabling = nil,
      before_asserting_save = nil,
      before_saving = nil,
      after_saving = nil,
    },
  },
}
