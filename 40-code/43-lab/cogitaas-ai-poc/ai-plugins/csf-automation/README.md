# CSF Automation Plugin

Automates Consumer Surplus Factor (CSF) presentation generation from quantitative analysis results.

## Overview

This plugin streamlines Stage 7 of the CSF workflow by automating the transformation of Brand-Level Results into presentation-ready content.

## What it does

The plugin provides a unified skill that:
1. Interprets quantitative results (CSF, price elasticity, market share)
2. Generates presentation structure and outline
3. Provides guidance for final PowerPoint creation

## Directory structure

```
ai-plugins/csf-automation/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── README.md                    # This file
└── skills/
    └── csf-presentation/
        ├── SKILL.md             # Skill documentation and workflow
        ├── scripts/
        │   └── enhance_results.py  # Data enhancement script
        └── templates/           # Validation templates
            ├── REQUIREMENTS_TEMPLATE.md
            └── EVALUATION_TEMPLATE.md
```

See the project root README for the testing workflow and tests/ directory structure.

## Skills

### csf-presentation

Comprehensive skill covering the full presentation generation workflow (Stages 7a, 7b, 7c).

**When to use**: When you have Brand-Level Results CSV from Stage 6 and need to create a presentation.

**Outputs**:
- Intermediate analysis format (YAML or CSV)
- Presentation outline (Markdown with slide-by-slide structure)

**Development status**: Active iteration. See `tests/` directory for execution history and validation runs.

