# Nix package definition for whisper-diarization
# Speaker Diarization Using OpenAI Whisper
#
# CURRENT STATE: INCOMPLETE - wrapper only, no Python dependencies included
# The scripts are installed but will fail with "ModuleNotFoundError" when run.
#
# TODO: This needs Python dependencies packaged. Options:
# 1. Full Nix packaging: Add python3.withPackages with all deps (complex, ~1-2hr work)
# 2. Hybrid approach: Wrap with uv to handle Python deps automatically
# 3. Remove and document uv-based usage instead
#
# For now, use directly with uv:
#   git clone https://github.com/MahmoudAshraf97/whisper-diarization.git
#   uv run --directory ./whisper-diarization --with faster-whisper --with nltk diarize.py
{
  lib,
  stdenv,
  fetchFromGitHub,
  python3,
  ffmpeg,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "whisper-diarization";
  version = "unstable-2025-01-13";

  src = fetchFromGitHub {
    owner = "MahmoudAshraf97";
    repo = "whisper-diarization";
    rev = "fcbd1930d8a2fb2dc4e7cd0b7a0f2bffb786e8d3";
    hash = "sha256-OtDiiyJP1u3F8anoYCWHPHsH/UQZ+rbQRB68hzXqMbU=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ python3 ffmpeg ];

  patches = [ ];

  postPatch = ''
    patchShebangs diarize.py diarize_parallel.py
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    # Install the scripts
    mkdir -p $out/bin
    mkdir -p $out/share/whisper-diarization

    cp -r diarization $out/share/whisper-diarization/
    cp diarize.py $out/share/whisper-diarization/
    cp diarize_parallel.py $out/share/whisper-diarization/
    cp helpers.py $out/share/whisper-diarization/

    # Create wrapper script for diarize.py
    makeWrapper ${python3}/bin/python3 $out/bin/whisper-diarization \
      --add-flags "$out/share/whisper-diarization/diarize.py" \
      --prefix PATH : ${ffmpeg}/bin

    # Create wrapper script for diarize_parallel.py
    makeWrapper ${python3}/bin/python3 $out/bin/whisper-diarization-parallel \
      --add-flags "$out/share/whisper-diarization/diarize_parallel.py" \
      --prefix PATH : ${ffmpeg}/bin

    runHook postInstall
  '';

  meta = with lib; {
    description = "Automatic Speech Recognition with Speaker Diarization based on OpenAI Whisper";
    longDescription = ''
      Speaker Diarization pipeline based on OpenAI Whisper.
      Combines Whisper ASR with Voice Activity Detection (VAD) and
      Speaker Embedding to identify the speaker for each sentence.

      Requires manual Python dependency installation or use via a
      Python virtual environment with the requirements.txt file.
    '';
    homepage = "https://github.com/MahmoudAshraf97/whisper-diarization";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "whisper-diarization";
    platforms = platforms.linux ++ platforms.darwin;
  };
}
