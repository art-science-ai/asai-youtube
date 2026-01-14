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

  # Configure settings from settings.json
  programs.gemini-cli.settings = {
    security = {
      auth = {
        selectedType = "oauth-personal";
      };
    };
    general = {
      vimMode = true;
      preferredEditor = "hx";
      previewFeatures = true;
    };
    ui = {
      theme = "GitHub";
      hideBanner = true;
      hideTips = false;
    };
    tools = { };
    mcpServers = { };
    telemetry = { };
    privacy = { };
    model = { };
    context = {
      fileName = [
        "AGENTS.md"
      ];
      includeDirectories = [ ];
      loadFromIncludeDirectories = false;
      discoveryMaxDirs = 2;
      fileFiltering = {
        respectGitIgnore = true;
      };
    };
    advanced = { };
  };

  # Note: google_accounts.json contains authentication data and is not managed declaratively.
  # It should be symlinked manually from dotfiles/gemini/.gemini/google_accounts.json to ~/.gemini/google_accounts.json
}
