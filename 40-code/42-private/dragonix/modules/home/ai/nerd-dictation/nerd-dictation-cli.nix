{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Nerd-dictation voice dictation module
  # Offline voice dictation using Vosk speech recognition
  #
  # ⚠️ MODULE DISABLED pending simplification
  # See README.md for details and work remaining
  #
  # When simplified, this module will provide:
  # - nerd-dictation package for voice-to-text
  # - Configuration files for intelligent command processing
  # - Clear manual setup instructions (or optional setup service)
  #
  # Activation: Super+D keybinding (configured in GNOME module)

  # Install nerd-dictation package
  home.packages = with pkgs; [ nerd-dictation ];

  # Configuration files for voice commands
  home.file.".config/nerd-dictation/README.md".source = ./config/README.md;
  home.file.".config/nerd-dictation/commands.md".source = ./config/commands.md;

  # Voice command processor script (optional but recommended)
  home.file.".config/nerd-dictation/nerd-dictation.py".source = ./config/nerd-dictation.py;
  home.file.".config/nerd-dictation/nerd-dictation.py".executable = true;

  # NOTE: home.activation.setupNerdDictationEnv removed during simplification
  # It was causing heavy downloads during activation, blocking the switch.
  # See README.md for recommended simplification approaches.
}
