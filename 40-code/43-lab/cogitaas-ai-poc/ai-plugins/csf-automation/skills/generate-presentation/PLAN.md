# Generate Presentation Skill - Implementation Plan

## Executive Summary

The skill currently assumes single-file brand-level analysis only. Real CSF projects have hierarchical result structures with up to 4 granularity levels. This plan updates the skill to discover, process, and synthesize multiple result files into comprehensive hierarchical presentations.

## Problem Statement

### Current State
- Hardcoded to process only `6.Brand_Level_Results.csv`
- Single-file workflow
- No awareness of variant-level or PPG-level analyses
- Presentation structure assumes brand-only granularity

### Real-World CSF Project Patterns

From analysis of actual client deliverables:

**Pattern 1: Brand-only (UK BBQ)**
```
6.Brand_Level_Results.csv                    (Brand aggregation)
```

**Pattern 2: Brand + PPG (UK BrownSauce)**
```
6.Brand_Level_Results.csv                    (Brand aggregation)
7.Brand_PPG_Level_Results.csv                (Brand × Pack Size)
```

**Pattern 3: Brand + Variant + Variant×PPG (US Spoonables)**
```
6.Brand_Level_Results.csv                    (Brand aggregation)
7.Brand_Variant_Level_Results.csv            (Brand × Variant)
8.Brand_Variant_PPG_Level_Results.csv        (Brand × Variant × Pack Size)
```

### Key Insight

These are NOT mutually exclusive alternatives - they are **hierarchical layers** that coexist. A presentation should synthesize ALL available layers using progressive disclosure: executive summary from brand-level, then drill into variants/pack sizes where available.

Think of it as a zoom lens: Brand (wide angle) → Variant/PPG (medium zoom) → Variant×PPG (macro detail).

## Proposed Solution

### Architecture Overview

**Multi-file hierarchical workflow:**

```
Step 1: Discovery Phase
  ↓
  Scan input directory for *_Results.csv files
  Identify available granularity levels
  Detect project complexity pattern

Step 2: Enhancement Phase
  ↓
  Process each discovered file independently
  6.Brand_Level_Results.csv → 6.Brand_Level_Results_Enhanced.csv
  7.*_Level_Results.csv     → 7.*_Level_Results_Enhanced.csv
  8.*_Level_Results.csv     → 8.*_Level_Results_Enhanced.csv

Step 3: Synthesis Phase
  ↓
  Read all enhanced CSVs
  Build hierarchical data structure
  Generate single comprehensive presentation outline
  Adapt structure based on available granularities
```

## Detailed Changes

### Change 1: Multi-file Discovery

**Update SKILL.md Step 1:**

```markdown
### Step 1: Discover inputs and detect project complexity

When invoked, identify:

**Required inputs:**
- Input directory containing Result CSV files
- Output directory where enhanced CSVs and presentation outline will be written
- Project name and market context (from user or inferred)

**File discovery patterns:**
Scan input directory for files matching these patterns:
- `6.Brand_Level_Results.csv` (always required)
- `7.Brand_PPG_Level_Results.csv` (optional)
- `7.Brand_Variant_Level_Results.csv` (optional)
- `8.Brand_Variant_PPG_Level_Results.csv` (optional)

**Granularity detection:**
Identify which dimensions exist:
- Brand-only: Only file 6 present
- Brand + PPG: Files 6 and 7 (PPG variant) present
- Brand + Variant: Files 6 and 7 (Variant variant) present
- Brand + Variant + PPG: Files 6, 7, and 8 present

**Column-based validation:**
After reading each CSV, validate granularity by checking columns:
- Brand-level: Variant="all", PPG="all" (or columns absent)
- PPG-level: PPG varies, Variant="all"
- Variant-level: Variant varies, PPG="all"
- Variant×PPG-level: Both Variant and PPG vary

Report to user:
- Files discovered
- Project complexity pattern detected
- Expected presentation structure
```

### Change 2: Column-Flexible Enhancement Script

**Update `enhance_results.py`:**

Make the script granularity-agnostic by:

**Required columns (always present):**
```python
REQUIRED_COLS = ['Channel', 'Brand', 'CSF', 'Price_elas', 'MShare', 'MSP']
```

**Optional columns (granularity-specific):**
```python
OPTIONAL_COLS = ['Variant', 'PPG', 'PackType']
```

**Leader identification logic:**
```python
def identify_leaders(df):
    """
    Identify market leader at appropriate granularity.

    Grouping logic:
    - Brand-level: Group by Channel
    - PPG-level: Group by Channel + PPG
    - Variant-level: Group by Channel + Variant
    - Variant×PPG-level: Group by Channel + Variant + PPG
    """
    # Detect grouping dimensions
    group_dims = ['Channel']
    if 'Variant' in df.columns and df['Variant'].nunique() > 1:
        group_dims.append('Variant')
    if 'PPG' in df.columns and df['PPG'].nunique() > 1:
        group_dims.append('PPG')

    # Identify leader within each group
    is_leader = []
    for group_values, group_df in df.groupby(group_dims):
        max_share = group_df['MShare'].max()
        for idx in group_df.index:
            is_leader.append(df.loc[idx, 'MShare'] == max_share)

    return is_leader
```

