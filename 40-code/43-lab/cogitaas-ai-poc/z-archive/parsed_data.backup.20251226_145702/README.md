# Parsed Data Directory

This directory is a **local mirror of `../onedrive-data/`** with parsed document artifacts.

## Mirror Structure Approach

The `parsed_data/` directory mirrors the structure of `onedrive-data/`, with one key difference:

**Files become directories** containing parsed artifacts, **with the file extension in the directory name**

### Example transformation

```
onedrive-data/                    parsed_data/
├── presentation.pptx          →  └── presentation.pptx/
│                                 ├── content.md
├── document.docx             →  └── document.docx/
│                                 ├── content.md
├── spreadsheet.xlsx          →  └── spreadsheet.xlsx/
│                                 ├── data.csv
├── report.pdf                →  └── report.pdf/
│                                 ├── content.md
└── some_folder/              →  └── some_folder/        # Regular directory (no extension)
    ├── nested_file.docx      →      └── nested_file.docx/
    └── another_folder/       →      └── another_folder/  # Regular directory
```

## Key Visual Indicator

**Parsed directories include the file extension** (e.g., `.pptx/`, `.docx/`, `.pdf/`)

This makes it easy to distinguish:
- `presentation.pptx/` - Parsed from a PowerPoint file
- `some_folder/` - Regular directory mirroring `onedrive-data/some_folder/`

## Parsed Document Directory Contents

Each parsed file directory contains:

```
filename.ext/
├── content.md       # Extracted text (or data.csv for spreadsheets)
├── images/          # Extracted images, charts, diagrams
└── readme.md        # Parsing metadata (source, hash, timestamp)
```

## How It Works

When you run a parsing script:

```bash
./scripts/parse_pptx.py "../onedrive-data/presentation.pptx"
```

The script automatically:
1. Takes the source path: `../onedrive-data/presentation.pptx`
2. Keeps the full filename: `presentation.pptx`
3. Creates `parsed_data/presentation.pptx/`
4. Writes `content.md`, `images/`, and `readme.md` inside

**No manual directory creation needed** - the scripts handle the mirroring automatically.

## Dynamic Structure

As `onedrive-data/` changes, the mirror updates automatically when you parse files:

- New files in `onedrive-data/` → new `*.ext/` directories in `parsed_data/`
- Subdirectories in `onedrive-data/` → regular directories in `parsed_data/`
- Any file type can be parsed using the appropriate script

## Usage

Parse documents from `onedrive-data/`:

```bash
# PowerPoint
./scripts/parse_pptx.py "../onedrive-data/presentation.pptx"

# Word (when script is created)
./scripts/parse_docx.py "../onedrive-data/document.docx"

# PDF (when script is created)
./scripts/parse_pdf.py "../onedrive-data/report.pdf"
```

## Parsing Status and Validation

For current parsing progress, quality assessment, and detailed feedback:
- `../validation/status.md` - Overall parsing status by file type and individual files
- `../validation/files/` - Per-file validation records with quality notes and issues
- `../validation/README.md` - How to provide feedback after parsing

See `../.claude/skills/doc-parsing/SKILL.md` for detailed parsing workflows and format-specific instructions.
