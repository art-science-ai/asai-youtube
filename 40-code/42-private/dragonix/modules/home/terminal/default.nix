# Terminal module - combines terminal emulators and multiplexers
# Provides:
# - wezterm: Modern GPU-accelerated terminal emulator
# - zellij: Terminal workspace and multiplexer
# - misc: Additional terminal emulators (ghostty, kitty)
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./wezterm
    ./zellij
    ./tmux
    ./misc
  ];
}
