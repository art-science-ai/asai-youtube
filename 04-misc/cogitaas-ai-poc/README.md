# Cogitaas AI POC

## Overview

This is a proof of concept (POC) project for developing AI-powered workflows to automate Cogitaas' manual Consumer Surplus Factor (CSF) workflow. The CSF workflow is an 8-stage analytical process that transforms raw market data into strategic pricing recommendations and stakeholder presentations.

**Initial focus**: Stage 7 (Presentation Generation) - the most labor-intensive stage requiring ~1 week of manual effort to create PowerPoint presentations with data-driven narratives and strategic recommendations.

**Long-term vision**: Expand AI automation across all 8 workflow stages, reducing end-to-end delivery time while maintaining analytical quality and strategic insight.

**Approach**:
1. Document existing manual workflows in plain language
2. Parse proprietary file formats (pptx, docx, xlsx, pdf, pbix) for AI analysis
3. Build AI workflows and convert them into reusable Claude Code skills
4. Test workflows on masked examples and iterate based on expert feedback

**Output**: Reusable Claude Code skills in `.claude/skills/` that can be invoked to automate CSF workflow stages across different projects and markets.

---

## Directory Structure

```
.
├── onedrive-data/                  # Symlink to shared OneDrive folder (READ-ONLY)
│   ├── Data_Sharing/
│   │   ├── full_examples/          # Complete CSF projects (UK_BBQ, UK_BrownSauce, US_Spoonables)
│   │   └── masked_examples/        # Anonymized examples for AI workflow testing
│   ├── CSF Project workflow.pptx   # Workflow overview presentation
│   ├── CSF_ReadMe.docx            # Detailed methodology documentation
│   └── Summary.docx               # Project summary
│
 ├── .claude/                        # Claude Code configuration and skills
 │   └── skills/                    # Skill development workspace
 │       ├── doc-parsing/         # Generic document parsing skill
 │       │   ├── workflows/       # Parsing method definitions per file type
 │       │   ├── resources/       # Templates for generated documentation
 │       │   └── SKILL.md       # Main skill file
 │       ├── workflows/             # Temporary workflow planning (scratch space)
 │       │   ├── README.md         # Complete 8-stage CSF workflow breakdown
 │       │   └── presentation-generation.md # Detailed Stage 7 automation plan
 │       └── [future skills]        # Additional skills as they are developed
│
├── parsed_data/                    # Local working directory with parsed document artifacts
│   ├── CSF Project workflow.pptx/  # Parsed presentation (20 slides + images)
│   ├── README.md                  # Mirror structure documentation and parsing status
│   └── [file.ext]/                # Parsed documents (file → dir conversion)
│
└── z-archive/                      # Archived parsed data from previous iterations
```

---

## Sub-Directory TL;DR

### `.claude/skills/`
Skill development workspace containing all skill-related artifacts. Each skill has its own subdirectory with workflows, resources, and the main skill file.

- **doc-parsing/**: Generic skill for parsing Office and BI files (pptx, docx, xlsx, pdf, pbix). Works with any directory structure, not tied to specific project.
  - **workflows/**: Parsing method definitions per file type with generic command patterns
  - **resources/**: Templates for file-level and top-level parsing reports
  - **SKILL.md**: Main skill file with usage instructions
- **workflows/**: Temporary scratch space for brainstorming and documenting AI workflows before converting them into reusable skills
- **[future skills]**: Additional skill directories as they are developed

### `parsed_data/`
Local mirror of `onedrive-data/` where source files become directories containing parsed artifacts. Each `file.ext/` directory contains extracted text (`content.md`), images, and parsing metadata (`readme.md`). Tracks parsing progress across 13 documents (1 parsed, 12 pending).

**Key pattern**: Files with extensions become directories (e.g., `presentation.pptx/`), regular folders stay as-is.

### `onedrive-data/` (READ-ONLY symlink)
Shared OneDrive folder containing source materials. Complete examples in `Data_Sharing/full_examples/` show end-to-end CSF projects (UK_BBQ, UK_BrownSauce, US_Spoonables). Use `masked_examples/` for AI workflow development and testing.

---

## Plan and TODOs

**Overall approach**: Build Claude Code skills for all automation tasks. The `workflows/` directory is a temporary planning space where we brainstorm and document workflows before converting them into reusable skills (see `.claude/skills/`).

### Phase 0: Skill Identification and Planning

Document workflows and identify the skills needed to automate them. Create a prioritized roadmap for skill development.

- [x] Create project README with overview and structure
- [x] Document 8-stage CSF workflow in `workflows/README.md`
- [x] Document Stage 7 presentation generation in detail
- [x] Set up project directory structure
- [x] Configure uv for Python script management
- [x] Create symlink to OneDrive shared folder
- [x] Identify "doc-parsing" skill as first priority
- [ ] Identify skills needed for presentation generation
- [ ] Identify skills needed for other CSF workflow stages
- [ ] Create prioritized skill development roadmap

### Phase 1: Skill Development

Develop and test individual skills. Each skill includes parsing scripts, workflow documentation, testing on reference examples, and conversion to a reusable Claude Code skill.

#### Doc Parsing Skill

Extract text and data from proprietary file formats (pptx, docx, xlsx, pdf, pbix) to analyze reference examples and understand existing manual processes.

- [x] Design generic parsing skill architecture (works with any directory)
- [x] Create workflow files for PPTX, DOCX, XLSX, PDF, PBIX parsing
- [x] Create orchestration workflow for batch processing
- [x] Create resource templates for documentation
- [ ] Test parsing workflows on sample files
- [ ] Validate parsing outputs using validate.md workflow
- [ ] Document parsing workflow usage patterns

#### PowerPoint Generation Skill

Generate PowerPoint presentations with structured content, charts, and strategic recommendations based on CSF analysis results.

- [ ] Analyze existing presentations to understand structure and patterns
- [ ] Design slide template framework
- [ ] Build slide creation and population logic
- [ ] Test on masked examples
- [ ] Validate with expert review
- [ ] Convert to Claude Code skill

#### Data Visualization Skill

Create charts, tables, and visualizations for presentations (RPI curves, MCV/CSF comparisons, market share scenarios).

- [ ] Identify all visualization types needed
- [ ] Build chart generation logic for each type
- [ ] Test visualization generation with example data
- [ ] Convert to Claude Code skill

#### Narrative Generation Skill

Generate strategic narratives and recommendations for presentations based on analysis results.

- [ ] Curate narrative examples from existing presentations
- [ ] Design LLM prompts for different narrative sections
- [ ] Test narrative generation
- [ ] Validate quality with expert review
- [ ] Convert to Claude Code skill

#### Quality Validation Skill

Ensure generated presentations meet quality standards through automated checks and human review workflows.

- [ ] Define quality assessment criteria
- [ ] Create automated validation checklist
- [ ] Build human review workflow
- [ ] Test validation on generated presentations
- [ ] Convert to Claude Code skill

### Phase 2: Post-POC / Post-MVP

Harden and expand the AI workflows beyond initial scope based on learnings from skill development.

- [ ] Optimize existing skills for speed and consistency
- [ ] Build monitoring and quality assurance systems
- [ ] Document runbooks and best practices
- [ ] Scale to additional markets and categories
- [ ] Explore automation opportunities for other CSF workflow stages
- [ ] Integrate skills into end-to-end pipeline as appropriate

