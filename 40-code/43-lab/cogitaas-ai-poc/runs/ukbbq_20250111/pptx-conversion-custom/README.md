# Presentation Conversion Project

This directory contains the converted PowerPoint presentation with organized subdirectories.

## Directory structure

```
.
├── README.md                        # This file
├── scripts/
│   └── create_final_markdown.py    # Python script for markdown generation
├── source/
│   └── 10.Presentation.pptx        # Original PowerPoint file
└── output/
    ├── 10.Presentation.md          # Main output: markdown with inline images
    ├── alt-texts.md                # Standalone alt-text descriptions for all slides
    ├── presentation-text.md        # Raw text extraction (intermediate)
    ├── pdf/
    │   └── 10.Presentation.pdf     # Generated PDF (intermediate)
    └── slide-images/
        └── slide-01.jpg ... slide-15.jpg  # Exported slide images (150 DPI)
```

## Key files

- **output/10.Presentation.md** - Main deliverable. View this file to see the presentation with inline images and extracted text
- **output/alt-texts.md** - Standalone file containing all image descriptions for accessibility and detailed visual context
- **source/10.Presentation.pptx** - Original PowerPoint file (only source material)
- **output/slide-images/** - All 15 slides exported as high-resolution JPEG images
- **output/pdf/** - Intermediate PDF generated during conversion

## Usage

Open `output/10.Presentation.md` in any markdown viewer. The images will display inline using relative paths to the `slide-images/` directory.

For detailed visual descriptions of each slide (useful for accessibility or understanding complex charts), refer to `output/alt-texts.md`.

## Conversion process

The conversion from PPTX to markdown with inline images involved multiple steps using different tools.

### Step 1: PPTX to PDF conversion (manual)

Used LibreOffice to convert the PowerPoint presentation to PDF format.

```bash
soffice --headless --convert-to pdf "source/10.Presentation.pptx"
```

This generated `output/pdf/10.Presentation.pdf`.

### Step 2: PDF to JPEG images (manual)

Used poppler-utils (via nix) to convert each PDF page into a high-quality JPEG image at 150 DPI.

```bash
nix shell nixpkgs#poppler-utils --command pdftoppm -jpeg -r 150 "output/pdf/10.Presentation.pdf" slide
```

This generated 15 image files: `slide-01.jpg` through `slide-15.jpg` in the current directory.

### Step 3: Text extraction (manual)

Used markitdown (Python package with C extensions requiring system libraries) to extract text content from the PPTX file.

```bash
nix shell nixpkgs#stdenv.cc.cc.lib --command bash -c "
  export LD_LIBRARY_PATH=$(nix eval --raw nixpkgs#stdenv.cc.cc.lib)/lib:\$LD_LIBRARY_PATH &&
  python -m markitdown 'source/10.Presentation.pptx' > presentation-text.md
"
```

The `nix shell` command provides the C++ standard library (libstdc++.so.6) required by markitdown's C extensions. This generated `presentation-text.md` with structured slide content.

### Step 4: Markdown generation (script)

The Python script `scripts/create_final_markdown.py` automated the final assembly:

- Read the extracted text from `presentation-text.md`
- Parsed slide boundaries using regex to split by slide numbers
- Generated a well-structured markdown file with:
  - Title and metadata headers
  - Individual sections for each of the 15 slides
  - Inline image references using relative paths
  - All extracted text content below each image
  - Link to alt-texts.md for detailed descriptions

```bash
./scripts/create_final_markdown.py
```

This created the final `output/10.Presentation.md` file.

### Step 5: File organization (manual)

Manually organized files into the final directory structure:

```bash
# Create output subdirectories
mkdir -p output/pdf output/slide-images

# Move generated files to appropriate locations
mv 10.Presentation.pdf output/pdf/
mv slide-*.jpg output/slide-images/
mv 10.Presentation.md presentation-text.md output/
```

### Step 6: Alt-text generation (AI-assisted)

Used Claude Sonnet 4.5's multimodal image understanding capabilities to generate detailed alt-text descriptions for all slide images.

Process:
1. Read all 15 slide images using Claude's Read tool with image understanding
2. Analyzed each slide's visual content, including:
   - Chart types (stacked bars, line graphs, dual-panel layouts)
   - Color schemes (red/orange/blue for Price/CSF/MCV)
   - Data structures (tables, performance metrics)
   - Visual elements (logos, callouts, dashed lines for price points)
   - Business context (channel comparisons, variant analysis)
3. Generated comprehensive alt-text descriptions capturing:
   - Chart structure and organization
   - Data visualization methods
   - Specific business insights visible in the visualizations
   - Layout and design elements

Output files:
- `output/alt-texts.md` - Standalone file with all 15 slide descriptions

The alt-text enables:
- Screen reader accessibility
- Better understanding of complex business visualizations
- Preservation of analytical context from visual elements

## Summary

- **Manual steps**: PPTX → PDF, PDF → images, text extraction, file organization
- **Automated step**: Final markdown generation combining text and images
- **AI-assisted step**: Alt-text generation using Claude's multimodal image understanding

The manual steps required system tools (LibreOffice, poppler-utils) and handling system library dependencies for markitdown. The script handled the straightforward text processing and markdown assembly. The AI-assisted step used Claude Sonnet 4.5 to generate detailed, contextual image descriptions that preserve the visual and analytical content of the presentation.
