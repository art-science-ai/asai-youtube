# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Proof of Concept (POC) project for developing AI workflows for Cogitaas' manual workflow processes, initially focused on presentation generation automation. The project processes and parses various proprietary file formats (docx, pptx, xlsx, pbix, etc.) to extract text and data for AI analysis.

## Architecture

### Directory Structure
- `scripts/` - Python scripts for file parsing using uv script format
- `parsed_data/` - Local copy of parsed contents from shared folder (working directory)
- `Agentic AI - Documents/` - Symlink to shared folder at `/Users/nikhilmaddirala/CogitaasAVA/Agentic AI - Documents/` (READ-ONLY)
- `Data_Sharing/` - Reference examples:
  - `full_examples/` - Complete project examples for reference
  - `masked_examples/` - Anonymized examples for AI workflow testing
  - `UK_BBQ/` - Example CSF workflow with all 8 stages

### CSF Workflow Stages
The Consumer Surplus Factor (CSF) workflow follows these stages:
1. Data Collection - IRI, Nielsen, IMRB, in-house data, promo calendars
2. Data Preparation - Scope identification and modeling-ready data preparation
3. EDA and Data Validation - Power BI or webapp dashboards
4. Modelling - Feature creation, model building
5. Model Selection - Statistical filtering and business context selection
6. Results and Outputs - MCV, CSF, MSPs calculation, RPI curves
7. Presentation - PowerPoint generation
8. Scenario Planner - Strategic planning

## Development Commands

### Running Scripts
All Python scripts use uv shebang format. Run scripts directly:
```bash
./scripts/parse_pptx.py "path/to/file.pptx"
```

### Environment Setup
- Install `uv` for Python package management
- Python 3.11+ required
- No virtual environment setup needed (uv handles it)

### Dependencies
Key Python packages are declared in scripts:
- `python-pptx` - PowerPoint text extraction
- `pandas` - CSV and data processing
- Built-in modules: `json`, `zipfile`, `pathlib`

CLI tools (install via Nix or native package managers):
- csvkit - CSV processing
- pandoc - Document conversion
- pdftotext - PDF text extraction
- pbixray - Power BI file analysis

## Important Constraints

### Data Access Rules
1. NEVER edit files in the shared folder (`Agentic AI - Documents/`)
2. Only work with copies in `parsed_data/`
3. Use `masked_examples/` for AI workflow development
4. Protect sensitive client data at all times

### File Processing Workflow
1. Source files are read-only in shared folder
2. Parse files and store results in `parsed_data/`
3. Create corresponding `readme.md` documenting process
4. Store results as JSON (structured) or text (documents)

### Script Development
- Use uv script format with shebang: `#!/usr/bin/env -S uv run --script`
- Declare dependencies in script metadata
- Document parsing methodology in README files
- Follow standardized naming (spaces → underscores)