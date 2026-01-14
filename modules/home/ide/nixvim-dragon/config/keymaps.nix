# Basic keymaps - essential navigation and editor commands
{
  keymaps = [
  # Navigation: Visual line movement for soft-wrapped text
  {
    mode = ["n" "x"];
    key = "j";
    action = "gj";
    options.desc = "Move down by visual line";
  }
  {
    mode = ["n" "x"];
    key = "k";
    action = "gk";
    options.desc = "Move up by visual line";
  }
  {
    mode = ["n" "x"];
    key = "gj";
    action = "j";
    options.desc = "Move down by file line";
  }
  {
    mode = ["n" "x"];
    key = "gk";
    action = "k";
    options.desc = "Move up by file line";
  }

  # General navigation: center screen when jumping
  {
    mode = "n";
    key = "n";
    action = "nzzzv";
    options.desc = "Next search result (centered)";
  }
  {
    mode = "n";
    key = "N";
    action = "Nzzzv";
    options.desc = "Previous search result (centered)";
  }

   # Save file
   {
     mode = "n";
     key = "<C-s>";
     action = "<cmd>w<CR>";
     options.desc = "Save file";
    }

    # =========================================================================
    # LEADER KEYMAPS
    # =========================================================================

    # -----------------------------------------------------------------------
    # BUFFER OPERATIONS (<leader>b)
    # -----------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>bn";
      action = "<Cmd>bnext<CR>";
      options.desc = "Next buffer";
    }
     {
       mode = "n";
       key = "<leader>bp";
       action = "<Cmd>bprevious<CR>";
       options.desc = "Previous buffer";
     }
     {
       mode = "n";
       key = "<leader>bb";
       action = "<Cmd>b#<CR>";
       options.desc = "Switch to other buffer";
     }
     {
       mode = "n";
       key = "<leader>bd";
       action = "<Cmd>bd<CR>";
       options.desc = "Delete buffer";
     }
     {
       mode = "n";
       key = "<leader>bD";
       action = "<Cmd>bd!<CR>";
       options.desc = "Delete buffer (force)";
     }
     {
       mode = "n";
       key = "<leader>bo";
       action = "<Cmd>%bd|e#<CR>";
       options.desc = "Delete other buffers";
     }
     {
       mode = "n";
       key = "<leader>be";
       action = "<Cmd>enew<CR>";
       options.desc = "New buffer";
     }

    # -----------------------------------------------------------------------
    # FIND/SEARCH (<leader>f)
    # -----------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Pick files<CR>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Pick grep_live<CR>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Pick buffers<CR>";
      options.desc = "Find buffers";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>Pick resume<CR>";
      options.desc = "Resume previous picker";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Pick help<CR>";
      options.desc = "Find help tags";
    }

    {
      mode = "n";
      key = "<leader>fc";
      action = "<Cmd>Pick commands<CR>";
      options.desc = "Find commands";
    }
    {
      mode = "n";
      key = "<leader>fH";
      action = "<Cmd>Pick hl_groups<CR>";
      options.desc = "Find highlight groups";
    }
    {
      mode = "n";
      key = "<leader>f/";
      action = "<Cmd>Pick history scope=\"/\"<CR>";
      options.desc = "Search history";
    }
    {
      mode = "n";
      key = "<leader>f:";
      action = "<Cmd>Pick history scope=\":\"<CR>";
      options.desc = "Command history";
    }

    # -----------------------------------------------------------------------
    # GIT OPERATIONS (<leader>g)
    # -----------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>gg";
      action = "<Cmd>Neogit<CR>";
      options.desc = "Git status";
    }
    {
      mode = "n";
      key = "<leader>gc";
      action = "<Cmd>Neogit commit<CR>";
      options.desc = "Commit";
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = "<Cmd>Neogit push<CR>";
      options.desc = "Push";
    }
    {
      mode = "n";
      key = "<leader>gP";
      action = "<Cmd>Neogit pull<CR>";
      options.desc = "Pull";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<Cmd>Neogit branch<CR>";
      options.desc = "Branch";
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = "<Cmd>DiffviewOpen<CR>";
      options.desc = "Diff view";
    }
    {
      mode = "n";
      key = "<leader>gD";
      action = "<Cmd>DiffviewClose<CR>";
      options.desc = "Close diff view";
    }

    # -----------------------------------------------------------------------
    # QUIT/SESSION (<leader>q)
    # -----------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>qq";
      action = "<Cmd>qa<CR>";
      options.desc = "Quit all";
    }
    {
      mode = "n";
      key = "<leader>qQ";
      action = "<Cmd>qa!<CR>";
      options.desc = "Quit all (force)";
    }
    {
      mode = "n";
      key = "<leader>qd";
      action = "<Cmd>q!<CR>";
      options.desc = "Quit without saving";
    }
    {
      mode = "n";
      key = "<leader>qr";
      action = "<Cmd>source $MYVIMRC<CR>";
      options.desc = "Reload config";
    }
    {
      mode = "n";
      key = "<leader>qR";
      action = "<Cmd>lua vim.cmd('source $MYVIMRC'); vim.notify('Config reloaded!', vim.log.levels.INFO)<CR>";
      options.desc = "Reload config (with notification)";
    }
    {
      mode = "n";
      key = "<leader>qw";
      action = "<cmd>wqa<CR>";
      options.desc = "Save and quit all";
    }

    # -----------------------------------------------------------------------
    # TERMINAL (<leader>t)
    # -----------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>tt";
      action = "<Cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "n";
      key = "<leader>th";
      action = "<Cmd>ToggleTerm direction=horizontal<CR>";
      options.desc = "Horizontal terminal";
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = "<Cmd>ToggleTerm direction=vertical<CR>";
      options.desc = "Vertical terminal";
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<Cmd>ToggleTerm direction=float<CR>";
      options.desc = "Floating terminal";
    }

    # -----------------------------------------------------------------------
    # EXPLORE/EDIT (<leader>e)
    # -----------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>ee";
      action = "<cmd>Yazi<cr>";
      options.desc = "Open yazi at the current file";
    }
    {
      mode = "n";
      key = "<leader>eE";
      action = "<cmd>Yazi cwd<cr>";
      options.desc = "Open the file manager in nvim's working directory";
    }

    # -----------------------------------------------------------------------
    # SMART SPLITS (<leader>s)
    # -----------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>sh";
      action = "<Cmd>lua require('smart-splits').swap_buf_left()<CR>";
      options.desc = "Swap buffer left";
    }
    {
      mode = "n";
      key = "<leader>sj";
      action = "<Cmd>lua require('smart-splits').swap_buf_down()<CR>";
      options.desc = "Swap buffer down";
    }
    {
      mode = "n";
      key = "<leader>sk";
      action = "<Cmd>lua require('smart-splits').swap_buf_up()<CR>";
      options.desc = "Swap buffer up";
    }
     {
       mode = "n";
       key = "<leader>sl";
       action = "<Cmd>lua require('smart-splits').swap_buf_right()<CR>";
       options.desc = "Swap buffer right";
     }

     # -----------------------------------------------------------------------
     # CODE ACTIONS (<leader>c)
     # -----------------------------------------------------------------------
     {
       mode = "n";
       key = "<leader>ca";
       action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
       options.desc = "Code action";
     }
     {
       mode = "n";
       key = "<leader>cr";
       action = "<cmd>lua vim.lsp.buf.rename()<CR>";
       options.desc = "Rename symbol";
     }
     {
       mode = "n";
       key = "<leader>cf";
       action = "<cmd>lua vim.lsp.buf.format()<CR>";
       options.desc = "Format buffer";
     }

     # -----------------------------------------------------------------------
     # DIAGNOSTICS (<leader>x) - Trouble integration
     # -----------------------------------------------------------------------
     {
       mode = "n";
       key = "<leader>xx";
       action = "<cmd>Trouble diagnostics toggle<CR>";
       options.desc = "Document diagnostics";
     }
     {
       mode = "n";
       key = "<leader>xw";
       action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
       options.desc = "Workspace diagnostics";
     }
     {
       mode = "n";
       key = "<leader>xl";
       action = "<cmd>Trouble loclist toggle<CR>";
       options.desc = "Location list";
     }
     {
       mode = "n";
       key = "<leader>xq";
       action = "<cmd>Trouble qflist toggle<CR>";
       options.desc = "Quickfix list";
     }
     {
       mode = "n";
       key = "<leader>xr";
       action = "<cmd>Trouble lsp_references toggle<CR>";
       options.desc = "LSP references";
     }
   ];

}
