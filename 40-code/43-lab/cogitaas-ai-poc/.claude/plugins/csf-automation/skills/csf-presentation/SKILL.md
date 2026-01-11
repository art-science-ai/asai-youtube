---
name: interpret-results
description: This skill should be used when the user asks to "interpret CSF results", "analyze brand-level results", "generate stage 7a interpretation", "create interpretation YAML", "interpret the results CSV", or mentions CSF Stage 7a. Automates interpretation of Brand-Level Results CSV files by applying CSF, price elasticity, and MSP categorization rules to generate structured YAML insights.
---

# CSF Stage 7a: Interpretation of Results

## Overview

This skill automates the interpretation of quantitative CSF analysis results by transforming Brand-Level Results CSV files into structured YAML interpretations with strategic insights. The skill applies deterministic categorization rules for CSF (Consumer Surplus Factor), Price Elasticity (PE), and Market Share Potential (MSP), then guides Claude to enhance interpretations with business context.

Use this skill when:
- Converting Stage 6 Brand-Level Results CSV into interpretation YAML
- Generating structured insights for CSF presentation development
- Applying standardized interpretation rules across multiple brands/channels
- Preparing data-driven narratives for stakeholder presentations

## Scripts

The skill provides a ready-to-use interpretation script in the `scripts/` directory:

- **interpret_results.py** - Main interpretation script that reads CSV, applies categorization rules, and generates YAML

The script is self-contained with inline uv metadata and handles all deterministic components of the interpretation process.

## Process

### Step 1: Understand user request

When invoked, parse the natural language request to extract parameters:

**Required:**
- **Input CSV file**: Look for paths to results CSV files (e.g., "6.Brand_Level_Results.csv", "Brand_Level_Results.csv")

**Optional:**
- **Output YAML path**: Look for "output to", "save to". If not specified, default to `interpretation.yaml`
- **Project metadata**: Extract project name, market, categories from context or conversation history
- **Level of analysis**: If not specified, script will auto-infer from data

**Example parsing:**
- "Interpret 6.Brand_Level_Results.csv" → input=6.Brand_Level_Results.csv, output=interpretation.yaml
- "Generate interpretation for UK BBQ results" → input=(search for results file), project="UK BBQ", market="uk"
- "Create stage 7a YAML from results.csv" → input=results.csv, output=interpretation.yaml

### Step 2: Understand project structure

Explore the project to understand CSF workflow context:
- Identify Stage 6 outputs (Brand-Level Results CSV files)
- Look for existing interpretation files
- Understand project naming conventions
- Identify market and category context from directory structure or file names

**Note:** Some projects have multiple result files (Brand_Level, Brand_Variant_Level, Brand_Variant_PPG_Level). Process the appropriate file based on user request.

### Step 3: Copy scripts to project

Copy interpretation scripts to the project directory:
- Check if `scripts/` directory exists (create if needed)
- Copy `interpret_results.py` from skill's scripts/ to project's scripts/
- Make script executable with `chmod +x`

**Script copied:**
- `interpret_results.py` - Main interpretation script

### Step 4: Execute interpretation script

Run the script with appropriate parameters:

```bash
./scripts/interpret_results.py \
  input_csv_file.csv \
  output_yaml_file.yaml \
  --project-name "UK BBQ" \
  --market "uk" \
  --categories "bbq sauce,salad cream"
```

**Script behavior:**
- Reads Brand-Level Results CSV
- Extracts unique channels and brands
- Infers level of analysis (brand/variant/ppg) if not specified
- Applies CSF categorization rules (high ≥2.0, medium 1.7-1.9, low <1.6)
- Applies PE categorization rules (less elastic ≥-4, moderately elastic -5 to -7, highly elastic <-8)
- Applies MSP categorization rules (positive >0.001, stable ±0.001, negative <-0.001)
- Determines market position (leader/follower based on market share)
- Generates competitive comparisons (CSF differences vs competitors)
- Outputs structured YAML with standard interpretation templates

