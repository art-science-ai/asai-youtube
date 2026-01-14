{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Claude Code configuration
  programs.claude-code.enable = true;
  programs.claude-code.package = inputs.llm-agents.packages.${pkgs.system}.claude-code;

  # Mutable settings.json using mkOutOfStoreSymlink for Claude Code configuration
  # Place where Claude expects it: ~/.claude/settings.json
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/nix-config/modules/home/ai/claude/settings.json";

  # Statusline scripts - managed declaratively
  home.file.".claude/statusline.py" = {
    source = ./statusline.py;
    executable = true;
  };

  home.file.".claude/statusline.sh" = {
    source = ./statusline.sh;
    executable = true;
  };

  # Documentation symlink to shared AGENTS.md
  home.file.".claude/CLAUDE.md".source = ../common/AGENTS.md;
}