{
  config,
  pkgs,
  ...
}:
{
  # Dependencies for plugins (Which-Key needs Python)
  home.packages = with pkgs; [
    python3
  ];

  programs.tmux = {
    enable = true;
    shortcut = "b"; # Default Ctrl-b
    baseIndex = 1; # Start windows/panes at 1
    escapeTime = 0; # Fix for vim delay
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    
    plugins = with pkgs.tmuxPlugins; [
      # Theme (config must load BEFORE plugin)
      {
        plugin = catppuccin;
        extraConfig = ''
          # Catppuccin configuration (loaded before plugin)
          # Use #W (window name) not #T (hostname) for tab names
          set -g @catppuccin_window_text " #W"
          set -g @catppuccin_window_current_text " #W"
          set -g @catppuccin_status_modules_right "directory session"
        '';
      }

      # Utilities
      yank

      # Which-Key (config must load BEFORE plugin)
      {
        plugin = tmux-which-key;
        extraConfig = ''
          # which-key configuration (loaded before plugin)
          set -g @tmux-which-key-xdg-enable 1
        '';
      }

      # Session Manager
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          # tmux-sessionx configuration (loaded before plugin)
          set -g @sessionx-bind 'f'
          set -g @sessionx-window-mode 'on'
          set -g @sessionx-tree-mode 'on'
        '';
      }
    ];

    extraConfig = ''
      # ==========================
      # Appearance
      # ==========================
      
      # Move status bar to the top
      set-option -g status-position top

      # Active Pane Borders (Zellij style)
      # Heavy lines for a clearer "frame" effect
      set -g pane-border-lines heavy
      set -g pane-border-style "fg=#494d64" # surface0 (inactive)
      set -g pane-active-border-style "fg=#f4dbd6" # rosewater (active)

      # Pane title bar (like Zellij pane headers)
      set -g pane-border-status top
      set -g pane-border-format " #{pane_current_command} "
      set -g pane-border-indicators both # arrows + color

      # Dim inactive panes for clearer focus
      set -g window-style "bg=#1e2030" # mantle (dimmed)
      set -g window-active-style "bg=#24273a" # base (normal)

      # ==========================
      # Sensible Defaults
      # ==========================
      
      set -g renumber-windows on

      # ==========================
      # Keybindings (WezTerm/Browser Style)
      # ==========================

      # New Tab (Window) - Ctrl+Shift+t
      bind -n C-T new-window -c "#{pane_current_path}"
      
      # Close Tab (Window) - Ctrl+Shift+w (Avoids Ctrl+w conflict)
      bind -n C-S-w kill-window

      # Cycle Tabs - Ctrl+Tab / Ctrl+Shift+Tab
      bind -n C-Tab next-window
      bind -n C-S-Tab previous-window

      # Navigation (Smart Splits)
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\S+\/)?g?(view|n?vim?x?)(diff)?$" 
      
      bind-key -n C-h if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n C-j if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n C-k if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n C-l if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

      # Resize Panes (Alt + h/j/k/l)
      bind -n M-h resize-pane -L 5
      bind -n M-j resize-pane -D 5
      bind -n M-k resize-pane -U 5
      bind -n M-l resize-pane -R 5

      # Split in current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Kill session with confirmation
      bind q confirm-before -p "Kill session #S? (y/n)" kill-session

      # ==========================
      # Automation
      # ==========================

      # Auto-name tabs to current directory
      set-option -g status-interval 1
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'

      # Default Layout Hook (Left 70%, Right 30%)
      # Creates a horizontal split on new session, giving left pane 70% width
      set-hook -g after-new-session 'split-window -h -l 30%; select-pane -L'
    '';
  };
}
