{
  config,
  lib,
  pkgs,
  ...
}: {
  # Custom binary for zclaude (z.ai proxy)
  # Uses ZAI_API_KEY from shell environment (loaded via sops-nix secret loader)
  home.packages = [
    (pkgs.writeShellScriptBin "zclaude" ''
      #!/usr/bin/env bash
      set -euo pipefail
      export OP_DISABLE_GUI="1"
      export ANTHROPIC_AUTH_TOKEN="$ZAI_API_KEY"
      export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
      export API_TIMEOUT_MS="3000000"
      exec claude "$@"
    '')
  ];
}
