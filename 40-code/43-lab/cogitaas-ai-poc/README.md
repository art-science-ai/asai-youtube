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

## Architecture

This project uses a simple three-part structure:

```
root/
├── claude/          # Automation: skills, plugins, and scripts
├── client-data/     # Input: Read-only OneDrive fixtures
└── runs/            # Output: Timestamped execution results
```

- **claude/** contains all automation logic
- **client-data/** contains read-only test fixtures (currently onedrive-data symlink)
- **runs/** contains outputs from workflow executions

Each workflow run creates a timestamped directory in runs/ with its outputs and logs.

---

## Directory structure

### claude/

All automation code: plugins for parsing, skills for workflow stages, and orchestration scripts.

**Key components:**
- doc-parsing/ - Extract text from pptx, docx, xlsx, pdf, pbix
- csf-automation/ - Domain-specific CSF workflow skills
  - pptx-to-markdown/ - Convert presentations to markdown
  - interpret-csf-results/ - Stage 7a: Interpret model outputs
  - plan-csf-presentation/ - Stage 7b: Structure presentation outline
  - generate-csf-presentation/ - Stage 7c: Create PowerPoint files

### client-data/

Read-only test fixtures (currently onedrive-data symlink at root).

- Data_Sharing/full_examples/ - Complete CSF projects
- Data_Sharing/masked_examples/ - Anonymized test data
- CSF_Project_workflow.pptx, CSF_ReadMe.docx, and reference materials

**Data access rules:**
- NEVER edit files in the OneDrive shared folder
- Only work with copies or process files to output directories
- Use masked_examples/ for AI workflow development
- Protect sensitive client data at all times

### runs/

Auto-generated execution history with dual views:

**by-project/** - Vertical view: workflow versions per project
- Example: runs/by-project/uk_bbq/v3-full-pipeline/
- Shows the complete workflow for a specific project

**by-stage/** - Horizontal view: method comparison across projects
- Example: runs/by-stage/01-parse-presentation/method-pdf-conversion/
- Compares different parsing methods

**Each run contains:**
- workflow-manifest.yaml - Pipeline definition with stages and dependencies
- [stage]/output/ - Outputs from each workflow stage
- execution.log - Complete execution logs

---

## Workflow execution

Workflows are driven by workflow-manifest.yaml files that define stages and dependencies.

### Example workflow manifest

```yaml
run_id: v3-full-pipeline
project: uk_bbq
timestamp: 2024-01-10T15:00:00

stages:
  - name: 01-parse-presentation
    skill: pptx-to-markdown
    input: client-data/UK_BBQ/10.Presentation.pptx
    output: 01-parse-presentation/output/
    status: completed

  - name: 02-interpret-results
    skill: interpret-csf-results
    input: 01-parse-presentation/output/
    output: 02-interpret-results/output/
    dependencies:
      - 01-parse-presentation
    status: completed

  - name: 03-plan-presentation
    skill: plan-csf-presentation
    input: 02-interpret-results/output/
    output: 03-plan-presentation/output/
    status: pending
```

### Execution flow

1. Create timestamped run directory: runs/20240110_1500_uk_bbq/
2. Execute stages in order (each stage uses previous stage's output)
3. Save outputs to stage-specific directories
4. Log all execution details to execution.log
5. Update runs/latest symlink to newest run

**Key benefits:**
- Isolation: Original fixtures in client-data/ never modified
- Reproducibility: Each run is self-contained with logs
- Debugging: execution.log captures everything
- Flexibility: Re-run individual stages by updating inputs

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

## Directory mapping

This documentation describes the target architecture. Some paths are conceptual and will be implemented in future reorganization.

| Current path | Conceptual path | Purpose |
| ------------ | --------------- | ------- |
| .claude/skills/ | claude/ | Automation skills and plugins |
| .plugins/ | claude/ | Automation plugins |
| onedrive-data/ | client-data/ | Read-only test fixtures |
| scripts/ | claude/ | Orchestration scripts |
| clean_data_manual/ | runs/by-project/ | Project-specific workflows |
| parsed_data/ | runs/by-stage/ | Cross-project comparisons |
| z-archive/ | runs/archive/ | Historical iterations |

---

## Plan and todos

### Phase 0: Reorganization

Restructure project to simplified architecture.

- [x] Design simplified architecture (claude/, client-data/, runs/)
- [x] Update README with new structure documentation
- [ ] Move .plugins/ and .claude/skills/ to claude/
- [ ] Rename onedrive-data/ to client-data/
- [ ] Organize scripts/ and outputs/ into runs/
- [ ] Update CLAUDE.md with new structure

### Phase 1: Platform development

Develop automation skills.

#### Doc parsing

- [x] PPTX to markdown conversion (working method: PDF-based conversion)
- [x] Create pptx-to-markdown skill with examples
- [ ] Add DOCX, XLSX, PDF, and PBIX parsing skills
- [ ] Create tests

#### CSF automation

- [x] interpret-csf-results skill (Stage 7a)
- [ ] Fix PE threshold bug and add CSV schema validation
- [ ] Document CSF thresholds and edge cases
- [ ] plan-csf-presentation skill (Stage 7b)
- [ ] generate-csf-presentation skill (Stage 7c)
- [ ] Add integration tests

### Phase 2: CSF application

Apply skills to CSF projects, iterate on methods.

- [x] Test v1-markitdown (didn't work well)
- [x] Test v2-python-pptx (partial results)
- [x] Test v3-pdf-conversion (working)
- [ ] Test v3 on other projects (uk_brownsauce, masked_examples)
- [ ] Document v3 as current best method in runs/by-stage/
- [ ] Run interpret-csf-results on uk_bbq data
- [ ] Execute full presentation generation workflow
- [ ] Validate with domain expert review and iterate

### Phase 3: Harden and expand

- [ ] Package skills for reuse
- [ ] Optimize for speed and consistency
- [ ] Add monitoring and quality assurance
- [ ] Document runbooks and best practices
- [ ] Scale to additional CSF projects and markets
