# Smart-splits: Enhanced window navigation
# Seamless navigation between vim splits and terminal multiplexer panes
#
# Integration with Zellij (via vim-zellij-navigator):
# - Zellij's vim-zellij-navigator plugin detects if neovim is running
# - CTRL+hjkl: Navigate between neovim splits and zellij panes
# - ALT+hjkl:  Resize neovim splits and zellij panes
# - Same keybindings work seamlessly across neovim and zellij boundaries
#
# No configuration needed on Neovim side - smart-splits auto-detects Zellij
{
  plugins.smart-splits = {
    enable = true;
    settings = {
      # Don't intercept keys in terminal buffers (yazi, shell, toggleterm)
      # This allows CTRL+hjkl to pass through to zellij for pane navigation
      ignored_buftypes = [ "terminal" ];
    };
  };

  keymaps = [
    # Moving between splits (CTRL+hjkl)
    {
      mode = "n";
      key = "<C-h>";
      action = "<Cmd>lua require('smart-splits').move_cursor_left()<CR>";
      options.desc = "Move to left split";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<Cmd>lua require('smart-splits').move_cursor_down()<CR>";
      options.desc = "Move to lower split";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<Cmd>lua require('smart-splits').move_cursor_up()<CR>";
      options.desc = "Move to upper split";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<Cmd>lua require('smart-splits').move_cursor_right()<CR>";
      options.desc = "Move to right split";
    }

    # Resizing splits (ALT+hjkl)
    {
      mode = "n";
      key = "<A-h>";
      action = "<Cmd>lua require('smart-splits').resize_left()<CR>";
      options.desc = "Resize split left";
    }
    {
      mode = "n";
      key = "<A-j>";
      action = "<Cmd>lua require('smart-splits').resize_down()<CR>";
      options.desc = "Resize split down";
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<Cmd>lua require('smart-splits').resize_up()<CR>";
      options.desc = "Resize split up";
    }
    {
      mode = "n";
      key = "<A-l>";
      action = "<Cmd>lua require('smart-splits').resize_right()<CR>";
      options.desc = "Resize split right";
    }

    # Leader keymaps for buffer swapping are now centralized in config/keymaps.nix
  ];
}
