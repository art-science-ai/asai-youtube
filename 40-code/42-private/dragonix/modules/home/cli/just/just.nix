{ config, lib, ... }:

{
  # Source the justfile
  home.file.".config/just/justfile".source = ./justfile;
}
