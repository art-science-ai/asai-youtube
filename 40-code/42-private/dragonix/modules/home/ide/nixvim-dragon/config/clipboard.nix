# Clipboard configuration for nixvim-dragon
#
# ISSUE: Clipboard freezing when copying file paths in yazi over SSH
#
# Problem:
# - When SSH'd into remote machine (vermax), clipboard operations in neovim freeze
# - Specifically occurs when copying file paths in yazi.nvim
# - OSC 52 paste causes ~10 second freeze with "Waiting for OSC 52 response" message
# - Setting clipboard="unnamedplus" in options.nix triggers clipboard on every yank
#
# Attempted Solutions:
# 1. Added wl-clipboard and xclip via extraPackages - didn't work over SSH
# 2. Configured OSC 52 for both copy and paste - freeze on paste operations
# 3. Configured OSC 52 copy-only with unnamed register fallback - still freezing
#
# Current Status: UNRESOLVED
# The configuration below should theoretically work but still causes freezing.
#
# References:
# - https://github.com/neovim/neovim/discussions/28010
# - https://github.com/neovim/neovim/issues/28611
# - https://github.com/sxyazi/yazi/issues/2123
# - https://jvns.ca/til/vim-osc52/
#
# TODO: Investigate further - may need to:
# - Check if tmux is interfering with OSC 52
# - Try disabling clipboard="unnamedplus" and use explicit "+y
# - Use a dedicated OSC 52 plugin like ojroques/nvim-osc52
# - Check WezTerm OSC 52 configuration

{
  extraConfigLua = ''
    -- OSC 52 clipboard support - copy only (paste doesn't work over SSH/TTY)
    local osc52 = require('vim.ui.clipboard.osc52')
    vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = osc52.copy('+'),
        ['*'] = osc52.copy('*'),
      },
      paste = {
        -- Use unnamed register for paste to avoid OSC52 timeout/freeze
        ['+'] = function() return {vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"')} end,
        ['*'] = function() return {vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"')} end,
      },
    }
  '';
}
