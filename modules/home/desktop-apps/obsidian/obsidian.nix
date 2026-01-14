{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Obsidian configuration using mkOutOfStoreSymlink
  # Links obsidian-desktop directory from dotfiles
  xdg.configFile."obsidian/obsidian-desktop" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nix-config/modules/home/desktop-apps/obsidian/obsidian-desktop";
    recursive = true;
  };
}