**Deterministic components handled by script:**
- Metric extraction (CSF, PE, MCV, MSP, market share, revenue, volume)
- Categorization (applying thresholds to classify metrics)
- Competitive comparisons (quantitative CSF differences)
- Market position determination (leader vs follower)
- Standard interpretation text (template-based insights)

**Non-deterministic components (Claude handles in Step 5):**
- Enhanced `overall_assessment` with business context
- Strategic recommendations based on metric combinations
- Market-specific insights and edge case explanations
- Project metadata completion (if not provided)

### Step 5: Review and enhance interpretations

**Two-Output Workflow:**

The interpretation process generates two YAML files:
- **Output 1** (script-generated): Contains all deterministic fields with `[Claude: Provide ...]` placeholders for non-deterministic assessments
- **Output 2** (Claude-enhanced): Complete interpretation with strategic assessments added

Read Output 1 (script-generated YAML) and create Output 2 with enhancements:

**Review checklist:**
- Verify all brands and channels are covered
- Check categorizations match the data (CSF high/medium/low correct)
- Validate competitive comparisons are accurate
- Ensure market position determinations are logical

**Enhancement tasks (creating Output 2):**
- **Complete project metadata**: Fill in `[Claude: Provide ...]` placeholders with actual values
- **Enhance overall_assessment**: Replace placeholder text with strategic insights that synthesize CSF, PE, and MSP findings
- **Add strategic recommendations**: Based on metric combinations, suggest pricing actions (increase/hold/decrease)
- **Flag unusual patterns**: Identify and explain edge cases (e.g., high CSF but low market share, negative MSP despite high CSF)
- **Mark non-deterministic fields**: Add comments in Output 2 to clearly identify which fields were enhanced by Claude

**Strategic synthesis examples:**
- High CSF + Less elastic PE + Positive MSP → "Strong pricing power, can consider price increase of ~5-8%"
- Low CSF + Highly elastic PE + Negative MSP → "Vulnerable position, needs marketing investment or value improvement"
- High CSF + Market leader → "Protected position, focus on maintaining loyalty"
- Low CSF + Market follower → "High competitive pressure, differentiation required"

**Standard interpretation templates** (generated by script):

- **CSF Insights**:
  - High: "Strong customer loyalty, low switching risk, protected from competitive pressure"
  - Medium: "Moderate loyalty, some switching risk exists, performance depends on pricing and promotions"
  - Low: "Weak loyalty, high switching risk, vulnerable to price changes and competitive actions"

- **Price Elasticity Insights**:
  - Less elastic: "Low price sensitivity, price increases likely absorbed, limited volume loss expected"
  - Moderately elastic: "Customers respond noticeably to price changes, pricing actions should be taken with caution"
  - Highly elastic: "Very price sensitive, small price increases may lead to significant volume loss"

- **MSP Insights**:
  - Positive: "Brand is gaining market share, indicates improving competitiveness"
  - Stable: "Market share is stable, brand maintaining its position"
  - Negative: "Brand is losing market share, indicates competitive pressure"

### Step 6: Verify results

Check the final YAML interpretation and report to user:

**Verification checklist:**
- [ ] All brands and channels in CSV are represented in YAML
- [ ] CSF categorizations match thresholds (verify spot checks)
- [ ] Competitive comparisons show correct CSF differences
- [ ] Market position (leader/follower) aligns with market share data
- [ ] Project metadata is complete (no [Claude: ...] placeholders remaining)
- [ ] Overall assessments provide actionable strategic insights
- [ ] Interpretation text is business-friendly and clear

**Success indicators:**
- YAML file is well-structured and readable
- All metric fields are populated with correct values
- Categorizations follow the defined thresholds
- Competitive position narratives are accurate
- Strategic assessments synthesize multiple metrics
- No placeholder text remains (all filled with real insights)

**Report to user:**
- Number of channels and brands processed
- Level of analysis identified
- Any edge cases or unusual patterns flagged
- Next steps for using interpretation in Stage 7b (presentation planning)

## Guidelines

### Interpretation enhancement principles

When enhancing script-generated interpretations:

- **Synthesize metrics**: Combine CSF, PE, and MSP insights into cohesive strategic assessments
- **Add business context**: Consider market dynamics, competitive landscape, brand positioning
- **Be specific**: Replace generic template text with concrete recommendations
- **Flag anomalies**: Identify and explain unusual metric combinations
- **Maintain objectivity**: Base assessments on data, not assumptions

### YAML structure

The script generates YAML with this structure:

```yaml
project:
  name: [Project name]
  market: [Market identifier]
  categories: [List of categories]
  level_of_analysis: [brand_level, brand_variant_level, or brand_variant_ppg_level]
  channels: [List of channel names]

channels:
  - channel_name: [Channel]
    brands:
      - brand: [Brand name]
        metrics:
          csf: [CSF value]
          csf_category: [high/medium/low]
          price_elasticity: [PE value]
          pe_category: [less_elastic/moderately_elastic/highly_elastic]
          market_share: [Current market share]
          new_market_share: [Projected market share]
          msp: [MSP value]
          msp_category: [positive/stable/negative]
          mcv: [Maximum Consumer Value]
          price: [Current price]
          revenue: [Revenue]
          volume: [Volume]
        competition:
          - competitor: [Competitor brand]
            csf: [Competitor CSF]
            csf_difference: [Difference]
            csf_comparison: [higher_than/equal_to/lower_than_competition]
            market_share: [Competitor market share]
        market_share_position:
          is_leader: [true/false]
          position: [leader/follower]
          competitive_pressure: [low/high]
          share_vs_competition: [highest/lower]
        interpretation:
          csf_insight: [CSF interpretation text]
          pe_insight: [PE interpretation text]
          msp_insight: [MSP interpretation text]
          market_share_position: [Position interpretation]
          competitive_position: [Competitive narrative]
          overall_assessment: [Strategic synthesis]
```

### Level of analysis inference

The script automatically infers the level of analysis:

- **Brand Level**: All rows have `Variant = "all"` AND `PPG = "all"`
- **Brand Variant Level**: All rows have `PPG = "all"` but `Variant` varies
- **Brand Variant PPG Level**: Both `Variant` and `PPG` vary

Can be overridden with `--level` flag if inference is incorrect.

### Handling multiple result files

Some projects have multiple result files at different levels:
- `6.Brand_Level_Results.csv`
- `7.Brand_Variant_Level_Results.csv`
- `8.Brand_Variant_PPG_Level_Results.csv`

Process the appropriate file based on user request or run multiple times to generate interpretations for each level.

## Examples

Working examples in `examples/`:
- **`examples/uk_bbq/`** - Complete brand-level analysis example showing both script output (output-1.yaml) and Claude-enhanced output (output-2.yaml)

## Troubleshooting

### Script execution issues

```bash
# Fix permissions
chmod +x scripts/interpret_results.py

# Verify Python version
python --version  # Must be >=3.11

# Test with help flag
./scripts/interpret_results.py --help
```

### CSV parsing errors

If the script fails to read CSV:
- Verify CSV has required columns (Market, Channel, Brand, CSF, Price_elas, MShare, NewMShare, MSP, MCV, Price, Revenue, Volume)
- Check for proper CSV formatting (commas, quotes)
- Try opening CSV in spreadsheet software to validate structure

### Missing or incorrect categorizations

If categorizations seem wrong:
- Verify threshold values in script match the rules defined in SKILL.md (CSF: high ≥2.0, medium 1.7-2.0, low <1.7; PE: less elastic ≥-4, moderately elastic -4 to -8, highly elastic <-8)
- Check for data quality issues (NaN, null values)
- Review the uk_bbq example for expected behavior

### Incomplete YAML output

If generated YAML is missing fields:
- Check that CSV contains all required columns
- Verify no data is being filtered out unexpectedly
- Review script output for error messages

## Next Steps

After generating interpretations:

1. Use interpretation YAML as input to Stage 7b (presentation planning)
2. Share YAML with stakeholders for validation
3. Iterate on overall_assessment fields based on business feedback
4. Incorporate interpretations into final presentation narratives
