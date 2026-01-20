# Nix package definition for nerd-dictation
# Offline Voice Dictation for Linux using Vosk Speech Recognition
#
# HYBRID APPROACH: Nix manages infrastructure, UV manages Python dependencies
# - Why: vosk and pyaudio are NOT in nixpkgs
# - Benefit: Fast iteration when modifying voice commands (no Nix rebuilds)
#
# For comprehensive documentation, see:
#   modules/home/ai/nerd-dictation/README.md

{
  lib,
  stdenv,
  fetchFromGitHub,
  python3,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "nerd-dictation";
  version = "unstable-2025-01-20";

  # Fetch from GitHub (latest commit as of 2025-01-20)
  src = fetchFromGitHub {
    owner = "ideasman42";
    repo = "nerd-dictation";
    rev = "41f372789c640e01bb6650339a78312661530843";
    hash = "sha256-xjaHrlJvk8bNvWp1VE4EAHi2VJlAutBxUgWB++3Qo+s=";
  };

  # Build dependencies
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ python3 ];

  # Fix script shebangs to use Nix's Python
  postPatch = ''
    patchShebangs nerd-dictation
  '';

  # No compilation needed (it's a Python script)
  dontBuild = true;

  # Install phase: Set up directory structure and wrapper
  installPhase = ''
    runHook preInstall

    # Create directory structure
    mkdir -p $out/bin
    mkdir -p $out/share/nerd-dictation
    mkdir -p $out/share/doc/nerd-dictation

    # Install the main script
    cp nerd-dictation $out/share/nerd-dictation/
    cp -r scripts $out/share/nerd-dictation/ 2>/dev/null || true

    # Install documentation
    cp README.md $out/share/doc/nerd-dictation/ 2>/dev/null || true

    # Create wrapper script with intelligent Python interpreter selection
    # Priority: UV environment > System Python
    cat > $out/bin/nerd-dictation <<'EOF'
    #!/bin/sh
    UV_ENV="$HOME/.local/share/nerd-dictation"

    # Use UV environment if available (has vosk/pyaudio)
    if [ -f "$UV_ENV/.venv/bin/python" ]; then
        exec "$UV_ENV/.venv/bin/python" $out/share/nerd-dictation/nerd-dictation "$@"
    else
        # Fallback to system python (requires vosk/pyaudio globally)
        exec ${python3}/bin/python3 $out/share/nerd-dictation/nerd-dictation "$@"
    fi
    EOF

    chmod +x $out/bin/nerd-dictation

    runHook postInstall
  '';

  # Package metadata
  meta = with lib; {
    description = "Offline voice dictation for Linux using Vosk speech recognition";
    longDescription = ''
      Nerd-dictation provides offline voice dictation using Vosk speech recognition.
      Supports push-to-talk activation and intelligent command processing.

      HYBRID PACKAGE: Infrastructure provided by Nix, Python dependencies (vosk, pyaudio)
      must be installed via UV for fastest iteration.

      For setup instructions and documentation, see:
        ~/.config/nix-config/modules/home/ai/nerd-dictation/README.md
    '';
    homepage = "https://github.com/ideasman42/nerd-dictation";
    license = licenses.gpl3Plus;
    maintainers = [ ];
    mainProgram = "nerd-dictation";
    platforms = platforms.linux;
  };
}
