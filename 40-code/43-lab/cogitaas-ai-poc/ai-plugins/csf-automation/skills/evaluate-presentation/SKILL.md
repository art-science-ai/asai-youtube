---
name: csf-evaluation
description: This skill should be used when the user asks to "evaluate CSF presentation", "validate presentation quality", "extract requirements from presentation", "test presentation generation", or mentions quality assurance for CSF presentations. Handles both ground truth extraction and presentation validation.
---

# CSF Evaluation Skill

## Overview

This skill provides quality assurance for CSF presentations by validating completeness, consistency, and semantic alignment. It operates in two modes depending on ground truth availability.

Use this skill when:
- Validating generated presentation outlines for quality
- Extracting requirements from finalized PowerPoint presentations
- Testing presentation generation against known ground truth
- Performing quality checks before human review

For presentation generation, use the companion `csf-presentation` skill.

## What This Skill Does

The skill provides comprehensive quality assurance:

**Mode 1: Ground truth comparison (development/testing)**
- Extracts requirements from finalized PowerPoint presentations
- Validates generated outlines against ground truth requirements
- Identifies semantic gaps and missing insights
- Generates detailed evaluation reports with Section 3 (ground truth comparison)

**Mode 2: Self-evaluation (production)**
- Validates completeness (all channels, brands, sections present)
- Checks internal consistency (numbers align with CSV, categories correct)
- Verifies presentation quality without ground truth reference
- Generates evaluation reports with Sections 1-2 only

## Process

### Step 1: Detect evaluation mode

When invoked, the user provides a single project directory. Scan this directory to discover available files:

**Required input:**
- Project directory path

**File discovery (scan directory for):**
- `presentation-outline.md` - Generated outline to evaluate (required)
- `6.Brand_Level_Results.csv` - Source data for validation (required)
- `presentation.md` - Ground truth markdown (optional, for ground truth mode)
- `requirements.md` - Pre-extracted requirements (optional, skips extraction)

**Mode detection:**
- **Ground truth mode**: If presentation.md or requirements.md exists in directory
- **Self-evaluation mode**: If neither exists

**Example invocations:**
- "Evaluate presentation in tests/us_spoonables/outputs/"
- "Validate the presentation in project/outputs/"
- "Test presentation quality in tests/uk_bbq/outputs/"

### Step 2a: Extract requirements (ground truth mode only)

If presentation.md exists but requirements.md missing:

1. Read the presentation.md content
2. Analyze the presentation content to extract:
   - Analysis scope (channels, brands, levels)
   - Key insights captured in executive summary
   - Per-brand insights (CSF, elasticity, MSP, positioning)
   - Competitive dynamics
   - PPG/Variant insights (if applicable)
   - Key recommendations with rationale
   - Critical comparisons performed
   - Business context

3. Write extracted requirements to `tests/{project_name}/requirements.md` using `templates/requirements.md` structure

**Requirements extraction focuses on:**
- Semantic content (what insights were communicated)
- Strategic recommendations (what actions were proposed)
- Critical analyses (what comparisons were made)
- Business context (what market dynamics were acknowledged)

### Step 2b: Validate completeness (all modes)

Check the generated `presentation-outline.md` for:

**Scope coverage:**
- All channels from CSV represented
- All brands analyzed
- Correct analysis level (brand/PPG/variant)

**Section completeness:**
- Title slide present
- Executive summary with market health, brand insights, recommendations
- Market context for each channel
- CSF & MCV analysis tables
- Detailed findings per channel
- Final recommendations slide

**Data coverage:**
- All brands have CSF, elasticity, MSP, positioning insights
- Market leaders identified
- Competitive positions analyzed

### Step 3: Validate consistency (all modes)

Verify internal consistency between outline and input data:

**Numerical accuracy:**
- CSF values match CSV (or Enhanced CSV if used)
- Market share percentages correct
- Price elasticity values accurate
- MSP values correct

**Categorical accuracy:**
- CSF categories (high/medium/low) match thresholds
- PE categories (less/moderately/highly elastic) match thresholds
- MSP categories (positive/stable/negative) match thresholds
- Leader identification correct (highest share per channel)

**Logical coherence:**
- Recommendations align with metrics (high CSF → consider price increase)
- Narratives consistent with categories (low CSF → "vulnerable position")
- Competitive insights match data (leader vs follower positioning)

### Step 4a: Compare against ground truth (ground truth mode only)

If requirements.md exists, perform semantic comparison:

**Requirements coverage:**
- Check each requirement from requirements.md against outline
- Identify missing insights or recommendations
- Flag semantic gaps or weaker narratives

**Semantic alignment:**
- Compare market health assessments
- Compare per-brand insights
- Compare competitive dynamics observations
- Compare recommendations and rationale

**Gap analysis:**
- High priority: Missing critical insights that affect recommendations
- Medium priority: Weaker narratives or incomplete analysis
- Low priority: Minor differences in phrasing or emphasis

### Step 4b: Generate evaluation report

Create unified evaluation report using `templates/evaluation.md`:

**Always include:**
- Section 1: Completeness checks
- Section 2: Internal consistency

**Include if ground truth available:**
- Section 3: Ground truth comparison

