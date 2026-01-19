{ config, lib, ... }:

{
  programs.kitty = {
    enable = true;
  };
  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "none";
    };
  };
}
