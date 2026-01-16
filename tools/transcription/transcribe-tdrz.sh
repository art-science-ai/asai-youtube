#!/usr/bin/env bash
# Transcribe audio with speaker diarization using Whisper.cpp + tinydiarize
#
# Usage: transcribe-tdrz.sh INPUT_FILE OUTPUT_DIR
#
# Example:
#   transcribe-tdrz.sh audio.m4a ./output

set -euo pipefail

if [ $# -ne 2 ]; then
    echo "Usage: $0 INPUT_FILE OUTPUT_DIR"
    echo ""
    echo "Example:"
    echo "  $0 audio.m4a ./transcript-output"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_DIR="$2"
MODEL_PATH="$HOME/.local/share/whisper/models/ggml-small.en-tdrz.bin"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found"
    exit 1
fi

# Check if model exists
if [ ! -f "$MODEL_PATH" ]; then
    echo "Error: Model not found at $MODEL_PATH"
    echo ""
    echo "Download it with:"
    echo "  mkdir -p ~/.local/share/whisper/models"
    echo "  curl -L https://huggingface.co/akashmjn/tinydiarize-whisper.cpp/resolve/main/ggml-small.en-tdrz.bin -o $MODEL_PATH"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "Transcribing: $INPUT_FILE"
echo "Output: $OUTPUT_DIR/"
echo ""

# Transcribe with speaker diarization
ffmpeg -i "$INPUT_FILE" -ar 16000 -ac 1 -c:a pcm_s16le -f wav - \
  | whisper-cli -m "$MODEL_PATH" \
    -f - -tdrz -oj -osrt -otxt -of "$OUTPUT_DIR/transcript"

echo ""
echo "Done! Generated files:"
echo "  - $OUTPUT_DIR/transcript.json (structured data with speaker labels)"
echo "  - $OUTPUT_DIR/transcript.srt (subtitles with timestamps)"
echo "  - $OUTPUT_DIR/transcript.txt (plain text)"
