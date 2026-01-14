---
name: test
description: Manage CSF automation test cases. Creates new test directories or updates existing ones. Orchestrates pptx-to-markdown, generate-presentation, and evaluate-presentation skills based on user request. Supports selective regeneration of individual pipeline stages.
---

# Test Command

Manage CSF automation test cases. This command can:
- Create a new test directory from scratch with full pipeline execution
- Update an existing test directory by regenerating specific pipeline stages
- Run individual skills (pptx-to-markdown, generate-presentation, or evaluate-presentation) on demand

## Context

User provides a natural language request that can be:
- Create a new test case from source data
- Update/regenerate parts of an existing test case
- Run specific pipeline stages on existing test directories

## Process

### Step 1: Parse user request and detect mode

Analyze the natural language request to determine operation mode and parameters.

**Mode detection:**
Look for keywords indicating create vs update:
- **Create mode**: "new", "set up", "create", "test from [path]", or references to source data paths
- **Update mode**: "regenerate", "rerun", "update", "refresh", or references to existing test directory paths in tests/

**Extract parameters:**

**For Create mode:**
- **Project identifier**: Look for project name, market, or file/directory path
  - Examples: "US Spoonables", "UK Brown Sauce", "path/to/source/data/"
- **Input source**: Path to presentation file or CSV directory
- **Test directory**: Custom name or default pattern `{project}_{date}` (e.g., `us_spoonables_presentation_20250111`)

**For Update mode:**
- **Test directory**: Path to existing test in tests/ (e.g., "tests/us_spoonables_presentation_20250111/")
- **Target skills**: Which pipeline stages to regenerate
  - "pptx-to-markdown" / "parse presentation" / "ground truth"
  - "generate-presentation" / "generate outline"
  - "evaluate-presentation" / "evaluation"
  - If not specified, regenerate all stages

**Example parsing:**

Create mode:
- "Test US Spoonables presentation" → mode=create, project="US Spoonables", test_dir="us_spoonables_presentation_YYYYMMDD"
- "Set up test from path/to/data/" → mode=create, project=(derived from path), input_source="path/to/data/"
- "Create test for UK BBQ using ~/client-work/uk_bbq/" → mode=create, project="UK BBQ", input_source="~/client-work/uk_bbq/"

Update mode:
- "Regenerate presentation for tests/us_spoonables_presentation_20250111/" → mode=update, test_dir="tests/us_spoonables_presentation_20250111/", skills=["generate-presentation"]
- "Rerun evaluation for UK BBQ test" → mode=update, test_dir=(search for uk_bbq test), skills=["evaluate-presentation"]
- "Update tests/ukbbq_presentation_20250111/" → mode=update, test_dir="tests/ukbbq_presentation_20250111/", skills=all

### Step 2: Determine test directory and validate

**For Create mode:**

Check if test directory already exists in `tests/`:
1. Generate test directory name: `{project}_{date}` where:
   - `project` = sanitized project name (lowercase, underscores for spaces)
   - `date` = YYYYMMDD format
2. If directory exists, ask user if they want to:
   - Use existing directory (switch to update mode)
   - Create with different name
   - Overwrite (dangerous - warn user)

If proceeding with creation, create test directory structure:

```
tests/{project}_{date}/
├── inputs/          # Input data for the test (CSV files from user)
├── outputs/         # Generated outputs from generate-presentation skill
├── presentation-gt/ # Ground truth presentation from pptx-to-markdown skill
└── evaluation/      # Evaluation results from evaluate-presentation skill
```

Create all four directories (inputs, outputs, presentation-gt, evaluation).

**For Update mode:**

Validate that the test directory exists:
1. Check if the specified test directory exists in `tests/`
2. If directory not found but user provided partial name (e.g., "UK BBQ"), search for matching test directories:
   - Look for patterns like `*uk*bbq*` or `*ukbbq*` in tests/
   - If multiple matches, ask user to select
   - If no matches, report error
3. Validate that the directory has the expected structure (inputs/, outputs/, etc.)
4. Proceed with regeneration on the existing directory

### Step 3: Copy input files (Create mode only)

**Skip this step in Update mode** - use existing files in inputs/.

For Create mode, identify and copy relevant input files from the input directory to `tests/{test_dir}/inputs/`:

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
- If no files found, report error and exit

### Step 4: Run generate-presentation skill (conditional)

**When to run:**
- **Create mode**: Always run
- **Update mode**: Run only if user requested generate-presentation regeneration OR if running all skills

