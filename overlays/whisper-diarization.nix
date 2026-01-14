# Overlay to add whisper-diarization package
final: prev: {
  whisper-diarization = prev.callPackage ../pkgs/whisper-diarization/package.nix {};
}