**Competitive position logic:**
```python
def calculate_competitive_position(df):
    """
    Compare brand's CSF to top 3 competitors at same granularity.
    """
    # Same grouping logic as leader identification
    # Compare within: Channel (+ Variant if present) (+ PPG if present)
```

### Change 3: Hierarchical Presentation Generation

**Update SKILL.md Step 3:**

```markdown
### Step 3: Generate hierarchical presentation outline

Read all enhanced CSV files and generate a single comprehensive outline using progressive disclosure.

**Standard structure (all projects):**

1. Title Slide
2. Executive Summary (from Brand-level data)
   - Overall market health
   - Key brand insights
   - Top 3 recommendations
3. Market Context (from Brand-level data)
   - Channel performance metrics
   - Year-over-year trends
4. Brand-Level Analysis (from file 6 - always)
   - CSF & MCV tables by brand and channel
   - Price elasticity overview
   - Market share trends

**Conditional deep-dive sections (based on available data):**

5. Variant Analysis (if file 7 Brand_Variant exists)
   - Slide per brand showing variant performance
   - Which variants drive/drag CSF?
   - Variant-specific recommendations
   - Expected slides: +10 slides

6. Pack Size Analysis (if file 7 Brand_PPG exists)
   - Slide per brand showing PPG performance
   - Price-pack architecture insights
   - Optimal pack sizes by channel
   - Pack-specific recommendations
   - Expected slides: +10-15 slides

7. Granular Analysis (if file 8 Brand_Variant_PPG exists)
   - Variant×PPG combination performance
   - Optimal price-pack configurations
   - SKU-level tactical recommendations
   - Expected slides: +10-15 slides

8. Synthesis & Recommendations (always)
   - Roll-up insights from all levels
   - Prioritized action plan with specificity matched to granularity
   - Timeline and risk considerations

**Narrative generation principles:**

- Executive Summary: Strategic, brand-level only (even if granular data exists)
- Deep Dives: Progressively more detailed, tactical recommendations
- Synthesis: Bridge strategic to tactical based on hierarchy depth

**Slide count estimation:**
- Brand-only (Pattern 1): 15-20 slides
- Brand + one dimension (Pattern 2): 25-35 slides
- Brand + two dimensions (Pattern 3): 35-50 slides
```

### Change 4: Multi-File Processing in Step 2

**Update SKILL.md Step 2:**

```markdown
### Step 2: Generate enhanced CSV files

Process each discovered Result file independently:

**For each Result CSV found:**

```bash
./ai-plugins/csf-automation/skills/generate-presentation/scripts/enhance_results.py \
  {input_dir}/{filename}.csv \
  {output_dir}/{filename}_Enhanced.csv \
  --project-name "{project_name}"
```

**Example for US Spoonables (Pattern 3):**
```bash
# Enhance brand-level
./scripts/enhance_results.py \
  inputs/6.Brand_Level_Results.csv \
  outputs/6.Brand_Level_Results_Enhanced.csv \
  --project-name "US Spoonables"

# Enhance variant-level
./scripts/enhance_results.py \
  inputs/7.Brand_Variant_Level_Results.csv \
  outputs/7.Brand_Variant_Level_Results_Enhanced.csv \
  --project-name "US Spoonables"

# Enhance variant×PPG-level
./scripts/enhance_results.py \
  inputs/8.Brand_Variant_PPG_Level_Results.csv \
  outputs/8.Brand_Variant_PPG_Level_Results_Enhanced.csv \
  --project-name "US Spoonables"
```

**Script outputs:**
Each enhanced CSV adds these columns (adapted to granularity):
- CSF_Category (high/medium/low)
- PE_Category (less_elastic/moderately_elastic/highly_elastic)
- MSP_Category (positive/stable/negative)
- IsLeader (true/false at appropriate grouping level)
- Competitive_Position (higher_than_avg/equal_to_avg/lower_than_avg)
```

### Change 5: Update Presentation Template

**Update `templates/presentation-outline.md`:**

Add granularity metadata:

```markdown
## Metadata
- Project: [Project name]
- Market: [Market identifier]
- Analysis scope:
  - Brand-level analysis: ✓ (6.Brand_Level_Results.csv)
  - Variant breakdown: ✓/✗ (7.Brand_Variant_Level_Results.csv)
  - PPG breakdown: ✓/✗ (7.Brand_PPG_Level_Results.csv)
  - Granular (Variant×PPG): ✓/✗ (8.Brand_Variant_PPG_Level_Results.csv)
- Channels: [List of channels]
- Brands analyzed: [List of brands]
- Expected slides: ~XX
- Date: [Current date]

*Note: Presentation structure adapts based on available granularity levels*
```

