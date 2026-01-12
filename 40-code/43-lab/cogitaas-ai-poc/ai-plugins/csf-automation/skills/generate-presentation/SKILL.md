---
name: generate-presentation
description: This skill should be used when the user asks to "create presentation", "interpret CSF results", "generate presentation outline", or mentions creating presentations from CSF Results CSV files. Automates CSF presentation generation by discovering and processing Result files at all granularity levels (Brand, Variant, PPG) and synthesizing them into comprehensive hierarchical presentations.
---

# Generate Presentation Skill

## Overview

This skill automates Consumer Surplus Factor (CSF) presentation generation by discovering, processing, and synthesizing CSF Result files at multiple granularity levels into comprehensive hierarchical presentations. It handles data interpretation, categorization, and narrative generation across brand-level, variant-level, PPG-level, and variant×PPG-level analyses.

Use this skill when:
- Converting CSF Result CSV files into presentation content
- Creating CSF analysis presentations for stakeholders
- Generating structured presentation outlines from quantitative results
- Processing projects with multiple granularity levels (Brand, Variant, PPG)
- Applying standardized CSF interpretation rules

## What This Skill Does

The skill implements a three-phase hierarchical workflow:

**Phase 1: Discovery**
- Scans input directory for all Result CSV files
- Identifies available granularity levels (Brand, Variant, PPG, Variant×PPG)
- Detects project complexity pattern

**Phase 2: Enhancement**
- Processes each Result CSV independently
- Applies CSF, Price Elasticity, and MSP categorization rules
- Identifies market leaders at appropriate granularity
- Calculates competitive positions within correct peer groups
- Outputs enhanced CSV for each input file

**Phase 3: Synthesis**
- Reads all enhanced CSV files
- Generates single comprehensive presentation outline
- Uses progressive disclosure: strategic overview → tactical detail
- Adapts structure based on available granularity levels
- Outputs structured markdown presentation plan

## Process

### Step 1: Discover Result files and detect project complexity

When invoked, identify:

**Required inputs:**
- Input directory containing Result CSV files
- Output directory where enhanced CSVs and presentation outline will be written
- Project name and market context (from user or inferred from file/directory names)

**File discovery:**

Scan input directory for files matching these patterns:
- `6.Brand_Level_Results.csv` (always required)
- `7.Brand_PPG_Level_Results.csv` (optional)
- `7.Brand_Variant_Level_Results.csv` (optional)
- `8.Brand_Variant_PPG_Level_Results.csv` (optional)

**Project complexity patterns:**

Real CSF projects follow hierarchical structures:

**Pattern 1: Brand-only**
```
6.Brand_Level_Results.csv                    (Brand aggregation)
Expected slides: 15-20
```

**Pattern 2: Brand + PPG**
```
6.Brand_Level_Results.csv                    (Brand aggregation)
7.Brand_PPG_Level_Results.csv                (Brand × Pack Size)
Expected slides: 25-35
```

**Pattern 3: Brand + Variant + Variant×PPG**
```
6.Brand_Level_Results.csv                    (Brand aggregation)
7.Brand_Variant_Level_Results.csv            (Brand × Variant)
8.Brand_Variant_PPG_Level_Results.csv        (Brand × Variant × Pack)
Expected slides: 35-50
```

**Report to user:**
- Files discovered
- Project complexity pattern detected (Pattern 1, 2, or 3)
- Expected presentation structure and slide count

**Example requests:**
- "Create presentation from inputs/ to outputs/"
- "Generate CSF presentation outline from data/uk_brownsauce/"
- "Process Result CSVs in project/ and write to results/"

### Step 2: Generate enhanced CSV files

Process each discovered Result CSV independently using the enhancement script:

**For each Result CSV found:**

```bash
./ai-plugins/csf-automation/skills/generate-presentation/scripts/enhance_results.py \
  {input_dir}/{filename}.csv \
  {output_dir}/{filename}_Enhanced.csv \
  --project-name "{project_name}"
```

**Example for Pattern 3 project:**

```bash
# Enhance brand-level
./ai-plugins/csf-automation/skills/generate-presentation/scripts/enhance_results.py \
  inputs/6.Brand_Level_Results.csv \
  outputs/6.Brand_Level_Results_Enhanced.csv \
  --project-name "Project Name"

# Enhance variant-level
./ai-plugins/csf-automation/skills/generate-presentation/scripts/enhance_results.py \
  inputs/7.Brand_Variant_Level_Results.csv \
  outputs/7.Brand_Variant_Level_Results_Enhanced.csv \
  --project-name "Project Name"

# Enhance variant×PPG-level
./ai-plugins/csf-automation/skills/generate-presentation/scripts/enhance_results.py \
  inputs/8.Brand_Variant_PPG_Level_Results.csv \
  outputs/8.Brand_Variant_PPG_Level_Results_Enhanced.csv \
  --project-name "Project Name"
```

**Script capabilities:**

The enhancement script automatically detects granularity and adapts processing:

