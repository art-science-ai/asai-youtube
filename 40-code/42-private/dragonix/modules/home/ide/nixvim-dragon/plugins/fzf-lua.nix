# fzf-lua: Fuzzy finder with native fzf performance and Lua integration
# Features:
# - Preview window enabled by default (unlike mini.pick which requires toggle)
# - Faster performance with native fzf
# - Better filename display with directory in faded color
# - Proper flag handling for live grep
{
  # =========================================================================
  # FZF-LUA PLUGIN CONFIGURATION
  # =========================================================================

  plugins.fzf-lua = {
    enable = true;

    # Configuration provided by user
    settings = {
      # Fix Issue #1: Truncation
      # This puts the filename first and the directory second in a faded color.
      defaults = {
        formatter = "path.filename_first";
      };

      # Fix Issue #2: Live Grep Flags
      grep = {
        rg_glob = true;        # Enables the '--' separator for flags
        glob_separator = " --"; # The string used to separate query from flags
      };
    };
  };

  # =========================================================================
  # KEYMAPS
  # =========================================================================
  # Leader keymaps are centralized in config/keymaps.nix
  # Example mappings to add:
  # - `<leader>ff` - Files (similar to mini.pick files)
  # - `<leader>fg` - Live grep (similar to mini.pick grep_live)
  # - `<leader>fb` - Buffers
  # - `<leader>fh` - Help tags
}
