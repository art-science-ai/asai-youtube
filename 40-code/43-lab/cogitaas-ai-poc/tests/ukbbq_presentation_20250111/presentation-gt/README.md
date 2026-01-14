# UK BBQ Presentation - Ground Truth

**Source:** 8.Presentation.pptx
**Generated:** 2025-01-12
**Total Slides:** 19
**Conversion Method:** LibreOffice + markitdown + AI alt-texts

## Contents

This directory contains the ground truth presentation materials for the UK BBQ brand performance analysis, converted from PowerPoint to markdown format for AI analysis and evaluation.

### Files

- **8.Presentation.md** - Complete markdown representation with inline slide images
- **8.Presentation-text.md** - Text-only extraction (no images)
- **alt-texts.md** - Detailed descriptions of each slide's visual content
- **pdf/** - PDF export of the original presentation
- **slide-images/** - Individual JPEG images for each of the 19 slides (150 DPI)

## Presentation Overview

This is a business analytics presentation analyzing UK BBQ brand performance using the CSF (Consumer Shopper Feedback) framework. The presentation covers:

- Business context and market overview
- Analytical methodology
- Brand performance breakdown (Price, CSF, MCV components)
- Channel-specific analysis (Retail vs Online)
- Competitive and regional analysis
- Strategic recommendations and implementation roadmap

## Visual Design Patterns

**Color Scheme:**
- Red = Price component
- Orange = CSF (Consumer Shopper Feedback) component
- Blue = MCV (Marketing Conversion Value) component

**Chart Types:**
- Stacked bar charts for component breakdown
- Dual-panel comparison layouts
- Performance tables with benchmarks
- Timeline/Gantt charts for roadmap

## Usage in Testing

This ground truth is used for:
1. Evaluating generated presentation outlines from the `generate-presentation` skill
2. Extracting requirements for presentation structure and content
3. Semantic comparison between AI-generated and human-created presentations
4. Validating business logic and analytical framework application

## Conversion Details

**Conversion Date:** 2025-01-12
**Script:** `ai-plugins/csf-automation/skills/pptx-to-markdown/scripts/convert_pptx_to_markdown.py`
**Resolution:** 150 DPI (1.7MB total for slide images)
**Text Extraction:** markitdown library
**PDF Export:** LibreOffice headless conversion

All slides successfully converted with preserved layout, text content, and visual elements.
