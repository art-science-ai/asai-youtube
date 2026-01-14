# Toggleterm: Terminal management
# Provides persistent terminal windows inside neovim with multiple layouts
#
# Quick Toggle:
#   CTRL+\  - Show/hide default floating terminal (fastest access)
#
# Layout Options:
#   <leader>tt - Toggle default (floating, 80% screen)
#   <leader>th - Horizontal split at bottom (full width)
#   <leader>tv - Vertical split on right (full height)
#   <leader>tf - Floating window (explicit)
#
# Exit Terminal Mode:
#   <Esc><Esc> - Double escape to return to normal mode
#   CTRL+\     - Quick exit to normal mode
#
# Behavior:
# - All terminals are PERSISTENT - hiding doesn't kill the shell session
# - Each layout maintains its own independent terminal instance
# - CTRL+hjkl passes through to WezTerm (thanks to smart-splits ignored_buftypes)
#
{
  plugins.toggleterm = {
    enable = true;
    settings = {
      # CTRL+\ to quickly toggle terminal
      open_mapping = {
        __raw = "[[<C-\\>]]";
      };
      # Default layout: floating window
      direction = "float";
      # Floating window appearance
      float_opts = {
        border = "curved";
      };
    };
  };

  # TODO: Add dedicated terminal instances for better control
  # Currently all keymaps call ToggleTerm which may reuse or create new terminals.
  # Consider implementing Option 1: Dedicated terminals for each layout
  # - <leader>tt → Always same floating terminal instance
  # - <leader>tv → Always same vertical terminal instance
  # - <leader>th → Always same horizontal terminal instance
  # This would require extraConfigLua with Terminal:new() for each layout
  # See: https://github.com/akinsho/toggleterm.nvim#custom-terminals

  # Leader keymaps are now centralized in config/keymaps.nix
  keymaps = [
    # Terminal mode mappings (non-leader)
    { mode = "t"; key = "<Esc><Esc>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }
    # Ctrl+\ in terminal mode also exits to normal mode
    { mode = "t"; key = "<C-\\>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }
  ];
}
