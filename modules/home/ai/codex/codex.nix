{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Codex
  programs.codex.enable = true;
  # programs.codex.package = inputs.llm-agents.packages.${pkgs.system}.codex;
  programs.codex.package = null;

  # Configure Codex with proper XDG config directory
  programs.codex.settings = {
    model = "gpt-5.2-codex-max";
    projects = {
      "${config.home.homeDirectory}/repos" = {
        trust_level = "trusted";
      };
    };
  };
}
