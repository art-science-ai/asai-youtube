{ config, lib, system, ... }:

{
  imports = [
    ./aerospace
    ./gnome
    ./hyprspace
    ../keyboard
    ./noctalia-niri
    ./sketchybar
    ./vicinae
  ];
}