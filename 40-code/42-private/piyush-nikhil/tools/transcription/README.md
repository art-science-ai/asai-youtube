# Transcription Tools

This directory contains resources and documentation for various open-source transcription tools, with a specific focus on those supporting **speaker diarization** (distinguishing between different speakers).

**🎯 Current Recommendations (as of Jan 2026):**

**Quick Start:**
- **Use the wrapper scripts:**
  - `./transcribe-faster-whisper.sh INPUT.m4a OUTPUT_DIR`
    - Highest transcription accuracy, recommended for most use cases
    - No speaker diarization, but best word accuracy and readability
  - `./transcribe-tdrz.sh INPUT.m4a OUTPUT_DIR`
    - Speaker diarization support (experimental quality)
    - Handles all the ffmpeg piping and format conversions automatically
  - See [Quick Start](#quick-start) section below

**Open Source Tools:**
- [Whisper.cpp](#1-whispercpp) - CPU-optimized, runs everywhere, experimental diarization
- [Faster-Whisper](#2-faster-whisper) - Fast Python backend, transcription-only
- [NVIDIA Parakeet](#5-nvidia-parakeet) - CPU-optimized RNN-T model, streaming-capable

**Managed API Services:**
- [Deepgram](#managed-api-services) - Speed leader (<300ms latency), excellent diarization
- [AssemblyAI](#managed-api-services) - Best for NLP features (summarization, sentiment analysis)

**Known Issues:**
- [WhisperX](#3-whisperx) - ⚠️ Broken due to PyTorch 2.6 compatibility issues

## Environment Setup

This project uses **Nix** for system dependencies (ffmpeg, whisper-cpp) and **uv** for Python dependency management.

**Option 1: Cross-OS compatibility (Linux/macOS):**
```bash
devbox shell
```
Uses `devbox.json` which provides ffmpeg, whisper-cpp, and uv. System libraries (libstdc++, zlib) are used from your OS.

**Option 2: NixOS:**
```bash
nix develop
```
Uses `flake.nix` which properly configures library paths for Python tools with C extensions.

**Which Python tools work where:**
- **whisper-cpp + script:** ✅ Works everywhere (no Python dependencies)
- **faster-whisper:** ✅ Works with `nix develop` on NixOS, ✅ works with `devbox shell` on other OSes
- **whisperx:** ⚠️ Currently broken everywhere (PyTorch 2.6 issue)

---

## Transcription Quality Notes

Based on comparative testing of the same audio conversation:

- **Faster-Whisper:** Highest accuracy and readability. Best word accuracy, proper sentence structure, and excellent context preservation. Most suitable for documentation and professional use.

- **Whisper.cpp:** Good quality with moderate accuracy. Some transcription errors but maintains reasonable readability. Better paragraph structure than experimental diarization options.

- **Whisper.cpp (tinydiarize):** Fair to poor quality. Most transcription errors, critical meaning can be lost, and poor formatting with excessive line breaks. Useful only when speaker diarization is essential and accuracy can be sacrificed.

**Recommendation:** Use faster-whisper for transcription accuracy, or whisper.cpp with tinydiarize only when speaker identification is required and quality trade-offs are acceptable.

---

## Comparison Summary

### Open Source Tools

| Tool | Diarization Support | CPU/GPU | Status | Best For |
| :--- | :--- | :--- | :--- | :--- |
| **[Whisper.cpp](#1-whispercpp)** | **Experimental** (via tinydiarize) | **CPU-optimized** (runs everywhere) | ✅ **Working** | Diarization support, no dependencies, CPU-only environments, mobile/embedded devices, Apple Silicon. |
| **[Faster-Whisper](#2-faster-whisper)** | No (Backend only) | **Both** (CPU or GPU) | ✅ **Working** | Fastest Python-based backend, transcription-only, building custom pipelines. |
| **[NVIDIA Parakeet](#5-nvidia-parakeet)** | Via NeMo Diarizer | **Both** (CPU-optimized) | ✅ **Available** | CPU performance, streaming, real-time transcription, noisy environments. |
| **[WhisperX](#3-whisperx)** | **Yes** (Built-in via Pyannote) | **GPU-optimized** (works on CPU) | ⚠️ **Broken** (PyTorch 2.6) | High-accuracy diarization, aligned timestamps, production workloads (when fixed). |
| **[Whisper-Diarization](#4-whisper-diarization)** | **Yes** (Built-in via NeMo) | **GPU-required** (NeMo) | ❓ **Untested** | Robust diarization quality with NVIDIA GPU, NeMo toolkits. |

### Managed API Services

| Service | Diarization Support | Pricing (2025) | Latency | Best For |
| :--- | :--- | :--- | :--- | :--- |
| **[Deepgram](#managed-api-services)** | **Yes** (>90% accuracy) | $0.0043/min (batch)<br>$0.0077/min (streaming) | **<300ms** (fastest) | Real-time voice bots, high-volume batch, cost-sensitive scaling. |
| **[AssemblyAI](#managed-api-services)** | **Yes** (improved 2024) | $0.0025/min (base)<br>$0.0045/min (best accuracy) | Good | NLP features (summarization, sentiment), post-transcription analysis. |

---

## Quick Start

For most use cases, use the provided wrapper scripts:

```bash
# High-accuracy transcription (recommended)
./transcribe-faster-whisper.sh INPUT.m4a OUTPUT_DIR

# Transcription with speaker diarization (experimental quality)
./transcribe-tdrz.sh INPUT.m4a OUTPUT_DIR
```

**transcribe-faster-whisper.sh:**
- Highest transcription accuracy and readability
- Uses faster-whisper with CPU optimization (int8 quantization)
- Accepts M4A/MP4 files directly, no conversion needed
- Generates plain text transcript

**transcribe-tdrz.sh:**
- Includes speaker diarization (identifies different speakers)
- Automatically converts audio to the correct format
- Runs whisper-cli with tinydiarize for speaker detection
- Generates JSON, SRT, and TXT output files
- Validates input and provides helpful error messages

See individual tool sections below for manual usage and other options.

---

## Tools

All commands below use placeholder variables:
- `INPUT.m4a` - Your input audio file (M4A or MP4)
- `OUTPUT_DIR` - Your target output directory for transcripts

### 1. Whisper.cpp

**Lightweight / Standalone / Edge**

**Usage:**

The `whisper-cli` binary is provided by the Nix environment.

> **Note:** `whisper-cli` only accepts **16-bit WAV** files. You can either pipe audio directly from ffmpeg (recommended) or create a temp WAV file.

**One-time setup:**
```bash
# Create models directory
mkdir -p ~/.local/share/whisper/models

# Download base model for transcription only
curl -L https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin -o ~/.local/share/whisper/models/ggml-base.en.bin

# Download tinydiarize model for speaker diarization
curl -L https://huggingface.co/akashmjn/tinydiarize-whisper.cpp/resolve/main/ggml-small.en-tdrz.bin -o ~/.local/share/whisper/models/ggml-small.en-tdrz.bin
```

**Standard Transcription:**
```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Method 1: Pipe audio directly (no temp files)
ffmpeg -i INPUT.m4a -ar 16000 -ac 1 -c:a pcm_s16le -f wav - \
  | whisper-cli -m ~/.local/share/whisper/models/ggml-base.en.bin \
    -f - -otxt -of OUTPUT_DIR/transcript

# Method 2: Using temp file (if piping doesn't work)
ffmpeg -i INPUT.m4a -ar 16000 -ac 1 -c:a pcm_s16le temp.wav
whisper-cli -m ~/.local/share/whisper/models/ggml-base.en.bin -f temp.wav -otxt -of OUTPUT_DIR/transcript
rm temp.wav
```

**Diarization (Speaker Detection):**

**Recommended: Use the wrapper script**
```bash
./transcribe-tdrz.sh INPUT.m4a OUTPUT_DIR
```

**Manual approach (if you need customization):**
```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Pipe audio directly to whisper-cli
ffmpeg -i INPUT.m4a -ar 16000 -ac 1 -c:a pcm_s16le -f wav - \
  | whisper-cli -m ~/.local/share/whisper/models/ggml-small.en-tdrz.bin \
    -f - -tdrz -oj -osrt -otxt -of OUTPUT_DIR/transcript
```

This generates three files in `OUTPUT_DIR/`:
- `transcript.json` - Structured data with speaker labels preserved
- `transcript.srt` - Subtitle format with timestamps
- `transcript.txt` - Plain text transcript (speaker labels may be lost)

**Details:**

**Repository:** [https://github.com/ggerganov/whisper.cpp](https://github.com/ggerganov/whisper.cpp)

A port of the Whisper model to C/C++. It is legendary for its ability to run on almost any hardware, from high-end servers to an iPhone or Raspberry Pi.

- **Diarization:** **Experimental**. Supports "speaker segmentation" via the `tinydiarize` project (using the `-tdrz` flag and specialized models like `small.en-tdrz`).
- **Key Features:**
  - No dependencies (runs as a standalone binary).
  - Highly optimized for Apple Silicon (Core ML) and CPU inference.
  - Quantization support for very low memory footprint.
- **Pros:** Runs everywhere; extremely lightweight; experimental diarization is improving.
- **Cons:** Not Python-native; diarization is less mature than Pyannote/NeMo.

---

### 2. Faster-Whisper

**Pure High-Performance Backend (Transcription Only)**

**Usage:**

Faster-Whisper can process M4A/MP4 files directly without conversion.

**CPU mode (recommended for compatibility):**
```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Transcribe on CPU
uv run --with faster-whisper python -c "
from faster_whisper import WhisperModel
model = WhisperModel('small', device='cpu', compute_type='int8')
segments, _ = model.transcribe('INPUT.m4a')
print('\n'.join([s.text for s in segments]))
" > OUTPUT_DIR/transcript.txt
```

**GPU mode (requires matching CUDA driver/runtime versions):**
```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Transcribe on GPU (4x faster, but needs compatible CUDA setup)
uv run --with faster-whisper python -c "
from faster_whisper import WhisperModel
model = WhisperModel('small', device='cuda', compute_type='float16')
segments, _ = model.transcribe('INPUT.m4a')
print('\n'.join([s.text for s in segments]))
" > OUTPUT_DIR/transcript.txt
```

**Details:**

**Repository:** [https://github.com/SYSTRAN/faster-whisper](https://github.com/SYSTRAN/faster-whisper)

A reimplementation of OpenAI's Whisper model using CTranslate2. It does not support diarization out of the box but is the "engine" for many other tools that do.

- **Diarization:** **None**. Must be paired with an external library (like Pyannote or NeMo).
- **Key Features:**
  - Up to 4x faster than original OpenAI Whisper.
  - Significantly lower memory usage (via 8-bit quantization).
  - **CPU & GPU Support**: Excellent CPU performance with quantization; fastest on GPU with CTranslate2.
- **Pros:** The fastest Python-based Whisper inference; flexible backend for building custom tools; works reliably on CPU.
- **Cons:** Requires building your own logic for speaker labels; not a complete solution out-of-the-box.

---

### 3. WhisperX

**⚠️ CURRENTLY BROKEN - PyTorch 2.6 Compatibility Issue**

**Best All-rounder (Transcription + Diarization) - When It Works**

**Current Issue:** WhisperX is incompatible with PyTorch 2.6 due to the `weights_only=True` default change. The Pyannote models used for VAD (Voice Activity Detection) and diarization fail to load with:
```
UnpicklingError: GLOBAL omegaconf.listconfig.ListConfig was not an allowed global
```

This is an upstream issue in the Pyannote library that affects the entire ecosystem. Tracking:
- [WhisperX Issue #1304](https://github.com/m-bain/whisperX/issues/1304)
- [Pyannote Issue #1908](https://github.com/pyannote/pyannote-audio/issues/1908)

**Workaround:** Use [Whisper.cpp with tinydiarize](#1-whispercpp) (experimental but working) for diarization until this is resolved.

**Usage (when fixed):**

WhisperX can process M4A/MP4 files directly without conversion.

**One-time setup - HuggingFace Token:**
```bash
# 1. Create a Hugging Face account: https://huggingface.co/join
# 2. Accept user agreements for Pyannote models:
#    - https://huggingface.co/pyannote/speaker-diarization-3.1
#    - https://huggingface.co/pyannote/segmentation-3.0
# 3. Generate access token: https://huggingface.co/settings/tokens
# 4. Set as environment variable:
export HF_TOKEN=<YOUR_TOKEN>
```

**CPU mode (recommended for compatibility):**
```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Transcribe with speaker diarization on CPU
uv run --with whisperx whisperx INPUT.m4a \
  --diarize \
  --device cpu \
  --compute_type int8 \
  --output_dir OUTPUT_DIR \
  --hf_token $HF_TOKEN
```

**GPU mode (requires matching CUDA driver/runtime versions):**
```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Transcribe with speaker diarization on GPU (5-10x faster)
uv run --with whisperx whisperx INPUT.m4a \
  --diarize \
  --device cuda \
  --compute_type float16 \
  --output_dir OUTPUT_DIR \
  --hf_token $HF_TOKEN
```

**Compute types:**
- `int8` - Best for CPU (8-bit quantization, faster)
- `float16` - Best for GPU (half precision, fast)
- `float32` - Highest accuracy but slower

**Details:**

**Repository:** [https://github.com/m-bain/whisperX](https://github.com/m-bain/whisperX)

WhisperX is a popular wrapper around Whisper that adds essential post-processing features. It is currently one of the most complete open-source solutions for transcription with diarization.

- **Diarization:** Uses **Pyannote-audio** for speaker diarization.
- **Key Features:**
  - **Word-Level Timestamps:** Forces alignment of phonemes to audio to provide precise word timings.
  - **VAD (Voice Activity Detection):** Pre-processes audio to reduce hallucination and improve accuracy.
  - **Batch Processing:** Optimized for high-throughput GPU usage.
  - **CPU Support:** Works on CPU but significantly slower than GPU (5-10x speedup with GPU).
- **Pros:** All-in-one solution; excellent timestamp accuracy; production-ready.
- **Cons:** Heavy dependency tree (Pyannote, Torch); slow on CPU without GPU.

---

### 4. Whisper-Diarization

**❓ UNTESTED - GPU-Only, Advanced Research Setup**

**Advanced Research / High Quality Diarization with NVIDIA NeMo**

**⚠️ Note:** This tool requires NVIDIA GPU and has not been tested in this environment. Listed here for completeness.

**Usage:**

This requires a custom Python script. Example:

```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Run diarization script with NeMo
uv run --with "cython, nemo_toolkit[all], faster-whisper" python diarization_script.py \
  --input INPUT.m4a \
  --output OUTPUT_DIR/transcript.json
```

**Details:**

**Repository:** [https://github.com/MahmoudAshraf97/whisper-diarization](https://github.com/MahmoudAshraf97/whisper-diarization)

This category refers to pipelines that explicitly combine the speed of `faster-whisper` with the diarization capabilities of NVIDIA's NeMo toolkit.

- **Diarization:** Uses **NVIDIA NeMo** (MSDD - Multi-scale Diarization Decoder).
- **Key Features:**
  - Leverages the speed of CTranslate2 (via faster-whisper).
  - Uses NeMo's advanced clustering for speaker identification.
  - Potentially higher diarization quality than Pyannote (when it works).
- **Pros:** High-quality diarization from NeMo; fast inference on GPU.
- **Cons:** Setting up the NeMo environment can be complex; **requires NVIDIA GPU** (not CPU-compatible); **untested in this setup**; complex dependency tree.

---

### 5. NVIDIA Parakeet

**CPU-Optimized / Streaming / Production-Ready**

**Fast RNN-T Alternative to Whisper with CPU Performance**

**Usage:**

Parakeet is part of the NVIDIA NeMo toolkit and can process audio files directly.

**CPU mode (recommended for compatibility):**
```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Install NeMo with CPU PyTorch
uv run --with "torch", --with "nemo_toolkit[asr]" python -c "
import nemo.collections.asr as nemo_asr

# Load Parakeet v3 model (automatically uses CPU if no GPU)
model = nemo_asr.models.ASRModel.from_pretrained('nvidia/parakeet-tdt-1.1b-v3')

# Transcribe audio file
transcriptions = model.transcribe(paths2audio_files=['INPUT.m4a'])
print(transcriptions[0])
" > OUTPUT_DIR/transcript.txt
```

**GPU mode (faster inference):**
```bash
# Create output directory
mkdir -p OUTPUT_DIR

# Transcribe on GPU (requires CUDA)
uv run --with "torch", --with "nemo_toolkit[asr]" python -c "
import nemo.collections.asr as nemo_asr

# Load Parakeet v3 model on GPU
model = nemo_asr.models.ASRModel.from_pretrained(
    'nvidia/parakeet-tdt-1.1b-v3',
    map_location='cuda'
)

# Transcribe audio file
transcriptions = model.transcribe(paths2audio_files=['INPUT.m4a'])
print(transcriptions[0])
" > OUTPUT_DIR/transcript.txt
```

**Details:**

**Repository:** [https://github.com/NVIDIA/NeMo](https://github.com/NVIDIA/NeMo) (includes Parakeet models)

NVIDIA Parakeet is an RNN-Transducer (RNN-T) ASR model that outperforms OpenAI's Whisper in both speed and accuracy for many tasks. Unlike Whisper's Transformer architecture, Parakeet uses a Transducer architecture that enables streaming and real-time transcription.

- **Diarization:** **Via NeMo Diarizer**. Parakeet itself is an acoustic model but integrates seamlessly with NVIDIA's NeMo Diarizer (Sortformer or MSDD models) for speaker diarization.
- **Key Features:**
  - **CPU Performance:** ~10x faster than Whisper on CPU with better accuracy.
  - **Streaming Support:** Native support for real-time streaming audio (difficult with Whisper).
  - **Noise Resilience:** Superior performance in noisy environments compared to Whisper.
  - **Word-Level Timestamps:** Native and accurate word-level timestamps for precise speaker label alignment.
  - **Multilingual:** Supports 25+ languages with automatic language identification.
  - **Lower Hallucinations:** RNN-T architecture is less prone to repetition loops and invented text in silent segments.
- **Pros:** Excellent CPU performance; streaming capability; better accuracy than Whisper in noisy conditions; fewer hallucinations.
- **Cons:** Requires NeMo toolkit (heavier dependencies than faster-whisper); less mature ecosystem than Whisper; documentation focused on GPU usage.

**Comparison with Whisper:**

| Feature | **NVIDIA Parakeet (v3)** | **OpenAI Whisper** |
| :--- | :--- | :--- |
| **Speed (CPU)** | **~10x faster** | Baseline |
| **Accuracy (WER)** | Lower WER (better accuracy) | Very strong general-purpose |
| **Noise Resilience** | **Superior** (handles background noise/music) | Good, degrades in high noise |
| **Hallucinations** | **Low** (RNN-T architecture) | Moderate (known repetition loops) |
| **Streaming** | **Native support** | Batch-only (requires forks for streaming) |
| **Timestamps** | **Word-level (native)** | Segment-level (word-level via alignment tools) |
| **Languages** | 25+ | 100+ |

**Recent Updates (2024-2025):**
- **Parakeet TDT v3:** Token-and-Duration Transducer variant that predicts both token and duration, 30% faster than standard RNN-T without accuracy loss.
- **1.1B Model:** Current recommendation for high accuracy on CPU, replacing older 0.6B models.

---

## Managed API Services

For production workloads that require scalability, reliability, or advanced features, managed API services are recommended over self-hosted solutions.

### Deepgram

**Speed & Real-Time Transcription Leader**

**Overview:** Deepgram specializes in end-to-end deep learning models optimized for speed and low latency, making it the industry leader for real-time voice applications.

**Key Features:**
- **Nova-3 Model:** Flagship model with sub-300ms latency and >90% accuracy.
- **Flux Model:** New "Conversational Speech Recognition" (CSR) model for voice agents (late 2025).
- **Diarization:** Major architecture update in mid-2024 with >90% accuracy, supports unlimited speakers.
- **Streaming:** Excellent real-time streaming support, best-in-class latency.
- **Languages:** Strong multi-language support with expanding capabilities.

**Pricing (2025):**
- **Pay-As-You-Go:**
  - Pre-recorded: $0.0043/min (~$0.26/hour)
  - Streaming: $0.0077/min (~$0.46/hour)
- **Free Tier:** $200 credit for new users.
- **Volume Discounts:** Significant discounts for high-volume usage.

**Best For:**
- Real-time voice bots and conversational AI
- High-volume batch processing
- Cost-sensitive scaling applications
- Low-latency requirements (<300ms)

**Website:** [https://deepgram.com](https://deepgram.com)

---

### AssemblyAI

**Best for Audio Intelligence & NLP Features**

**Overview:** AssemblyAI focuses on post-transcription analysis and NLP features, making it ideal for applications that need to understand and analyze audio content, not just transcribe it.

**Key Features:**
- **Universal-2 Model:** State-of-the-art speech-to-text model.
- **Audio Intelligence:** Summarization, sentiment analysis, PII redaction, topic detection.
- **Diarization:** 13% accuracy improvement in late 2024, reduced speaker counting errors (~3%).
- **Streaming:** Added streaming support for 6 major languages in late 2025.
- **Content Safety:** Detect offensive content and safety issues.

**Pricing (2025):**
- **Standard:** $0.0025/min (~$0.15/hour) - highly competitive base rate.
- **Best Accuracy (SLAM-1):** $0.0045/min (~$0.27/hour).
- **Add-ons:** Diarization, summarization, etc. cost extra (~$0.02/hour each).

**Best For:**
- Applications requiring summarization and content analysis
- Sentiment analysis and topic detection
- PII redaction and content safety
- Post-transcription NLP processing

**Website:** [https://assemblyai.com](https://assemblyai.com)

---

### Other Notable APIs

**OpenAI Whisper API:**
- **Pricing:** $0.006/min (~$0.36/hour).
- **Best For:** Difficult audio, accents, technical jargon, robust noise handling.
- **Limitations:** No native streaming, primarily batch processing.

**Rev.ai:**
- **Pricing:** $0.0017/min (~$0.10/hour) for Reverb Turbo (English).
- **Best For:** Hybrid AI + human transcription (99% accuracy guarantee).
- **Use Cases:** Legal, medical, or media where strict accuracy is critical.

**Speechmatics:**
- **Pricing:** $0.30/hour (batch) to $1.04/hour (real-time).
- **Best For:** Global English dialects (Indian, Scottish, Australian), on-premises deployment.
- **Strength:** Handles diverse accents better than US-centric models.

---

## Choosing the Right Tool

### Use Decision Tree

**Need real-time transcription with low latency?**
- Yes → **Deepgram API** (<300ms latency, industry leader)
- No → Continue

**Need advanced NLP features (summarization, sentiment)?**
- Yes → **AssemblyAI API** (best audio intelligence)
- No → Continue

**Budget-constrained or high-volume batch processing?**
- Yes → **Deepgram API** (cost-effective at scale) or **Faster-Whisper** (self-hosted)
- No → Continue

**Must run on-premises or air-gapped environment?**
- Yes → **Faster-Whisper** (simple) or **NVIDIA Parakeet** (better CPU performance)
- No → Continue

**Challenging audio (noise, accents, technical terms)?**
- Yes → **OpenAI Whisper API** or **NVIDIA Parakeet** (superior noise handling)
- No → Continue

**Need speaker diarization with high accuracy?**
- Yes → **Deepgram API** (>90% accuracy) or **AssemblyAI** (improved 2024)
- No → **Faster-Whisper** (fastest self-hosted option)

**Summary Recommendation:**
- **Production/Managed:** Deepgram (speed/cost) or AssemblyAI (NLP features)
- **Self-hosted CPU:** Parakeet (performance) or Faster-Whisper (simplicity)
- **Self-hosted diarization:** Whisper.cpp with tinydiarize (experimental)
- **Edge/mobile:** Whisper.cpp (lightweight, no dependencies)

