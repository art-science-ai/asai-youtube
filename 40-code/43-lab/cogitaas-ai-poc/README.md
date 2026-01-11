# Cogitaas AI POC

## Overview

This is a proof of concept project for automating Cogitaas' manual Consumer Surplus Factor (CSF) workflow using AI. The CSF workflow is an 8-stage analytical process that transforms raw market data into strategic pricing recommendations and presentations.

### Focus

Initial focus is on Stage 7 (Presentation Generation), which requires about 1 week of manual effort to create PowerPoint presentations with data-driven narratives. The long-term vision is to expand AI automation across all 8 workflow stages.

### Approach

The project works in four steps:

- Document existing manual workflows in plain language
- Parse proprietary file formats (pptx, docx, xlsx, pdf, pbix) for AI analysis
- Build AI workflows and convert them into reusable Claude Code skills
- Test workflows on masked examples and iterate based on feedback

### Output

The deliverable is reusable Claude Code skills that automate CSF workflow stages across different projects and markets.

---

## CSF workflow stages

The Consumer Surplus Factor (CSF) workflow follows these stages:

1. Data Collection - IRI, Nielsen, IMRB, in-house data, promo calendars
2. Data Preparation - Scope identification and modeling-ready data preparation
3. EDA and Data Validation - Power BI or webapp dashboards
4. Modelling - Feature creation, model building
5. Model Selection - Statistical filtering and business context selection
6. Results and Outputs - MCV, CSF, MSPs calculation, RPI curves
7. Presentation - PowerPoint generation
8. Scenario Planner - Strategic planning


---
## Directory structure

```
root/
├── ai-plugins/               # Automation: skills and plugins
│   ├── csf-automation/       # CSF workflow automation
│   └── doc-parsing/          # Document parsing (pptx, docx, xlsx, pdf, pbix)
├── data/                     # Input data (read-only)
│   └── parsed-onedrive-data/ # Processed data from OneDrive
│       ├── Data_Sharing/full_examples/
│       ├── Data_Sharing/masked_examples/
│       └── CSF reference materials
├── tests/                    # Skill execution and validation runs
└── z-archive/                # Historical iterations (moved from parsed_data/, scripts/, .claude/, .plugins/)
```

**Data access rules:**
- NEVER edit files in the OneDrive shared folder
- Only work with copies or process files to output directories
- Use masked_examples/ for AI workflow development
- Protect sensitive client data at all times

---

## Testing and validation workflow

All skill executions are stored in the `tests/` directory for traceability and validation.

### Test directory structure

Each test follows the naming convention `{project}_{skill}_{date}`:

```
tests/
└── ukbbq_presentation_20250111/
    ├── inputs/                  # Data provided to the skill
    ├── outputs/                 # Generated outputs
    └── evaluation/              # Optional: validation materials
        ├── presentation-final/  # Ground truth presentation
        ├── requirements.md      # Semantic requirements from ground truth
        └── evaluation.md        # Assessment of outputs vs requirements
```

### Validation workflow

When developing skills with ground truth data (e.g., existing client presentations):

1. Create test directory: `tests/{project}_{skill}_{date}/`
2. If validating, create `evaluation/` subdirectory
3. Copy templates from the skill:
   - `ai-plugins/{plugin}/skills/{skill}/templates/REQUIREMENTS_TEMPLATE.md` → `evaluation/requirements.md`
   - Fill in semantic requirements from ground truth
4. Run the skill to generate outputs
5. Copy `templates/EVALUATION_TEMPLATE.md` → `evaluation/evaluation.md`
6. Assess whether outputs capture required business insights
7. Iterate on skill definition based on gaps

When working without ground truth, skip the `evaluation/` directory and review outputs directly.

---


## Roadmap

### Foundations
- [x] Setup project structure (ai-plugins/, data/, runs/)
- [x] PPTX to markdown conversion (PDF-based method)
- [ ] Expand parsing to DOCX, XLSX, PDF, PBIX

### CSF automation
- [x] Develop presentation generation plugin 
- [ ] Test on multiple projects 
- [ ] Validation and feedback from subject matter experts
- [ ] Build end-to-end workflow
