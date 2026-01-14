# CLI module - combines development tools, shell configurations, and npm setup
# Provides:
# - miscellaneous: Various CLI configurations (git-jj, nh, npm-config, yazi, etc.)
# - packages.nix: Terminal utilities, editors, compilers, language servers, formatters
# - programs.nix: Program configurations (editors, git, shell tools, etc.)
# - shell-config.nix: Shell configurations (bash, zsh, fish, nushell) with aliases
# - npm-config.nix: NPM and Node.js configuration with global packages
# - just: Command runner with custom recipes
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./miscellaneous
    ./just
  ];
}