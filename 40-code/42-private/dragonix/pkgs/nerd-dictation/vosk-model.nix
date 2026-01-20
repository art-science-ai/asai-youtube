# Vosk Small English Model (fixed-output derivation)
#
# NOTE: This package is currently UNUSED. See simplification notes in:
#   modules/home/ai/nerd-dictation/README.md
#
# This package was created for Option C (hybrid approach) but the module
# currently uses direct download in activation script instead.
#
# When simplifying the module, you can choose to:
# - Delete this file (if using Option A or B)
# - Use this file (if using Option C - hybrid with Nix-managed model)
#
# This ensures the model is reproducible and cached in Nix store
{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:

stdenv.mkDerivation rec {
  pname = "vosk-model-small-en-us";
  version = "0.15";

  # Fixed-output derivation for reproducibility
  src = fetchurl {
    url = "https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip";
    hash = "sha256-30f26242c4eb449f948e42cb302dd7a686cb29a3423a8367f99ff41780942498";
  };

  nativeBuildInputs = [ unzip ];

  installPhase = ''
    runHook preInstall

    # Create model directory
    mkdir -p $out

    # Extract model files
    unzip -q $src -d $out

    # Move files up one level if they're in a subdirectory
    if [ -d $out/vosk-model-small-en-us-0.15 ]; then
      mv $out/vosk-model-small-en-us-0.15/* $out/
      rmdir $out/vosk-model-small-en-us-0.15
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "Vosk Small English Model for speech recognition";
    longDescription = ''
      Small English model for Vosk speech recognition toolkit.
      Optimized for CPU-only systems with low memory footprint.
      Size: ~50MB, Accuracy: Good, Speed: Fastest.
    '';
    homepage = "https://alphacephei.com/vosk/models";
    license = licenses.asl20;
    platforms = platforms.linux ++ platforms.darwin ++ platforms.windows;
  };
}
