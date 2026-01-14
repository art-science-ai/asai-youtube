# Centralized secrets registry and helper functions
# Shared between system (sops.nix) and home-manager (shell-config.nix) modules
# Pure data and functions - no module configuration

{ lib }:

let
  # Centralized secret definitions - single source of truth
  # Maps each secret to its sops path, file path, environment variable name, owner, and mode
  secretDefinitions = {
    github-token = {
      sopsPath = "github/token";
      filePath = "/run/secrets/github/token";
      envVar = "GITHUB_TOKEN";
      owner = "nikhilmaddirala";
      mode = "0400";
    };

    github-username = {
      sopsPath = "github/username";
      filePath = "/run/secrets/github/username";
      envVar = "GITHUB_USERNAME";
      owner = "nikhilmaddirala";
      mode = "0400";
    };

    github-email = {
      sopsPath = "github/email";
      filePath = "/run/secrets/github/email";
      envVar = "GITHUB_EMAIL";
      owner = "nikhilmaddirala";
      mode = "0400";
    };

    openai-api-key = {
      sopsPath = "openai/api_key";
      filePath = "/run/secrets/openai/api_key";
      envVar = "OPENAI_API_KEY";
      owner = "nikhilmaddirala";
      mode = "0400";
    };

    openrouter-api-key = {
      sopsPath = "openrouter/api_key";
      filePath = "/run/secrets/openrouter/api_key";
      envVar = "OPENROUTER_API_KEY";
      owner = "nikhilmaddirala";
      mode = "0400";
    };

    todoist-api-token = {
      sopsPath = "todoist/api_token";
      filePath = "/run/secrets/todoist/api_token";
      envVar = "TODOIST_API_TOKEN";
      owner = "nikhilmaddirala";
      mode = "0400";
    };

    cloudflare-seasmoke = {
      sopsPath = "cloudflare/api_token_seasmoke";
      filePath = "/run/secrets/cloudflare/api_token_seasmoke";
      envVar = "CLOUDFLARE_API_TOKEN";
      owner = "root";
      mode = "0400";
    };

    zai-api-key = {
      sopsPath = "zai/api_key";
      filePath = "/run/secrets/zai/api_key";
      envVar = "ZAI_API_KEY";
      owner = "nikhilmaddirala";
      mode = "0400";
    };
  };

  # Helper: Convert secret definitions to sops.secrets format
  mkSopsSecrets = secretDefs: group:
    lib.mapAttrs' (name: def:
      lib.nameValuePair def.sopsPath {
        path = def.filePath;
        owner = def.owner;
        group = group;
        mode = def.mode;
      }
    ) secretDefs;

  # Helper: Generate bash/zsh init script for loading secrets
  mkBashSecretLoader = secretDefs:
    lib.concatMapStringsSep "\n" (def:
      "[ -r ${def.filePath} ] && export ${def.envVar}=$(cat ${def.filePath})"
    ) (lib.attrValues secretDefs);

  # Helper: Generate fish shell init script for loading secrets
  mkFishSecretLoader = secretDefs:
    lib.concatMapStringsSep "\n" (def:
      "test -r ${def.filePath} && set -gx ${def.envVar} (cat ${def.filePath})"
    ) (lib.attrValues secretDefs);

  # Helper: Generate nushell environment variables for loading secrets
  mkNushellSecretEnvVars = secretDefs:
    lib.listToAttrs (map (def:
      lib.nameValuePair def.envVar {
        condition = "test -r ${def.filePath}";
        value = "(cat ${def.filePath})";
      }
    ) (lib.attrValues secretDefs));
in
{
  inherit secretDefinitions mkSopsSecrets mkBashSecretLoader mkFishSecretLoader mkNushellSecretEnvVars;
}
