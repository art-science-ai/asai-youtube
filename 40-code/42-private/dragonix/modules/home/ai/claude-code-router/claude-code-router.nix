{
  config,
  lib,
  pkgs,
  ...
}: let
  templateFile = ./config.template.json;
in {
  # Symlink static resources individually (not the whole directory)
  home.file.".claude-code-router/plugins".source = ./plugins;
  home.file.".claude-code-router/dabstractor-ccr-config".source = ./dabstractor-ccr-config;
  home.file.".claude-code-router/README.md".source = ./README.md;
  home.file.".claude-code-router/config.template.json".source = templateFile;

  # Wrapper script that generates config.json from template using envsubst
  home.packages = [
    (pkgs.writeShellScriptBin "ccr" ''
      CONFIG_DIR="$HOME/.claude-code-router"
      TEMPLATE="$CONFIG_DIR/config.template.json"
      CONFIG="$CONFIG_DIR/config.json"

      # Generate config from template with env vars substituted
      ${pkgs.envsubst}/bin/envsubst < "$TEMPLATE" > "$CONFIG"

      # Run the actual claude-code-router
      exec ${pkgs.nodejs}/bin/npx claude-code-router "$@"
    '')
  ];
}
