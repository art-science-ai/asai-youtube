{
  config,
  lib,
  ...
}: {
  programs.fabric-ai = {
    enable = true;
    enableBashIntegration = true;
    enablePatternsAliases = true;
    enableYtAlias = true;
    enableZshIntegration = true;
  };
}
