# CSF Automation Plugin

Automates Consumer Surplus Factor (CSF) presentation generation and evaluation from quantitative analysis results.

## Overview

This plugin streamlines the CSF workflow by automating the transformation of Brand-Level Results into presentation-ready content, with built-in quality assurance and testing capabilities.

## What it does

The plugin provides a complete workflow for CSF presentation generation:
1. **generate-presentation**: Interprets quantitative results and generates presentation outlines
2. **pptx-to-markdown**: Converts PowerPoint presentations to markdown for analysis
3. **evaluate-presentation**: Validates presentation quality and extracts requirements
4. **test command**: Orchestrates the complete test workflow

## Directory structure

```
ai-plugins/csf-automation/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── README.md                    # This file
├── commands/
│   └── test.md              # Orchestrator command for test setup
└── skills/
    ├── generate-presentation/
    │   ├── SKILL.md             # Presentation generation skill
    │   ├── scripts/
    │   │   └── enhance_results.py  # Data enhancement script
    │   └── templates/
    │       └── presentation-outline.md
    ├── pptx-to-markdown/
    │   ├── SKILL.md             # PPTX conversion skill
    │   ├── scripts/
    │   │   └── convert_pptx_to_markdown.py
    │   ├── examples/            # Reference conversion examples
    │   └── references/
    │       └── troubleshooting.md
    └── evaluate-presentation/
        ├── SKILL.md             # Evaluation and validation skill
        └── templates/
            ├── requirements.md  # Requirements extraction template
            └── evaluation.md    # Evaluation report template
```

## Skills

### generate-presentation

Comprehensive skill for presentation generation from Brand-Level Results CSV.

**When to use**: When you have Brand-Level Results CSV from Stage 6 and need to create a presentation outline.

**Outputs**:
- Enhanced CSV with categorization columns (CSF, PE, MSP categories)
- Presentation outline (Markdown with slide-by-slide structure)

**Key features**:
- Applies CSF, Price Elasticity, and MSP categorization rules
- Identifies market leaders and competitive positions
- Generates data-driven narratives following client standards

### pptx-to-markdown

Converts PowerPoint presentations to markdown format with inline slide images.

**When to use**: When you need to make existing presentations accessible for AI analysis or archival.

**Outputs**:
- presentation.md - Markdown with inline slide images
- slide-images/ - Individual slide JPEGs
- alt-texts.md - AI-generated image descriptions

**Key features**:
- Preserves visual structure with inline images
- Generates accessibility descriptions
- Enables version control for presentations

### evaluate-presentation

Validates presentation quality and extracts requirements from ground truth presentations.

**When to use**: When testing presentation generation or validating output quality.

**Outputs**:
- evaluation.md - Quality assessment report
- requirements.md - Extracted requirements (if ground truth provided)

**Modes**:
- Self-evaluation: Validates completeness and consistency
- Ground truth comparison: Compares against reference presentation

**Key features**:
- Completeness checks (all channels, brands, sections)
- Data consistency validation
- Semantic gap analysis (with ground truth)

## Commands

### test

Orchestrator command for setting up new test cases.

**When to use**: When creating a new test case from CSV data and optionally a ground truth presentation.

**Workflow**:
1. Creates test directory structure (inputs/, outputs/)
2. Copies input files (CSV, optional PPTX)
3. Converts PPTX to markdown (if provided)
4. Generates presentation outline
5. Evaluates quality and extracts requirements

**Example**:
```bash
/test Set up test for US Spoonables presentation
```

## Testing workflow

The plugin uses a convention-based test structure:

```
tests/{project}_{date}/
├── inputs/
│   ├── 6.Brand_Level_Results.csv
│   └── presentation.pptx (optional)
└── outputs/
    ├── 6.Brand_Level_Results_Enhanced.csv
    ├── presentation-outline.md
    ├── requirements.md (if ground truth)
    └── evaluation.md
```

## Development status

Active development. See `tests/` directory for execution history and validation runs.

## Quick start

```bash
# Set up a new test case
/test Test UK Brown Sauce project from ~/client-data/uk_brownsauce/

# Generate a presentation directly
Use generate-presentation skill with input and output directories

# Evaluate an existing presentation
Use evaluate-presentation skill with the outputs directory
```
