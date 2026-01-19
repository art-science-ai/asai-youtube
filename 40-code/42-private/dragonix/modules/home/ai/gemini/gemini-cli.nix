{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  # Gemini CLI configuration module
  # Migrates gemini-cli configuration from dotfiles to declarative home-manager setup

  # Enable gemini-cli
  programs.gemini-cli.enable = true;
  programs.gemini-cli.package = inputs.llm-agents.packages.${pkgs.system}.gemini-cli;

  # Copy files to config directory
  home.file.".gemini/commands/gh-commit.toml".source = ./commands/gh-commit.toml;
  home.file.".gemini/commands/gh-issue.toml".source = ./commands/gh-issue.toml;
  home.file.".gemini/AGENTS.md".source = ../common/AGENTS.md;

  # Mutable settings.json using mkOutOfStoreSymlink for Gemini CLI configuration
  # Place where Gemini CLI expects it: ~/.gemini/settings.json
  home.file.".gemini/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nix-config/modules/home/ai/gemini/settings.json";

  # Note: google_accounts.json contains authentication data and is not managed declaratively.
  # It should be symlinked manually from dotfiles/gemini/.gemini/google_accounts.json to ~/.gemini/google_accounts.json
}
