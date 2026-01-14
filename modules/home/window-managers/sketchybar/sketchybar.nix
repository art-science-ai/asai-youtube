{ config, lib, ... }:

{
  # Sketchybar status bar configuration
  home.file.".config/sketchybar/sketchybarrc".source = ./sketchybarrc;
  home.file.".config/sketchybar/plugins".source = ./plugins;
}