**Skip if:**
- Update mode and user didn't request this skill

**Execution:**

1. Check for 6.Brand_Level_Results.csv in tests/{test_dir}/inputs/
2. If not found, report error and exit
3. Clear existing outputs/ contents before regenerating (if Update mode)
4. Invoke generate-presentation skill from csf-automation plugin:
   - input_dir: tests/{test_dir}/inputs/
   - output_dir: tests/{test_dir}/outputs/

**The skill will:**
1. Run enhance_results.py on 6.Brand_Level_Results.csv
2. Generate presentation-outline.md from the enhanced CSV

**Expected outputs:**
- `outputs/6.Brand_Level_Results_Enhanced.csv` - CSV with categorization columns
- `outputs/presentation-outline.md` - Generated presentation outline

### Step 5: Parse ground truth presentation (conditional)

**When to run:**
- **Create mode**: Run if PPTX file exists in inputs/
- **Update mode**: Run only if user requested pptx-to-markdown regeneration OR if running all skills

**Skip if:**
- No PPTX file in inputs/
- Update mode and user didn't request this skill

**Execution:**

1. Check for PPTX file in tests/{test_dir}/inputs/
2. If found, invoke pptx-to-markdown skill from csf-automation plugin:
   - Source PPTX: tests/{test_dir}/inputs/{presentation}.pptx
   - Output directory: tests/{test_dir}/presentation-gt/
3. Clear existing presentation-gt/ contents before regenerating (if Update mode)
4. The skill generates structured markdown files in presentation-gt/

**Expected outputs in presentation-gt/:**
- 10.Presentation.md - Structured presentation with slide content
- presentation-text.md - Text-only content extraction
- alt-texts.md - Image alt text descriptions
- README.md - Presentation metadata and overview
- pdf/ - PDF export of presentation
- slide-images/ - Individual slide images as JPG files

### Step 6: Run evaluate-presentation skill (conditional)

**When to run:**
- **Create mode**: Always run
- **Update mode**: Run only if user requested evaluate-presentation regeneration OR if running all skills

**Skip if:**
- Update mode and user didn't request this skill

**Execution:**

1. Check for presentation-outline.md in tests/{test_dir}/outputs/
2. If not found, report error - evaluation requires generated presentation
3. Determine if ground truth is available:
   - Check if presentation-gt/ directory exists and contains files (10.Presentation.md or presentation.md)
   - Set ground_truth_available = true if found, false otherwise
4. Clear existing evaluation/ contents before regenerating (if Update mode)
5. Invoke evaluate-presentation skill from csf-automation plugin:
   - test_dir: tests/{test_dir}/
   - ground_truth_available: {boolean from step 3}

**The skill will:**
1. Use the ground_truth_available parameter (or auto-detect if not provided)
2. Scan outputs/ directory for presentation-outline.md and CSV data
3. If ground_truth_available=true: Check presentation-gt/ for ground truth files
4. Validate completeness, accuracy, and consistency of generated outline
5. If ground truth exists: perform semantic comparison and requirements extraction
6. Generate evaluation report → evaluation/

**Expected outputs in evaluation/:**
- evaluation-report.md - Quality evaluation report with completeness, consistency, and (if ground truth exists) semantic alignment analysis
- requirements.md - Extracted requirements from ground truth (if presentation-gt/ exists)
- comparison-details.md - Detailed comparison findings (if ground truth exists)

### Step 6: Report results

Provide a summary appropriate to the mode:

**For Create mode:**

```
Test created: tests/{test_directory}/

Created directories:
- inputs/ ({file_count} files copied)
- outputs/ (generated presentation files)
- presentation-gt/ (ground truth reference - if PPT provided)
- evaluation/ (quality assessment results)

Skills executed:
- pptx-to-markdown: ✓/✗ (if PPT provided)
- generate-presentation: ✓
- evaluate-presentation: ✓

Generated outputs:
- outputs/6.Brand_Level_Results_Enhanced.csv
- outputs/presentation-outline.md
- presentation-gt/10.Presentation.md (if PPT provided)
- presentation-gt/slide-images/ (if PPT provided)
- evaluation/evaluation-report.md
- evaluation/requirements.md (if ground truth provided)
- evaluation/comparison-details.md (if ground truth provided)

Quality score: {X/10}
Status: {Ready for production / Needs improvements / Almost ready}

Next steps:
1. Review evaluation/evaluation-report.md for identified issues
2. Review outputs/presentation-outline.md for accuracy
3. If ground truth provided, review evaluation/comparison-details.md for alignment gaps
4. Use findings to improve generate-presentation skill if needed
5. Create PowerPoint from outline for human review
```

