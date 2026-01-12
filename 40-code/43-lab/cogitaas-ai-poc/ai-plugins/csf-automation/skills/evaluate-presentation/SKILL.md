---
name: evaluate-presentation
description: This skill should be used when the user asks to "evaluate presentation", "validate presentation quality", "extract requirements from presentation", "test presentation generation", or mentions quality assurance for presentations. Validates presentation outlines against source CSV data and optionally against ground truth presentations.
---

# Evaluate Presentation Skill

## Overview

Validates CSF presentation outlines for completeness, accuracy, and consistency. Automatically detects CSV granularity (brand/variant/PPG level) and adjusts validation accordingly. When ground truth is available, also validates ground truth alignment.

Use when:
- Validating generated presentation outlines
- Testing presentation generation against ground truth
- Performing quality checks before human review
- Extracting requirements from finalized presentations

## Process

### Step 1: Detect inputs and CSV granularity

**User inputs:**
- **test_dir** (required): Test directory path (e.g., "tests/us_spoonables_presentation_20250111/")
- **ground_truth_available** (optional): Boolean indicating if ground truth exists
  - If provided: Use this value to determine evaluation mode
  - If not provided: Auto-detect by checking for presentation-gt/ directory

**Input inference logic:**

If ground_truth_available not provided:
1. Check if `{test_dir}/presentation-gt/` directory exists
2. If exists and contains files: ground_truth_available = true
3. Otherwise: ground_truth_available = false

**File discovery:**

From `{test_dir}/outputs/`:
- `presentation-outline.md` - Required (the outline to evaluate)
- `*Brand*_Level_Results.csv` - Required (source data, auto-detected)

From `{test_dir}/presentation-gt/` (if ground_truth_available):
- `10.Presentation.md` or `presentation.md` - Ground truth presentation
- Used for requirements extraction and alignment validation

**CSV type detection:**

```python
if "Variant" in columns and "PPG" in columns:
    csv_type = "PPG-level"
elif "Variant" in columns:
    csv_type = "Variant-level"
else:
    csv_type = "Brand-level"
```

**Priority order:**
1. `8.Brand_Variant_PPG_Level_Results.csv`
2. `7.Brand_PPG_Level_Results.csv`
3. `7.Brand_Variant_Level_Results.csv`
4. `6.Brand_Level_Results.csv`

**Ground truth detection:**

Based on ground_truth_available parameter (or auto-detection):

If ground_truth_available = true:
1. Check `{test_dir}/evaluation/requirements.md` - If exists: Use for ground truth alignment
2. Check `{test_dir}/presentation-gt/10.Presentation.md` or `presentation.md` - If exists but no requirements.md: Extract requirements first
3. If no ground truth files found: Warn user and proceed without ground truth

If ground_truth_available = false:
- Skip ground truth alignment (self-evaluation mode only)

### Step 2: Validate presentation quality

#### 2.1: Completeness

Check that `presentation-outline.md` contains:
- All channels from CSV
- All brands from CSV
- Analysis depth matches CSV type:
  - Brand-level: Brand-level insights
  - Variant-level: Variant-level insights
  - PPG-level: Pack-type insights
- Required sections: title, executive summary, findings, recommendations

#### 2.2: Accuracy

Verify against source CSV using client thresholds:

**CSF Thresholds:**
- High: >= 2.0
- Medium: 1.7 - 2.0
- Low: < 1.7

**Price Elasticity Thresholds:**
- Less elastic: >= -4
- Moderately elastic: -7 to -4
- Highly elastic: < -7

**MSP Thresholds:**
- Positive: > 0.001
- Stable: -0.001 to 0.001
- Negative: < -0.001

#### 2.3: Consistency

Verify:
- Recommendations align with metrics (e.g., high CSF → consider price increase)
- Narratives match data (e.g., low CSF shouldn't be called "strong position")
- Competitive insights match the data

#### 2.4: Ground truth alignment (if ground truth available)

**Ground truth extraction and validation:**

If ground truth presentation exists in `{test_dir}/presentation-gt/`, extract and validate:
- Scope (channels, brands, CSV type)
- Key insights at appropriate granularity level:
  - Brand-level: Per-brand insights
  - Variant-level: Per-variant insights
  - PPG-level: Per-pack insights
- Competitive dynamics
- Recommendations

Then compare `presentation-outline.md` against extracted ground truth:
- Market health insights captured
- Insights at correct granularity level
- Recommendations match ground truth

All ground truth information is embedded as an optional section in the evaluation report.

### Step 3: Generate evaluation report

Create a single consolidated evaluation report using `templates/presentation-evaluation.md`.

**Output location:** `{test_dir}/evaluation/evaluation-report.md`

**Report structure:**
- Completeness, accuracy, and consistency checks (always included)
- Ground truth comparison section (optional, only when ground truth available):
  - Extracted ground truth insights
  - Alignment assessment
  - Differences from ground truth
- Issues table
- Overall assessment with quality score
- Notes

**Quality gate:**
- Pass: All critical items pass, no high-severity issues
- Fail: Any critical item fails or high-severity issue exists

**Issue severity:**
- High: Blocks production (missing critical data or insight)
- Medium: Needs improvement (weak narrative or incomplete analysis)
- Low: Acceptable variation (minor phrasing difference)

### Step 4: Report results

```
Test directory: {test_dir}
Ground truth: {Available/Not available} (parameter: {provided value or "auto-detected"})
CSV type detected: [type]

Evaluation results:
- Completeness: [Pass/Fail]
- Accuracy: [Pass/Fail]
- Consistency: [Pass/Fail]
- Ground truth alignment: [Pass/Fail/N/A]

Overall: [Pass/Fail]
Quality score: [X/10]
Issues: X high, Y medium, Z low

Output generated:
- {test_dir}/evaluation/evaluation-report.md
  (includes ground truth comparison if available)

Next steps: [Ready for review / Fix issues]
```

## Important notes

**CSV granularity:**
- The key variation is analysis depth, not just brands
- PPG-level CSVs should have pack-type insights
- Variant-level CSVs should have variant insights
- Brand-level CSVs should have brand-level insights
- Requirements extraction adapts structure based on CSV type

**Ground truth modes:**
- With ground truth: Extract/use requirements, validate ground truth alignment
- Without ground truth: Validate accuracy, completeness, consistency only

**Ground truth parameter:**
- Can be explicitly provided via ground_truth_available parameter
- If not provided, automatically detected by checking for presentation-gt/ directory
- Explicit parameter useful when orchestrating from test command or CI/CD
- Auto-detection useful for interactive/manual evaluation sessions

## Troubleshooting

**CSV type not detected:**
- Check file naming pattern (6.*, 7.*, 8.*)
- Verify CSV has expected columns

**Accuracy errors:**
- Verify thresholds match client rules
- Check CSV data quality (no NaN/null in key fields)

**Granularity mismatch:**
- Ensure presentation analysis depth matches CSV type
- PPG CSV requires pack-level insights
- Variant CSV requires variant-level insights

## References

**Related skills:**
- `generate-presentation` - Generate presentation outlines from CSV data

**Orchestrator dependencies:**
- `pptx-to-markdown` - Converts PowerPoint to presentation.md

**Templates:**
- `templates/presentation-evaluation.md` - Consolidated evaluation report structure with optional ground truth section