**Granularity detection:**
- Brand-level: No variant/PPG variation (Variant="all", PPG="all")
- Variant-level: Variant varies, PPG="all"
- PPG-level: PPG varies, Variant="all"
- Variant×PPG-level: Both Variant and PPG vary

**Leader identification:**
- Brand-level: Highest MShare per Channel
- Variant-level: Highest MShare per Channel × Variant
- PPG-level: Highest MShare per Channel × PPG
- Variant×PPG-level: Highest MShare per Channel × Variant × PPG

**Competitive position:**
- Compares brand's CSF to top 3 competitors within same granularity group
- Brand-level: Competitors in same Channel
- Variant-level: Competitors in same Channel × Variant
- PPG-level: Competitors in same Channel × PPG
- Variant×PPG-level: Competitors in same Channel × Variant × PPG

**Script outputs:**

Each enhanced CSV adds these columns:
- `CSF_Category` - high/medium/low based on thresholds
- `PE_Category` - less_elastic/moderately_elastic/highly_elastic
- `MSP_Category` - positive/stable/negative
- `IsLeader` - true/false at appropriate granularity level
- `Competitive_Position` - higher_than_avg/equal_to_avg/lower_than_avg

### Step 3: Generate hierarchical presentation outline

Read all enhanced CSV files and generate a single comprehensive outline using progressive disclosure.

**Standard structure (all projects):**

**Slides 1-4: Strategic Overview (from Brand-level data)**
1. Title Slide
   - Consumer Surplus Factor (CSF) Study
   - Market and Category
   - Date

2. Executive Summary (from file 6 only)
   - Overall market health across channels
   - Key brand insights (3-5 major brands)
   - Top 3 strategic recommendations
   - Keep high-level even if granular data exists

3. Market Context (from file 6)
   - Channel performance metrics
   - Year-over-year trends (Value, Volume, Price)
   - Key observations per channel

4. Brand-Level Analysis (from file 6)
   - CSF & MCV tables by brand and channel
   - Price elasticity overview
   - Market share trends and leaders

**Conditional Deep-Dive Sections (based on available files):**

**Slides 5+: Variant Analysis** (if file 7 Brand_Variant exists)
- Slide per major brand showing variant performance
- Which variants drive vs drag CSF?
- Variant-specific pricing recommendations
- Cross-channel variant comparisons
- Expected addition: +10 slides

**Slides 5+: Pack Size Analysis** (if file 7 Brand_PPG exists)
- Slide per major brand showing PPG performance
- Price-pack architecture insights
- Optimal pack sizes by channel
- Pack-specific recommendations
- Expected addition: +10-15 slides

**Slides X+: Granular Analysis** (if file 8 Brand_Variant_PPG exists)
- Variant×PPG combination performance
- Optimal price-pack configurations per variant
- SKU-level tactical recommendations
- Detailed tables for key combinations
- Expected addition: +10-15 slides

**Final Slides: Synthesis & Recommendations (always)**
- Roll-up insights from all analyzed levels
- Prioritized action plan with specificity matched to granularity
- Strategic recommendations (from brand-level)
- Tactical recommendations (from variant/PPG levels if available)
- Timeline and risk considerations

**Narrative generation principles:**

**Progressive disclosure:**
- Executive Summary: Strategic, brand-level only (even if granular data exists)
- Deep Dives: Progressively more detailed and tactical
- Synthesis: Bridge strategic to tactical based on hierarchy depth

**For Executive Summary:**
- Lead with overall market health assessment
- Summarize each major brand (3-5 key points)
- Highlight competitive dynamics
- Provide clear, strategic recommendations

**For Brand Insights:**

Synthesize multiple metrics:
- High CSF + Less elastic + Positive MSP → "Strong pricing power, can consider price increases"
- Low CSF + Highly elastic + Negative MSP → "Vulnerable position, needs marketing support"
- High CSF + Market leader → "Protected position, focus on maintaining loyalty"
- Low CSF + Market follower → "High competitive pressure, differentiation required"

**For Variant/PPG Deep Dives:**
- Focus on within-brand variation
- Identify drivers vs drags on overall brand CSF
- Provide specific SKU-level recommendations
- Consider channel differences

**Interpretation templates (from client rules):**

**CSF Insights:**
- High (≥2.0): "Strong customer loyalty, low switching risk, protected from competitive pressure"
- Medium (1.7-2.0): "Moderate loyalty, some switching risk, performance depends on pricing and promotions"
- Low (<1.7): "Weak loyalty, high switching risk, vulnerable to price changes and competitive actions"

**Price Elasticity Insights:**
- Less elastic (≥-4): "Low price sensitivity, price increases likely absorbed, limited volume loss expected"
- Moderately elastic (-7 to -4): "Customers respond noticeably to price changes, pricing actions should be cautious"
- Highly elastic (<-7): "Very price sensitive, small price increases may lead to significant volume loss"

**MSP Insights:**
- Positive (>0.001): "Brand gaining market share, indicates improving competitiveness"
- Stable (-0.001 to 0.001): "Market share stable, brand maintaining position"
- Negative (<-0.001): "Brand losing market share, indicates competitive pressure"

