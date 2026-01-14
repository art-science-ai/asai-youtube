{ config, lib, pkgs, system, ... }:
let isLinux = !lib.hasSuffix "-darwin" system;
in {
  imports = if isLinux then [ ./web-apps.nix ] else [ ];
}
