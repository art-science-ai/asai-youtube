#!/usr/bin/env bash
# Transcribe audio using Faster-Whisper (high accuracy, no diarization)
#
# Usage: transcribe-faster-whisper.sh INPUT_FILE OUTPUT_DIR
#
# Example:
#   transcribe-faster-whisper.sh audio.m4a ./output

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

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "Transcribing: $INPUT_FILE"
echo "Output: $OUTPUT_DIR/transcript.txt"
echo ""

# Transcribe using faster-whisper with CPU optimization
uv run --with faster-whisper python -c "
from faster_whisper import WhisperModel

# Initialize model with CPU optimization
model = WhisperModel('small', device='cpu', compute_type='int8')

# Transcribe audio file
segments, _ = model.transcribe('$INPUT_FILE')

# Output transcript with one sentence per line
for segment in segments:
    print(segment.text.strip())
" > "$OUTPUT_DIR/transcript.txt"

echo ""
echo "Done! Generated file:"
echo "  - $OUTPUT_DIR/transcript.txt (plain text transcript)"