**Report structure:**
```markdown
# Evaluation: [Test case name]

Date: YYYY-MM-DD
Evaluation mode: [Ground truth comparison / Self-evaluation]

## Section 1: Completeness checks
[Results with checkboxes and details]

## Section 2: Internal consistency
[Validation results with issues table]

## Section 3: Ground truth comparison
*Only if requirements.md exists*
[Requirements coverage and semantic alignment]

## Overall assessment
- Quality score: [X/10]
- Ready for production: [Yes / No / Almost]
- Key blocker: [If any]
- Next steps: [What needs fixing]
```

### Step 5: Report results

Save evaluation to project directory (same location as presentation-outline.md) and report:

**Ground truth mode:**
- Requirements extraction status (if performed)
- Quality score (X/10)
- Number of issues by priority
- Semantic gaps identified
- Next steps to improve

**Self-evaluation mode:**
- Completeness status (pass/fail)
- Consistency status (pass/fail)
- Quality score (X/10 based on completeness + consistency)
- Issues found (if any)
- Recommendation: Ready for human review / needs fixes

## Evaluation criteria

### Completeness scoring
- All channels covered: 20 points
- All brands analyzed: 20 points
- All required sections present: 20 points
- Recommendations included: 20 points
- Business context acknowledged: 20 points

**Total: 100 points → Scale to /10**

### Consistency scoring
- Numerical accuracy (CSV match): 30 points
- Categorical accuracy (thresholds): 30 points
- Logical coherence (metrics ↔ recommendations): 40 points

**Total: 100 points → Scale to /10**

### Ground truth scoring
- Requirements coverage: 40 points
- Semantic alignment: 40 points
- No high-priority gaps: 20 points

**Total: 100 points → Scale to /10**

**Final quality score:**
- Ground truth mode: Average of all three scores
- Self-evaluation mode: Average of completeness + consistency

## Usage examples

### Example 1: Ground truth comparison

**User:** "Evaluate tests/us_spoonables/outputs/"

**Skill actions:**
1. Scan directory: finds presentation.md, presentation-outline.md, 6.Brand_Level_Results.csv
2. Read presentation.md and extract requirements → write requirements.md
3. Read presentation-outline.md
4. Read 6.Brand_Level_Results.csv
5. Validate completeness and consistency (Sections 1-2)
6. Compare against requirements (Section 3)
7. Write evaluation.md with all 3 sections
8. Report quality score and gaps

### Example 2: Self-evaluation

**User:** "Validate tests/uk_bbq/outputs/"

**Skill actions:**
1. Scan directory: finds presentation-outline.md, 6.Brand_Level_Results.csv (no presentation.md or requirements.md)
2. Detect self-evaluation mode
3. Read presentation-outline.md
4. Read 6.Brand_Level_Results.csv
5. Validate completeness (Section 1)
6. Validate consistency (Section 2)
7. Write evaluation.md with 2 sections
8. Report quality score and readiness

### Example 3: Use existing requirements

**User:** "Evaluate tests/us_spoonables/outputs/"

**Skill actions:**
1. Scan directory: finds presentation-outline.md, 6.Brand_Level_Results.csv, requirements.md (no presentation.md)
2. Read existing requirements.md (no extraction needed)
3. Read presentation-outline.md
4. Read 6.Brand_Level_Results.csv
5. Perform all validations (Sections 1-3)
6. Write evaluation.md
7. Report results

## Important notes

**Mode detection:**
- Scan directory for presentation.md or requirements.md to determine mode
- Extract requirements only once (don't overwrite existing)
- Can evaluate without ground truth (self-evaluation mode)

**Requirements extraction:**
- presentation.md should be pre-converted by the orchestrator using pptx-to-markdown skill
- Focus on semantic content, not formatting
- Capture what insights were communicated, not how
- Include strategic recommendations with rationale
- Note critical analyses that must be replicated

**Evaluation focus:**
- Completeness: Are all necessary elements present?
- Consistency: Do numbers and categories match source data?
- Semantic alignment: Are the same insights communicated? (ground truth only)

**Quality scoring:**
- Be objective about gaps
- High priority = missing critical insight affecting recommendations
- Medium priority = weaker narrative or incomplete analysis
- Low priority = minor phrasing differences

**Test case development:**
- Start with self-evaluation for new projects
- After human finalizes PPT, extract requirements to create test case
- Use test cases for regression testing after skill improvements

## Troubleshooting

**Missing requirements despite presentation.md:**
- Verify presentation.md exists in the evaluated directory
- Check file content is properly formatted markdown
- Verify presentation.md was generated by pptx-to-markdown skill

**False consistency errors:**
- Check if thresholds in validation match client rules
- Verify CSV data is clean (no NaN/null in key fields)
- Review edge cases near category boundaries

**Incomplete evaluation:**
- Ensure all input files are present (CSV, outline)
- Verify file paths use tests/ directory structure
- Check that outline follows expected format

## Next steps after evaluation

**If issues found:**
1. Review evaluation.md for specific gaps
2. Update `csf-presentation` skill logic if needed
3. Regenerate outline with improved skill
4. Re-evaluate until quality score acceptable

**If evaluation passes:**
1. Proceed with human review
2. Create PowerPoint from outline
3. After finalization, extract requirements to create test case (if not already done)

## References

**Related skills:**
- `csf-presentation` - Generate presentation outlines from CSV data (what this skill evaluates)

**Orchestrator dependencies:**
- `pptx-to-markdown` - Used by orchestrator to convert PowerPoint to presentation.md before evaluation

**Templates:**
- `templates/requirements.md` - Structure for requirements extraction
- `templates/evaluation.md` - Unified evaluation report structure
