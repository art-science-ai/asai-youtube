# CSF Automation Plugin

Automates Consumer Surplus Factor (CSF) presentation generation from quantitative analysis results.

## Overview

This plugin streamlines Stage 7 of the CSF workflow by automating the transformation of Brand-Level Results into presentation-ready content.

## What it does

The plugin provides a unified skill that:
1. Interprets quantitative results (CSF, price elasticity, market share)
2. Generates presentation structure and outline
3. Provides guidance for final PowerPoint creation

## Skills

### csf-presentation

Comprehensive skill covering the full presentation generation workflow (Stages 7a, 7b, 7c).

**When to use**: When you have Brand-Level Results CSV from Stage 6 and need to create a presentation.

**Outputs**:
- Intermediate analysis format (YAML or CSV)
- Presentation outline (Markdown with slide-by-slide structure)

## Installation

This plugin is part of the Cogitaas AI POC project. See main project README for CSF workflow context.

## Documentation

Detailed reference documentation is available in:
- `skills/csf-presentation/references/presentation-generation.md` - Overview of Stage 7
- `skills/csf-presentation/references/presentation-planning.md` - Planning guidance
- `skills/csf-presentation/references/presentation-execution.md` - Execution guidance

## Version

0.1.0 (MVP - In Development)
