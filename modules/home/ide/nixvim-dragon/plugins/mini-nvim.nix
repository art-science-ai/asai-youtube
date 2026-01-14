# Mini.nvim: Swiss army knife of Neovim plugins
# Consolidated configuration for all mini.nvim modules
#
# Philosophy: mini.nvim provides a collection of minimal, independent modules
# that work well together. All modules are loaded from a single plugin for
# consistent initialization and no loading order issues.
#
# Modules included:
# - UI & Navigation: pick, statusline, tabline, clue, icons, notify
# - Text Editing: comment, pairs, surround
{
  # =========================================================================
  # MINI.NVIM PLUGIN CONFIGURATION
  # =========================================================================

  plugins.mini = {
    enable = true;

    modules = {
      # -----------------------------------------------------------------------
      # UI & NAVIGATION MODULES
      # -----------------------------------------------------------------------

      # mini.statusline: Minimal statusline with git and diagnostics
      # Shows: mode, filename ([+] when modified), git branch, LSP diagnostics, location
      statusline = {
        enable = true;
        # Use defaults - clean and informative
      };

      # mini.notify: Prominent notifications for AI workflow
      # Enhanced configuration for clear visibility of reload/save events
      notify = {
        enable = true;
        # Window positioning and appearance. 
        window = {
          max_width_share = 0.5; # Wider notifications (50% of screen width)
          winblend = 0; # Fully opaque (no transparency)
        };
        # Enable LSP progress notifications
        lsp_progress = {
          enable = true;
          duration_last = 1000; # Show LSP messages for 1 second
        };
      };

      # -----------------------------------------------------------------------
      # TEXT EDITING MODULES
      # -----------------------------------------------------------------------

      # mini.comment: Smart commenting (gcc, gc motion)
      comment = {
        enable = true;
      };

      # mini.pairs: Auto-close brackets, quotes, etc.
      pairs = {
        enable = true;
      };

      # mini.surround: Add/delete/replace surroundings (sa, sd, sr)
      surround = {
        enable = true;
      };
    };
  };

  # These mini modules use individual plugin declarations instead of plugins.mini.modules.*
  # Both patterns are supported, but individual plugins provide:
  # - Stronger type safety with nixvim's option system
  # - Special features (e.g., mockDevIcons for mini-icons)
  # - Explicit dependency declarations (e.g., ripgrep for mini-pick)
  # - Better suited for complex configurations with many keybindings
  plugins = {
    # mini.pick: Fuzzy finder and picker
    mini-pick = {
      enable = true;
      settings = {
        # Use default window configuration (already well-centered)
        # Custom centering requires Lua functions which can't be expressed in Nix settings
      };
    };



    # mini.icons: Icon provider (mocks web-devicons)
    mini-icons = {
      enable = true;
      mockDevIcons = true; # Mock web-devicons to avoid conflicts
    };

    # mini.tabline: Buffer tabline
    mini-tabline = {
      enable = true;
    };
  };

  # =========================================================================
  # KEYMAPS
  # =========================================================================
  # Leader keymaps are now centralized in config/keymaps.nix
}
