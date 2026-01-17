# Clipboard management - Wayland tools and CopyQ clipboard manager
{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # ============================================================
    # WAYLAND CLIPBOARD TOOLS
    # ============================================================
    wl-clipboard  # wl-copy and wl-paste for Wayland clipboard access

    # ============================================================
    # SSH CLIPBOARD FORWARDING
    # ============================================================
    lemonade  # Clipboard forwarding over SSH (alternative to OSC 52)
  ];

  # ============================================================
  # CLIPBOARD MANAGER - CopyQ
  # ============================================================
  # CopyQ supports:
  # - Text, HTML, images, and other formats
  # - Clipboard history with configurable size
  # - Search and edit clipboard items
  # - Scripting and automation
  # - Cross-platform (Linux, macOS, Windows)
  services.copyq = {
    enable = true;
    # forceXWayland = false;  # Set to false for native Wayland support
    # systemdTarget = "graphical-session.target";  # Default
  };
}
