---
name: doc-parsing
description: Parse proprietary Office and BI file formats (pptx, docx, xlsx, pdf, pbix) into repository-friendly artifacts using multi-method extraction. Use when users need to extract content from binary documents, create versionable text artifacts, or batch process document directories.
---

# Document Parsing Skill

## Overview

This skill enables extraction of content from proprietary Office and BI file formats into structured, version-controllable artifacts. The skill provides self-contained Python parsing scripts that can be copied to any project directory and adapted for project-specific document processing workflows.

Use this skill when you need to:
- Convert binary Office documents to text-based formats (Markdown, CSV, JSON)
- Extract content for version control and code review
- Batch process directories of documents with incremental updates
- Parse Power BI files for metadata and relationship extraction
- Create searchable, analyzable content from document archives
- Supported file types include `.pptx`, `.docx`, `.xlsx`, etc.

## Scripts

The skill provides ready-to-use parsing scripts in the `scripts/` directory:

- **parse_pptx.py** - PowerPoint parser with 4 extraction methods
- **parse_docx.py** - Word document parser with 4 extraction methods
- **parse_xlsx.py** - Excel spreadsheet parser with 4 extraction methods
- **parse_pdf.py** - PDF parser with 4 extraction methods
- **parse_pbix.py** - Power BI parser with 2 extraction methods
- **orchestrate_parsing.py** - Main orchestration script for batch processing

All scripts are self-contained with inline uv metadata and comprehensive documentation. Each parser script implements multiple extraction methods to provide comprehensive coverage and redundancy.

## Process

### Step 1: Understand user request

When invoked via command, parse the natural language request to extract parameters:

**Required:**
- **Source directory**: Look for paths after "from", "in", or standalone directory paths (e.g., "./docs", "~/files", "../data")

**Optional:**
- **Output directory**: Look for paths after "to", "output to", "save to". If not specified, default to `./parsed_data` 
- **File types**: Look for format keywords (pptx, docx, xlsx, pdf, pbix, "all documents"). Default to ["all"] if not specified
- **Force reparse**: Check for "force", "regenerate", "reparse all" keywords. Default to False

**Example parsing:**
- "Parse files from ./documents to ./parsed" → source=./documents, output=./parsed
- "Parse PowerPoint files from ~/decks" → source=~/decks, output=(ask), types=[pptx]
- "Reparse everything from ./docs to ./output, force" → source=./docs, output=./output, force=True

### Step 2: Understand project structure

Explore the project to understand context:
- Explore source directory tree and file types 
- Identify project-specific patterns (where docs live, naming conventions)

### Step 3: Copy scripts to project

Copy parsing scripts to the project: 
- Check if `scripts/` directory exists (create if needed)
- Copy all scripts from skill's scripts/ to project's scripts/ and make scripts executable

**Scripts copied:**
- `orchestrate_parsing.py` - Main batch processor
- `parse_pptx.py`, `parse_docx.py`, `parse_xlsx.py`, `parse_pdf.py`, `parse_pbix.py` - Individual parsers

### Step 4: Adapt orchestrator for project

Edit `./scripts/orchestrate_parsing.py` to set project-specific defaults based on Step 1 and Step 2:

```python
DEFAULT_SOURCE_DIR = Path("./documents")    # Where source documents live
DEFAULT_OUTPUT_DIR = Path("./parsed")       # Where parsed output goes
DEFAULT_FILE_TYPES = ["all"]                # Or ["pptx", "docx", "xlsx"]
DEFAULT_FORCE_REPARSE = False               # True to always re-parse
```

**Adaptation considerations:**
- Use actual source directory from user request or project exploration
- Use actual output directory from user request or recommended location
- Filter file types if user specified specific formats
- Set force reparse if user requested it

### Step 5: Execute parsing

Run the orchestrator with configured settings:

```bash
cd ./scripts/
./orchestrate_parsing.py
```