### Change 6: Simplify SKILL.md Structure

**Remove redundancy:**

Lines 114-182: Remove duplicate template structure
- Replace with: "See `templates/presentation-outline.md` for complete structure"
- Saves ~70 lines

Lines 184-223: Simplify interpretation templates
- Keep metric combination patterns
- Remove verbose explanatory text
- Reduce from ~40 lines to ~15 lines

Lines 285-309: Remove premature usage examples
- Add real examples after testing with actual data

**Keep complete context (no deduplication with evaluate-presentation):**
- ✓ Keep all categorization thresholds (lines 76-101)
- ✓ Keep complete interpretation rules
- ✓ Keep troubleshooting section
- Generator and evaluator skills must be fully self-contained

## Implementation Checklist

### Phase 1: Core Multi-File Support
- [ ] Update enhance_results.py for column flexibility
- [ ] Implement dynamic leader identification (by granularity)
- [ ] Implement dynamic competitive position (by granularity)
- [ ] Add granularity detection to script
- [ ] Test script with all three file types

### Phase 2: Skill Instructions
- [ ] Update SKILL.md Step 1 (file discovery)
- [ ] Update SKILL.md Step 2 (multi-file enhancement)
- [ ] Update SKILL.md Step 3 (hierarchical outline generation)
- [ ] Update SKILL.md with slide count estimates
- [ ] Simplify SKILL.md (remove redundancy)

### Phase 3: Templates
- [ ] Update presentation-outline.md with granularity metadata
- [ ] Add conditional section markers
- [ ] Update structure examples for each pattern

### Phase 4: Testing
- [ ] Test Pattern 1 (UK BBQ - brand only)
- [ ] Test Pattern 2 (UK BrownSauce - brand + PPG)
- [ ] Test Pattern 3 (US Spoonables - brand + variant + variant×PPG)
- [ ] Validate outline completeness for each pattern
- [ ] Verify slide count estimates

## Open Questions

### Q1: User interaction for complex projects
When multiple files exist, should we:
- **A) Auto-process all (Recommended)** - Generate comprehensive outline automatically
- B) Ask user which levels to include
- C) Offer separate outlines per granularity

**Decision: Option A** - Auto-process all. Users expect comprehensive analysis. If they only want brand-level, they can ignore deep-dive sections.

### Q2: Enhanced CSV naming
Current: `{filename}_Enhanced.csv`
Alternatives?

**Decision: Keep current naming** - Clear and consistent.

### Q3: Outline structure variation
How much should structure vary between patterns?

**Decision: Minimal variation** - Always start with executive summary and brand analysis. Add conditional sections for variant/PPG. Keep synthesis at end.

### Q4: Script execution strategy
Should enhance_results.py auto-detect granularity internally?

**Decision: Yes** - Script should be self-adapting. Claude invokes it with any Result CSV, script handles detection internally.

## Expected File Changes

```
generate-presentation/
├── SKILL.md
│   Before: 374 lines (single-file, brand-only)
│   After:  ~280 lines (multi-file, hierarchical)
│   Changes:
│     - Updated Step 1: File discovery (20 lines)
│     - Updated Step 2: Multi-file processing (30 lines)
│     - Updated Step 3: Hierarchical generation (40 lines)
│     - Removed: Duplicate template (70 lines)
│     - Simplified: Narrative guidelines (25 lines saved)
│
├── scripts/enhance_results.py
│   Before: 210 lines (brand-level only)
│   After:  ~280 lines (granularity-agnostic)
│   Changes:
│     - Column flexibility (20 lines)
│     - Dynamic leader identification (40 lines)
│     - Dynamic competitive position (30 lines)
│     - Granularity detection (20 lines)
│
└── templates/presentation-outline.md
    Before: 67 lines
    After:  ~90 lines
    Changes:
      - Granularity metadata (10 lines)
      - Conditional section markers (8 lines)
      - Pattern examples (5 lines)
```

## Success Criteria

1. **Flexibility**: Handles all three project patterns without modification
2. **Accuracy**: Categorizations correct at each granularity level
3. **Completeness**: Outlines cover all available data layers
4. **Clarity**: Users understand project complexity from metadata
5. **Maintainability**: Single codebase, no branching logic per project type

## References

**Test data locations:**
- Pattern 1 (Brand-only): `data/onedrive-data/Data_Sharing/full_examples/UK_BBQ/`
- Pattern 2 (Brand+PPG): `data/onedrive-data/Data_Sharing/full_examples/UK_BrownSauce/`
- Pattern 3 (Brand+Variant+Variant×PPG): `data/onedrive-data/Data_Sharing/full_examples/US_Spoonables/`

**Related skills:**
- evaluate-presentation: Already has CSV detection logic (for reference, but keep skills independent)
- Client methodology: `parsed_data/Summary.docx/` and `parsed_data/CSF_ReadMe.docx/`
