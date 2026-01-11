# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Proof of Concept (POC) project for developing AI workflows for Cogitaas' manual workflow processes, initially focused on presentation generation automation. The project processes and parses various proprietary file formats (docx, pptx, xlsx, pbix, etc.) to extract text and data for AI analysis.

## Architecture

This is a 2-tier monorepo:
- **Tier 1 (.claude/)**: Generic, reusable plugins and skills
- **Tier 2 (csf/)**: Application-specific CSF workflows and data

### Directory Structure

```
.claude/                      # All Claude tools (tier 1)
├── plugins/                  # Reusable plugins
│   ├── doc-parsing/          # Generic document parsing plugin
│   └── csf-automation/       # CSF workflow automation plugin
└── skills/                   # Standalone/experimental skills
    └── pptx-to-markdown/     # Reference implementation

csf/                          # CSF application (tier 2)
├── workflow/                 # CSF workflow documentation
├── data/                     # CSF project data
│   └── onedrive/             # → Symlink to OneDrive folder
├── iterations/               # Test runs with dual views
│   ├── by-project/           # Project-centric workflow versions
│   └── by-stage/             # Cross-project method comparison
└── scripts/                  # CSF orchestration scripts

scripts/                      # Shared utility scripts
onedrive-data/                # Direct symlink to OneDrive (READ-ONLY)
z-archive/                    # Archived iterations
```

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
1. NEVER edit files in the OneDrive shared folder (read-only symlink)
2. Only work with copies or process files to output directories
3. Use `masked_examples/` for AI workflow development
4. Protect sensitive client data at all times

### File Processing Workflow
1. Source files are in `csf/data/onedrive/` (read-only symlink to OneDrive)
2. When processing, write outputs to `csf/iterations/[project]-[task]/v[N]/`
3. Each iteration should document: method used, configuration, and results
4. Track successful methods to promote to `.claude/skills/` or `.claude/plugins/`

### Working with Iterations

The `csf/iterations/` directory has dual views for organizing test runs:

**by-project/** - Primary view for project work
```bash
csf/iterations/by-project/uk_bbq/
├── README.md                      # Project overview
├── current-best -> workflow-versions/v3-full-pipeline
└── workflow-versions/
    └── v3-full-pipeline/          # A complete workflow run
        ├── workflow-manifest.yaml # Pipeline definition
        ├── 01-parse-presentation/
        │   ├── config.yaml
        │   └── output/
        ├── 02-interpret-results/  # Uses output from stage 01
        ├── 03-plan-presentation/  # Uses output from stage 02
        └── 04-generate-presentation/ # Uses output from stage 03
```

**by-stage/** - Secondary view for method comparison
```bash
csf/iterations/by-stage/01-parse-presentation/
└── method-pdf-conversion/         # Compare this method across projects
    ├── manifest.yaml              # Lists all projects using this method
    ├── README.md                  # Method comparison results
    └── references/                # Paths to actual project directories
```

**When testing a method:**
1. Create workflow version in `by-project/[project]/workflow-versions/vN/`
2. Add stages with explicit input/output dependencies
3. Create `workflow-manifest.yaml` documenting the full pipeline
4. Update `by-stage/[stage]/method-NAME/manifest.yaml` with cross-reference

**Workflow dependencies:**
- Each stage declares its input source (from previous stage or raw data)
- Stages can be re-run independently if inputs change
- The manifest file makes dependencies explicit and traceable

**Plugin skill locations:**
When referencing skills in workflow manifests, use these paths:
- PPTX parsing: `.claude/plugins/doc-parsing/skills/pptx-to-markdown/`
- CSF interpretation (Stage 7a): `.claude/plugins/csf-automation/skills/interpret-csf-results/`
- CSF planning (Stage 7b): `.claude/plugins/csf-automation/skills/plan-csf-presentation/`
- CSF generation (Stage 7c): `.claude/plugins/csf-automation/skills/generate-csf-presentation/`

### Script Development
- Use uv script format with shebang: `#!/usr/bin/env -S uv run --script`
- Declare dependencies in script metadata
- Document parsing methodology in README files
- Follow standardized naming (spaces → underscores)