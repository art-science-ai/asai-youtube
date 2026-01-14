# NPM and Node.js configuration
{
  config,
  pkgs,
  lib,
  ...
}:
let
  globalNpmPackages = [
    "ccusage"
    "backlog.md"
  ];
in
{
  # npm global package management
  home.file.".npmrc".text = ''
    prefix = ${config.home.homeDirectory}/.npm-global
  '';

  # npm path
  home.sessionPath = [ "${config.home.homeDirectory}/.npm-global/bin" ];

  # npm global package configuration
  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
  };

  # Run `npm install -g` for each entry in that list, with proper env setup:
  home.activation.installGlobalNpmPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    lib.concatStringsSep "\n" (
      [
        ''PREFIX="${config.home.homeDirectory}/.npm-global"''
        ''mkdir -p "$PREFIX"''
        ''export NPM_CONFIG_PREFIX="$PREFIX"''
        ''export PATH="$PREFIX/bin:${pkgs.nodejs}/bin:${pkgs.coreutils}/bin:/usr/bin:$PATH"''
      ]
      ++ map (pkg: "${pkgs.nodejs}/bin/npm install -g ${pkg}") globalNpmPackages
    )
  );

  # Enable home-manager
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
