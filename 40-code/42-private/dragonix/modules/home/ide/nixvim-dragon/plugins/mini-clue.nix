# Mini.clue: Keybinding hints and leader key groups
# Provides which-key like functionality for leader key sequences
{
  plugins.mini-clue = {
    enable = true;
    settings = {
      # Window configuration
      window = {
        delay = 0; # Show hints immediately (no delay)
        config = {
          width = "auto";
          border = "rounded";
        };
      };

      # Triggers: When to show the hint window
      triggers = [
        # Leader key sequences
        { mode = "n"; keys = "<Leader>"; }
        { mode = "x"; keys = "<Leader>"; }

        # Local leader
        { mode = "n"; keys = "<LocalLeader>"; }
        { mode = "x"; keys = "<LocalLeader>"; }

        # Built-in completion
        { mode = "i"; keys = "<C-x>"; }

        # `g` key sequences
        { mode = "n"; keys = "g"; }
        { mode = "x"; keys = "g"; }

        # Marks
        { mode = "n"; keys = "'"; }
        { mode = "n"; keys = "`"; }
        { mode = "x"; keys = "'"; }
        { mode = "x"; keys = "`"; }

        # Registers
        { mode = "n"; keys = "\""; }
        { mode = "x"; keys = "\""; }
        { mode = "i"; keys = "<C-r>"; }
        { mode = "c"; keys = "<C-r>"; }

        # Window commands
        { mode = "n"; keys = "<C-w>"; }

        # `z` key sequences
        { mode = "n"; keys = "z"; }
        { mode = "x"; keys = "z"; }
      ];

      # Leader key groups - centralized from config/keymaps.nix
      clues = [
        # Buffer operations
        { mode = "n"; keys = "<leader>b"; desc = "+Buffer"; }
        
        # Find operations
        { mode = "n"; keys = "<leader>f"; desc = "+Find"; }
        
        # Git operations
        { mode = "n"; keys = "<leader>g"; desc = "+Git"; }
        
        # Quit/Session operations
        { mode = "n"; keys = "<leader>q"; desc = "+Quit/Session"; }
        
        # Terminal operations
        { mode = "n"; keys = "<leader>t"; desc = "+Toggle"; }
        
        # Explore/Edit operations
        { mode = "n"; keys = "<leader>e"; desc = "+Explore/Edit"; }
        
        # Smart Splits operations
        { mode = "n"; keys = "<leader>s"; desc = "+Smart Splits"; }

        {mode = "n"; keys = "<leader>c"; desc = "+Code"; }
      ];
    };
  };
}
