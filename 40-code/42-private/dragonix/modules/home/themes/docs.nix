# Document generation tools (TexLive, Pandoc, Typst)
{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Custom texlive with scheme-small plus catppuccinpalette and dependencies
  myTexlive = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-small catppuccinpalette pgfopts sectsty pdfjam;
  };
in
{
  # Install texlive, pandoc, and typst to user profile
  home.packages = [ myTexlive pkgs.pandoc pkgs.typst ];

  # Install pandoc templates and defaults for markdown-to-PDF conversion with Catppuccin
  # Using ~/.local/share/pandoc/ which is the standard XDG location pandoc checks
  home.file = let
    templateDir = ./templates;
    files = builtins.readDir templateDir;

    # Helper to determine destination path based on file extension
    getDestPath = name:
      if lib.hasSuffix ".yaml" name then
        ".local/share/pandoc/defaults/${name}"
      else
        ".local/share/pandoc/templates/${name}";

    # Create file entries dynamically for all templates
    fileEntries = lib.mapAttrs' (name: _:
      lib.nameValuePair (getDestPath name) {
        source = templateDir + "/${name}";
      }
    ) files;
  in
  fileEntries;
}