**For Update mode:**

```
Test updated: tests/{test_directory}/

Skills regenerated:
- pptx-to-markdown: ✓/✗ (if requested)
- generate-presentation: ✓/✗ (if requested)
- evaluate-presentation: ✓/✗ (if requested)

Regenerated outputs:
[List only the outputs that were regenerated based on which skills ran]

Quality score: {X/10} (if evaluation ran)
Status: {Ready for production / Needs improvements / Almost ready}

Next steps:
[Provide steps relevant to what was regenerated]
```

## Examples

**Create mode - Set up new test directories:**

```bash
/test Set up test for US Spoonables presentation
/test Test UK Brown Sauce project from ~/client-data/uk_brownsauce/
/test Create test for US Spoonables using inputs/data/
/test Test project at ~/presentations/uk_bbq_presentation.pptx
```

**Update mode - Regenerate specific parts:**

```bash
/test Regenerate presentation for tests/us_spoonables_presentation_20250111/
/test Rerun evaluation for UK BBQ test
/test Update ground truth for tests/ukbbq_presentation_20250111/
/test Refresh evaluation in tests/ukbrownsauce_presentation_20250111/
```

**Update mode - Regenerate everything in existing test:**

```bash
/test Update tests/us_spoonables_presentation_20250111/
/test Rerun all skills for UK BBQ test
```

## Output Structure

```
tests/{project}_{date}/
├── inputs/
│   ├── 6.Brand_Level_Results.csv
│   ├── 7.Brand_Variant_Level_Results.csv (optional)
│   ├── 8.Brand_Variant_PPG_Level_Results.csv (optional)
│   └── UK_Brown_Sauce_Final.pptx (optional - copied for reference)
├── outputs/
│   ├── 6.Brand_Level_Results_Enhanced.csv
│   └── presentation-outline.md
├── presentation-gt/
│   ├── 10.Presentation.md (structured presentation)
│   ├── presentation-text.md (text extraction)
│   ├── alt-texts.md (image descriptions)
│   ├── README.md (metadata)
│   ├── pdf/
│   │   └── 10.Presentation.pdf
│   └── slide-images/
│       ├── slide-01.jpg
│       ├── slide-02.jpg
│       └── ... (one per slide)
└── evaluation/
    ├── evaluation-report.md (always generated)
    ├── requirements.md (if ground truth exists)
    └── comparison-details.md (if ground truth exists)
```

## Important Notes

**Operation modes:**
- **Create mode**: Sets up new test directory from scratch with source data
- **Update mode**: Regenerates specific pipeline stages in existing test directories
- **Selective regeneration**: Can run just one skill (pptx-to-markdown, generate-presentation, or evaluate-presentation) or all skills

**Test case types:**
- **Generation test**: When testing generate-presentation skill with only CSV data
- **Evaluation test**: When testing with ground truth presentation (full validation)
- **End-to-end test**: When testing both generation and evaluation

**File handling:**
- In Create mode: Always copy files, never move originals
- In Update mode: Clear target directory before regenerating to avoid stale artifacts
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
- evaluate-presentation skill automatically validates completeness and consistency
- With ground truth, also validates semantic alignment
- Quality score objectively measures presentation readiness

## Integration with Skills

This command orchestrates the following skills in sequence:

1. **pptx-to-markdown** (from csf-automation plugin)
   - Converts PowerPoint presentations to markdown format
   - Invoked in Step 4 if PPTX file exists in inputs/
   - Outputs to presentation-gt/ directory with structured markdown files, images, and PDFs

2. **generate-presentation** (from csf-automation plugin)
   - Enhances Brand-Level Results CSV with categorizations
   - Generates presentation outlines with data-driven narratives
   - Applies client-specific business rules and thresholds
   - Outputs to outputs/ directory

3. **evaluate-presentation** (from csf-automation plugin)
   - Validates generated outlines for completeness and consistency
   - Extracts requirements from ground truth in presentation-gt/ (if provided)
   - Generates quality reports with actionable feedback
   - Operates in two modes: self-evaluation or ground truth comparison
   - Receives ground_truth_available parameter from orchestrator (auto-detected based on presentation-gt/ presence)
   - Outputs to evaluation/ directory