**Competitive Position:**
- Higher than competition: "CSF advantage over competitors, switching threat low"
- Equal to competition: "Neutral position, outcomes driven by price and promotions"
- Lower than competition: "CSF disadvantage, switching threat exists even if CSF is high"

### Step 4: Output presentation outline

Save the generated outline as markdown:
- Filename: `presentation-outline.md`
- Location: `{output_dir}/presentation-outline.md`
- Format: Clean markdown with clear heading hierarchy

Use `templates/presentation-outline.md` as structural reference.

Report to user:
- Number of channels and brands covered
- Granularity levels processed
- Total slides in outline
- Key recommendations identified
- Output location
- Next steps: Human review or quality validation

## Categorization Rules Reference

From client's Summary.docx - these are the authoritative thresholds:

**CSF (Consumer Surplus Factor)**
- High: CSF ≥ 2.0
- Medium: 1.7 ≤ CSF < 2.0
- Low: CSF < 1.7
- Measures gap between consumer willingness to pay and actual price
- Formula: CSF = MCV / Current Price
- Indicates pricing power and customer loyalty

**Price Elasticity (PE) at 5% price change**
- Less elastic: PE ≥ -4
- Moderately elastic: -7 ≤ PE < -4
- Highly elastic: PE < -7
- Negative values expected (higher price → lower volume)
- Magnitude indicates price sensitivity

**Market Share Potential (MSP)**
- Positive: MSP > 0.001
- Stable: -0.001 ≤ MSP ≤ 0.001
- Negative: MSP < -0.001
- Difference between NewMShare and MShare
- Indicates future trajectory

**Market Leader**
- Highest MShare within appropriate grouping:
  - Brand-level: Within each Channel
  - Variant-level: Within each Channel × Variant
  - PPG-level: Within each Channel × PPG
  - Variant×PPG-level: Within each Channel × Variant × PPG
- Multiple leaders possible in case of ties

**Competitive Position**
- Compare brand's CSF to average of top 3 competitors at same granularity
- Higher: CSF > avg + 0.1
- Lower: CSF < avg - 0.1
- Equal: otherwise

**MCV (Maximum Consumer Value)**
- Highest price loyal customers will pay
- Varies by brand strength and differentiation

## Scripts

**enhance_results.py** - CSV enhancement script
- Location: `scripts/enhance_results.py`
- Self-contained with uv inline metadata
- Granularity-agnostic (handles all levels)
- Automatic detection and adaptation
- Dynamic grouping for leader/competitive analysis

## Workflow Summary

```
Input: {input_dir}/*.Results.csv files
  ↓
Phase 1: Discover files and detect pattern
  ↓
Phase 2: For each file → Run enhance_results.py
  ↓
Output: {output_dir}/*_Enhanced.csv files
  ↓
Phase 3: Read all enhanced CSVs → LLM generates hierarchical outline
  ↓
Output: {output_dir}/presentation-outline.md
  ↓
Next: Human review or quality validation
```

## Important Notes

**Data quality:**
- Verify CSV has required columns before processing
- Check for missing values in key fields (CSF, PE, MSP, MShare)
- Validate that Channel and Brand columns are populated

**Granularity handling:**
- Script auto-detects based on column variation
- Same script handles all granularity levels
- Leader/competitive analysis adapts to detected level
- No manual specification required

**Channel-specific analysis:**
- Always include Channel in grouping
- Market leader determined per appropriate group
- Competitive comparisons within same group only

**Presentation customization:**
- Slide count scales with complexity
- Simple projects (Pattern 1): 15-20 slides
- Medium projects (Pattern 2): 25-35 slides
- Complex projects (Pattern 3): 35-50 slides

**Progressive disclosure principle:**
- Start strategic (brand-level overview)
- Add tactical detail layers (variants, pack sizes)
- Synthesize across levels in final recommendations

## Troubleshooting

**System library dependencies:**

The `enhance_results.py` script uses pandas which has C extensions. Run within nix develop environment:

```bash
nix develop --command bash -c "./scripts/enhance_results.py ..."
```

**CSV parsing errors:**
- Verify required columns exist: Channel, Brand, CSF, Price_elas, MShare, MSP
- Check for proper CSV formatting
- Ensure numeric fields are valid numbers

**Missing categorizations:**
- Check threshold values match client rules
- Verify data is not missing (NaN/null)
- Review thresholds for edge cases near boundaries

**Incorrect granularity detection:**
- Verify Variant/PPG columns exist if expected
- Check that values vary (not all "all")
- Ensure at least 2 unique values for dimension to be detected

**Incomplete outline:**
- Ensure all channels in CSV are represented
- Check that brand data is complete
- Verify market share totals make sense
- Confirm all enhanced CSVs were read

## Next Steps After Outline Generation

1. Review outline for accuracy and business context alignment
2. Validate quality (completeness, consistency, semantic correctness)
3. Create PowerPoint presentation using outline as guide
4. Generate charts and tables from enhanced CSV files
5. Add visual elements and formatting
6. Review with stakeholders

## References

**Client methodology:**
- CSF interpretation rules and thresholds from client documentation
- Complete CSF methodology from project brief or parsed documents