**Execution behavior:**
- Scans source directory recursively for supported files
- Skips unchanged files using SHA256 hash comparison
- Applies all extraction methods for each file type
- Creates mirrored directory structure in output location
- Continues on errors (individual file failures don't stop batch)

**Runtime overrides (if needed):**
```bash
# Override directories without editing defaults
./orchestrate_parsing.py /custom/source /custom/output

# Force reparse all files
./orchestrate_parsing.py --force

# Process specific file types only
./orchestrate_parsing.py --types=pptx,docx
```

### Step 6: Verify results

Check parsing output and report to user:

**Directory structure:**
```
output_dir/
├── [mirrored-source-path]/
│   └── filename.ext/
│       ├── parsing_summary.json
│       ├── method_1_name/
│       └── method_2_name/
└── parsing_summary.json
```

**Verification checklist:**
- Review root-level `parsing_summary.json` for overall statistics
- Check for failed files in individual file-level `parsing_summary.json` files
- Verify expected files were processed (count matches source)
- Confirm output structure mirrors source directory layout
- Report any errors or warnings to user with troubleshooting guidance

**Success indicators:**
- All expected files appear in output directory
- File-level `parsing_summary.json` shows successful method executions
- Content files (`.md`, `.csv`, `.json`) contain extracted data
- No critical errors in orchestration summary

### Alternative workflows

Parse single file for testing:
```bash
./scripts/parse_pptx.py /path/to/file.pptx /path/to/output
```

Override directories at runtime:
```bash
./orchestrate_parsing.py /custom/source /custom/output
```

Force reparse all (use after method updates):
```bash
./orchestrate_parsing.py --force
```

Process specific file types only:
```bash
./orchestrate_parsing.py --types=pptx,docx
```

## Guidelines

### Script adaptation principles

When adapting scripts for a project:

- **Directory structure**: Set source and output directories based on project layout
- **File type filtering**: Adjust `DEFAULT_FILE_TYPES` to process only needed formats
- **Incremental parsing**: Use hash-based skip by default, enable force reparse when methods change
- **Error handling**: Scripts continue on errors - review `parsing_results.json` for failures

### Output structure

The orchestrator creates mirrored directory structure:

```
output_dir/
├── [source-relative-path]/
│   └── filename.ext/
│       ├── parsing_summary.json      # File-level summary (methods, hash, orchestration metadata)
│       ├── method_1_name/            # First method output
│       │   ├── content.md or *.csv
│       │   └── images/ (if applicable)
│       └── method_2_name/            # Second method output
│           └── ...
└── parsing_summary.json              # Root-level summary (all files, statistics)
```

### Multi-method strategy

Each file type uses multiple extraction methods:

- **Comprehensive** - Full content + images + metadata (complex tools)
- **Fast** - Text-only extraction (simple tools)
- **Detailed** - Structure, formatting, and analysis
- **Specialized** - Format-specific features (formulas, DAX, layout)

All methods execute independently - failure in one does not stop others.

### Hash-based incremental parsing

The orchestrator uses SHA256 hashing to skip unchanged files:

- Files with matching hash in `parsing_summary.json` are skipped
- Changed files are automatically re-parsed
- Use `--force` flag to re-parse all files regardless of hash

### Environment requirements

Scripts use uv for dependency management with inline metadata:

```python
#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "python-pptx>=1.0.0",
#   "pandas>=2.0.0",
# ]
# ///
```

Requirements:
- Python 3.11 or higher
- `uv` package manager (handles dependencies automatically)
- On NixOS: See "NixOS-specific requirements" section below for system library setup

## Parser Methods

Each parser script implements multiple extraction methods for comprehensive coverage:

- **Comprehensive** - Full content + images + metadata
- **Fast** - Quick text-only extraction
- **Detailed** - Structure and formatting info
- **Specialized** - Format-specific features (formulas, DAX, layout)

**For detailed method documentation**: Read the docstrings in each parser script:

- `parse_pptx.py` - 4 PowerPoint extraction methods
- `parse_docx.py` - 4 Word extraction methods
- `parse_xlsx.py` - 4 Excel extraction methods
- `parse_pdf.py` - 4 PDF extraction methods
- `parse_pbix.py` - 2 Power BI extraction methods

Each method function includes comprehensive docstrings explaining purpose, advantages, disadvantages, and use cases.

## NixOS-specific requirements

Many Python packages (pandas, numpy, pypdfium2, pbixray) contain C extensions that require system libraries not available in the standard NixOS environment. You will encounter errors like:

- `libstdc++.so.6: cannot open shared object file`
- `libz.so.1: cannot open shared object file`

### Solution: Run with nix shell

Wrap script execution with nix shell to provide required system libraries:

```bash
nix shell nixpkgs#stdenv.cc.cc.lib nixpkgs#zlib --command bash -c "
  export LD_LIBRARY_PATH=\$(nix eval --raw nixpkgs#stdenv.cc.cc.lib)/lib:\$(nix eval --raw nixpkgs#zlib)/lib:\$LD_LIBRARY_PATH &&
  rm -rf ~/.cache/uv/environments-v2/parse-* || true &&
  ./scripts/orchestrate_parsing.py
"
```

### What this does

1. `nix shell nixpkgs#stdenv.cc.cc.lib nixpkgs#zlib` - Provides C++ standard library and zlib
2. `export LD_LIBRARY_PATH=...` - Makes libraries findable at runtime
3. `rm -rf ~/.cache/uv/environments-v2/parse-*` - Clears uv cache to force rebuild with correct library paths (only needed first time)
4. Runs your script in the library-enabled environment

### Required libraries

- `nixpkgs#stdenv.cc.cc.lib` - C++ standard library (libstdc++.so.6)
- `nixpkgs#zlib` - Compression library (libz.so.1)

### When to use

- Always on NixOS when parsing XLSX files (pandas/numpy dependency)
- Always on NixOS when parsing PBIX files (apsw/sqlite dependency)
- Always on NixOS when parsing PDF files (pypdfium2 dependency)
- PPTX and DOCX files work without nix shell on most setups

### Cache clearing

The cache clearing step (`rm -rf ~/.cache/uv/environments-v2/parse-*`) is only needed:
- The first time you run with nix shell
- When switching between nix shell and non-nix environments
- When you get library errors despite using nix shell

Once packages are built correctly, you can omit the cache clearing step for faster execution.

## Troubleshooting

### Script won't execute

```bash
# Fix permissions
chmod +x scripts/*.py

# Verify Python version
python --version  # Must be >=3.11
```

### C library errors

If you encounter errors like `libstdc++.so.6: cannot open shared object file` or `libz.so.1: cannot open shared object file`, see the "NixOS-specific requirements" section above for the complete solution.

### Missing images in output

Not all methods extract images. Check method descriptions in parser script docstrings. For images, use:
- **PPTX**: python-pptx-images or python-pptx-detailed
- **DOCX**: python-docx-detailed or python-docx-basic
- **PDF**: pdfplumber (limited image support)

### Empty CSV files for Excel

Verify sheet names exist. Check `metadata.json` in method output directory for sheet information and data statistics.

### Power BI parsing fails on Linux

Windows-specific Power BI tools are unavailable on Linux. Use:
- **pbixray** method for metadata and measures
- **zipfile** method for raw contents

### Hash comparison not working

Check `parsing_summary.json` format in the file's output directory. The file should contain a `file_hash` field. If corrupted, delete the file and re-run to generate fresh metadata.

## Format-Specific Notes

- **XLSX**: Multiple sheets output as separate CSV files, formulas in separate JSON
- **PBIX**: Limited on Linux, pbixray provides best metadata extraction
- **Images**: Check method documentation - not all methods extract images
- **Formulas**: Excel formulas preserved in openpyxl-formulas method only
- **Layout**: PDF layout preservation best with pdfminer-layout method
