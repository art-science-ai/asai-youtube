{ config, lib, ... }:

{
  # Surfingkeys browser extension configuration (cross-platform)
  home.file.".config/surfingkeys/surfingkeys.js".source = ./surfingkeys.js;
}