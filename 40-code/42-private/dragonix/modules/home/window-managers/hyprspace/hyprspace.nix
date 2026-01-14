{ config, lib, ... }:

{
  # Hyprspace workspace manager configuration (macOS only)
  home.file.".config/hyprspace.toml".source = ./hyprspace.toml;
}