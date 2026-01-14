# Blink completion configuration
# Replaces nvim-cmp with blink.cmp for faster completion
{
  plugins = {
    # Main completion engine - blink.cmp
    blink-cmp = {
      enable = true;

      settings = {
        # Sources configuration
        sources = {
          default = [ "lsp" "buffer" "snippets" "path" ];
        };

         # Completion menu with visible source labels
         completion = {
           menu = {
             border = "single";
             draw = {
               columns = [
                 [ "kind_icon" "kind" ]
                 [ "label" "label_description" ]
                 [ "source_name" ]
               ];
             };
           };

           # Auto-show documentation for the currently highlighted item
           documentation = {
             auto_show = true;
           };
         };

        # Use built-in "enter" preset for all keymaps (no custom config needed)
        keymap = {
          preset = "enter";
        };

        # Snippet integration
        snippets = {
          preset = "luasnip";
        };

        # Command-line completion (enabled for colon commands)
        cmdline = {
          enabled = true;
          completion = {
            menu = {
              auto_show.__raw = ''
                function(ctx)
                  return vim.fn.getcmdtype() == ":"
                end
              '';
            };
          };
        };

        # Experimental signature help (commented out for now)
        # signature = { enabled = true; };
      };
    };

    # Snippet engine
    luasnip.enable = true;

    # Copilot integration (ghost text only, kept separate from blink menu)
    # copilot = {
    #   enable = true;
    #   cmd = "Copilot";
    #   event = "InsertEnter";
    #   settings = {
    #     panel = { enabled = false; };
    #     suggestion = {
    #       enabled = true;
    #       auto_trigger = true;
    #       keymap = {
    #         accept = "<C-l>";     # Accept Copilot ghost text
    #         dismiss = "<C-]>";    # Dismiss Copilot suggestion
    #         next = "<M-]>";       # Next Copilot suggestion
    #         prev = "<M-[>";       # Previous Copilot suggestion
    #       };
    #     };
    #   };
    # };
  };
}
