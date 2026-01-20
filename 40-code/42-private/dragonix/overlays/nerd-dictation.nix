# Overlay for nerd-dictation packages
# Exposes nerd-dictation and Vosk model to the NixOS environment
#
# NOTE: Module is currently disabled. See simplification notes in:
#   modules/home/ai/nerd-dictation/README.md

final: prev: {
  nerd-dictation = prev.callPackage ../pkgs/nerd-dictation/package.nix {};
  # vosk-model-small-en-us is currently unused (see vosk-model.nix for details)
  # vosk-model-small-en-us = prev.callPackage ../pkgs/nerd-dictation/vosk-model.nix {};
}
