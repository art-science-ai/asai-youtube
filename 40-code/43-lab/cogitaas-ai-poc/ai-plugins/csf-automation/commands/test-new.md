---
name: test-new
description: Set up a new test case for CSF automation. Takes a natural language description of a project to test (file path, directory, or description), creates test directory structure, copies inputs, and orchestrates pptx-to-markdown, csf-presentation, and csf-evaluation skills.
---

# Test New Project

Set up a new test case for CSF automation workflow. This command orchestrates the complete test setup including directory creation, input file copying, presentation parsing, presentation generation, and quality evaluation.

## Context

User provides a natural language request describing a project to test. The request may include:
- A path to an existing presentation file (pptx)
- A path to a directory containing Brand-Level Results CSVs
- A description of the project name and market

## Process

### Step 1: Parse user request

Extract parameters from the natural language request:

**Required:**
- **Project identifier**: Look for project name, market, or file/directory path
  - Examples: "US Spoonables", "UK Brown Sauce", "path/to/presentation.pptx"

**Optional:**
- **Input source**: Path to presentation file or CSV directory (derived from project identifier if it's a path)
- **Test directory**: Custom test directory name. Default pattern: `{project}_{date}` (e.g., `us_spoonables_presentation_20250111`)

**Example parsing:**
- "Test US Spoonables presentation" → project="US Spoonables", test_dir="us_spoonables_presentation_YYYYMMDD"
- "Set up test from path/to/data/" → project=(derived from path), input_source="path/to/data/"
- "Test project at ~/client-work/uk_bbq/" → project="UK BBQ", input_source="~/client-work/uk_bbq/"

### Step 2: Create test directory structure

Create the test directory in `tests/` with the following structure:

```
tests/{project}_{date}/
├── inputs/          # Input data for the test (CSV files, optional PPT)
└── outputs/         # Generated outputs from skills
```

**Directory creation:**
1. Generate test directory name: `{project}_{date}` where:
   - `project` = sanitized project name (lowercase, underscores for spaces)
   - `date` = YYYYMMDD format

2. Create both directories (inputs, outputs)

### Step 3: Copy input files

Identify and copy relevant input files from the input directory to `tests/{test_dir}/inputs/`:

**File discovery patterns:**
Look for these patterns in the input directory:
- `6.Brand_Level_Results.csv` - Primary brand-level analysis (required)
- `7.Brand_Variant_Level_Results.csv` - Variant-level analysis (optional)
- `8.Brand_Variant_PPG_Level_Results.csv` - PPG-level analysis (optional)
- `*.pptx` - Presentation files (optional but recommended for evaluation)
- `*.csv` - Any other CSV files that may be relevant

**Copy strategy:**
- Copy all CSV files to `tests/{test_dir}/inputs/`
- If a presentation file exists, copy it to `tests/{test_dir}/inputs/` (will be converted to markdown in next step)

### Step 4: Parse ground truth presentation (if provided)

If a PPTX file was copied to inputs/ in the previous step:

1. Invoke pptx-to-markdown skill from csf-automation plugin
2. Provide source PPTX: tests/{test_dir}/inputs/{presentation}.pptx
3. Provide output directory: tests/{test_dir}/inputs/
4. The skill will generate presentation.md in the inputs/ directory

**Expected outputs:**
- inputs/presentation.md - Converted markdown (source for requirements extraction)

**Note:** This step is skipped if no PPTX file exists in inputs/.

### Step 5: Run csf-presentation skill

Invoke the csf-presentation skill to generate the presentation outline from the Brand-Level Results CSV.

**Skill invocation:**
```
Use the csf-presentation skill from the csf-automation plugin.

The skill takes input_dir and output_dir as parameters:
- input_dir: tests/{test_dir}/inputs/
- output_dir: tests/{test_dir}/outputs/

The skill will:
1. Run enhance_results.py on 6.Brand_Level_Results.csv
2. Generate presentation-outline.md from the enhanced CSV
```

**Expected outputs:**
- `outputs/6.Brand_Level_Results_Enhanced.csv` - CSV with categorization columns
- `outputs/presentation-outline.md` - Generated presentation outline

### Step 6: Run csf-evaluation skill

Invoke the csf-evaluation skill to validate the generated presentation and extract requirements if ground truth is available.

**Skill invocation:**
```
Use the csf-evaluation skill from the csf-automation plugin.

Provide the project directory: tests/{test_dir}/outputs/

The skill will:
1. Scan outputs/ directory for presentation-outline.md and 6.Brand_Level_Results.csv
2. Check inputs/ for presentation.md (if PPT was converted in Step 4)
3. Detect evaluation mode based on available files
4. If presentation.md exists: extract requirements → outputs/requirements.md
5. Validate completeness and consistency of generated outline
6. If requirements exist: perform ground truth comparison
7. Generate evaluation report → outputs/evaluation.md
```

**Expected outputs:**
- If presentation.md exists: `outputs/requirements.md` - Extracted requirements
- `outputs/evaluation.md` - Quality evaluation report (with Sections 1-2 always, Section 3 if ground truth exists)

### Step 7: Report results

Provide a summary to the user:

```
Test setup complete: tests/{test_directory}/

Created directories:
- inputs/ ({file_count} files copied)
- outputs/ (ready for skill outputs)

Skills executed:
- pptx-to-markdown: ✓ (if PPT provided)
- csf-presentation: ✓ (outline generated)
- csf-evaluation: ✓ (quality report generated)

Generated outputs:
- inputs/presentation.md (if PPT provided)
- outputs/6.Brand_Level_Results_Enhanced.csv
- outputs/presentation-outline.md
- outputs/evaluation.md (and outputs/requirements.md if ground truth provided)

Quality score: {X/10}
Status: {Ready for production / Needs improvements / Almost ready}

Next steps:
1. Review outputs/evaluation.md for identified issues
2. Review outputs/presentation-outline.md for accuracy
3. Use findings to improve csf-presentation skill if needed
4. Create PowerPoint from outline for human review
```

## Examples

```bash
/test-new Set up test for US Spoonables presentation
/test-new Test UK Brown Sauce project from ~/client-data/uk_brownsauce/
/test-new Create test for US Spoonables using inputs/data/
/test-new Test project at ~/presentations/uk_bbq_presentation.pptx
```

## Output Structure

```
tests/{project}_{date}/
├── inputs/
│   ├── 6.Brand_Level_Results.csv
│   ├── 7.Brand_Variant_Level_Results.csv (optional)
│   ├── 8.Brand_Variant_PPG_Level_Results.csv (optional)
│   ├── UK_Brown_Sauce_Final.pptx (optional - ground truth PPT)
│   └── presentation.md (optional - converted from PPT by orchestrator)
└── outputs/
    ├── 6.Brand_Level_Results_Enhanced.csv
    ├── presentation-outline.md
    ├── requirements.md (if presentation.md provided)
    └── evaluation.md (always generated)
```

## Important Notes

**Test case types:**
- **Generation test**: When testing csf-presentation skill with only CSV data
- **Evaluation test**: When testing with ground truth presentation (full validation)
- **End-to-end test**: When testing both generation and evaluation

**File handling:**
- Always copy files, never move originals
- Preserve original file names and structure

**Date formatting:**
- Use YYYYMMDD format for directory names
- Use YYYY-MM-DD format for file content

**Project name sanitization:**
- Convert to lowercase
- Replace spaces with underscores
- Remove special characters
- Example: "US Spoonables" → "us_spoonables"

**Quality assessment:**
- csf-evaluation skill automatically validates completeness and consistency
- With ground truth, also validates semantic alignment
- Quality score objectively measures presentation readiness

## Integration with Skills

This command orchestrates the following skills in sequence:

1. **pptx-to-markdown** (from csf-automation plugin)
   - Converts PowerPoint presentations to markdown format
   - Invoked in Step 4 if PPTX file exists in inputs/
   - Generates presentation.md for requirements extraction

2. **csf-presentation** (from csf-automation plugin)
   - Enhances Brand-Level Results CSV with categorizations
   - Generates presentation outlines with data-driven narratives
   - Applies client-specific business rules and thresholds

3. **csf-evaluation** (from csf-automation plugin)
   - Validates generated outlines for completeness and consistency
   - Extracts requirements from presentation.md (if provided)
   - Generates quality reports with actionable feedback
   - Operates in two modes: self-evaluation or ground truth comparison
