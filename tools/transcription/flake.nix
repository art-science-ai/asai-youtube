{
  description = "Hybrid Nix + uv environment for transcription tools (WhisperX, Faster-Whisper, Whisper.cpp)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      libPath = pkgs.lib.makeLibraryPath [
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib
        pkgs.libsndfile
      ];
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # System tools
          ffmpeg
          git
          cmake  # For building C/C++ projects if needed
          
          # Python management
          uv

          # C/C++ Tools
          whisper-cpp
        ];

        # Required for python libraries (like soundfile, pyannote) to find system C libraries
        LD_LIBRARY_PATH = libPath;

        shellHook = ''
          echo "🎙️  Transcription Environment Ready"
          echo "Tooling included:"
          echo "  - uv (for Python tools: whisperx, faster-whisper, nemo)"
          echo "  - whisper-cpp (standalone binary)"
          echo "  - ffmpeg & libsndfile (system audio libs)"
          echo ""
          echo "See README.md for specific usage instructions."
        '';
      };
    };
}
