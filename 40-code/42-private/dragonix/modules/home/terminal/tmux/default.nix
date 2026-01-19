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
      # Theme
      catppuccin
      
      # Utilities
      yank
      tmux-which-key 
      
      # Session Manager
      tmux-sessionx
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
      set -g pane-border-style "fg=#494d64" # surface0
      set -g pane-active-border-style "fg=#f4dbd6" # rosewater

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
      # Plugin Configuration
      # ==========================

      # Catppuccin Theme Configuration
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_text "#W"
      set -g @catppuccin_window_text "#W"
      set -g @catppuccin_status_modules_right "directory session"

      # tmux-sessionx configuration
      set -g @sessionx-bind 'f'
      set -g @sessionx-window-mode 'on'
      set -g @sessionx-tree-mode 'on'

      # which-key configuration
      set -g @tmux-which-key-xdg-enable 1

      # ==========================
      # Automation
      # ==========================
      
      # Auto-name tabs to current directory
      set-option -g status-interval 1
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'
      
      # Default Layout Hook (Left 70%, Right 30%)
      set-hook -g after-new-session 'select-layout main-vertical; resize-pane -t 0 -x 70%'
    '';
  };
}
