-- =====================================================================
-- CLAUDE CODE INTEGRATION
-- =====================================================================
-- WebSocket-based integration with Claude Code CLI
-- Provides real-time AI assistance directly in Neovim

return {
  'coder/claudecode.nvim',
  dependencies = {
    'folke/snacks.nvim', -- Optional: Enhanced terminal support
  },
  config = true, -- Use default configuration

  -- Keymaps for Claude Code integration
  keys = {
    -- Main toggle for Claude Code terminal
    { '<leader>a', nil, desc = 'AI/Claude Code' },
    { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude Code' },

    -- Send text to Claude
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = { 'n', 'v' }, desc = 'Send to Claude' },

    -- Diff management
    { '<leader>ad', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept Claude Diff' },
  },
}
