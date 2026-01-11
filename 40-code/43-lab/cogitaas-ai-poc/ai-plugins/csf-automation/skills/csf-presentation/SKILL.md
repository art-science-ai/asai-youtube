---
name: csf-presentation
description: This skill should be used when the user asks to "create CSF presentation", "interpret CSF results", "generate CSF presentation outline", or mentions creating presentations from Brand-Level Results CSV. Automates the complete CSF presentation workflow from CSV interpretation to presentation outline generation.
---

# CSF Presentation Generation Skill

## Overview

This skill automates Consumer Surplus Factor (CSF) presentation generation by transforming Brand-Level Results CSV files into presentation-ready content. It handles the complete workflow from data interpretation through presentation outline generation.

Use this skill when:
- Converting Stage 6 Brand-Level Results CSV into presentation content
- Creating CSF analysis presentations for stakeholders
- Generating structured presentation outlines from quantitative results
- Applying standardized CSF interpretation rules

## What This Skill Does

The skill implements a two-phase workflow:

**Phase 1: Data Interpretation**
- Reads Brand-Level Results CSV from Stage 6
- Applies CSF, Price Elasticity, and MSP categorization rules
- Identifies market leaders and competitive positions
- Outputs enhanced CSV with interpretation categories

**Phase 2: Presentation Outline Generation**
- Reads enhanced CSV data
- Generates slide-by-slide presentation outline
- Creates data-driven narratives following client standards
- Outputs structured markdown presentation plan

## Process

### Step 1: Understand user request and locate files

When invoked, identify:

**Required inputs:**
- Brand-Level Results CSV (usually named `6.Brand_Level_Results.csv`)
- Project name and market context (from directory structure or user)

**Optional inputs:**
- Output directory for enhanced CSV and outline
- Specific channels or brands to focus on

**Example requests:**
- "Create presentation for UK Brown Sauce results"
- "Generate CSF presentation outline from 6.Brand_Level_Results.csv"
- "Interpret the brand-level results and create presentation plan"

### Step 2: Generate enhanced CSV

Run the interpretation script to add categorization columns:

```bash
./scripts/enhance_results.py \
  6.Brand_Level_Results.csv \
  6.Brand_Level_Results_Enhanced.csv \
  --project-name "UK Brown Sauce"
```

**Script adds these columns:**
- `CSF_Category` - high/medium/low based on thresholds
- `PE_Category` - less_elastic/moderately_elastic/highly_elastic
- `MSP_Category` - positive/stable/negative
- `IsLeader` - true/false (highest market share in channel)
- `Competitive_Position` - higher_than_avg/equal_to_avg/lower_than_avg

**Categorization rules (from client's Summary.docx):**

**CSF Thresholds:**
- High: CSF ≥ 2.0
- Medium: 1.7 ≤ CSF < 2.0
- Low: CSF < 1.7

**Price Elasticity Thresholds (at 5% price change):**
- Less elastic: PE ≥ -4
- Moderately elastic: -7 ≤ PE < -4
- Highly elastic: PE < -7

**Market Share Potential:**
- Positive: MSP > 0.001
- Stable: -0.001 ≤ MSP ≤ 0.001
- Negative: MSP < -0.001

**Market Leader:**
- Highest MShare within each channel
- Only one leader per channel

**Competitive Position:**
- Compare brand's CSF to average of top 3 competitors in channel
- Higher: CSF > avg + 0.1
- Lower: CSF < avg - 0.1
- Equal: otherwise

### Step 3: Generate presentation outline

Read the enhanced CSV and create a structured presentation outline in markdown.

**Standard presentation structure:**

```markdown
# Presentation Outline: [Project Name]

## Metadata
- Project: [Project name]
- Market: [Market identifier]
- Channels: [List of channels]
- Brands analyzed: [List of brands]
- Date: [Current date]

## Slide 1: Title
- Consumer Surplus Factor (CSF) Study
- [Market]: [Category]
- [Month Year]

## Slide 2: Executive Summary

### Overall Market
[Synthesize overall CSF health across channels]
[Note channels with strong vs weak CSF]

### [Brand 1] (Market Leader, [X]% share)
- CSF: [value] ([category]) - [interpretation]
- Price elasticity: [value] ([category])
- Market share trend: [gaining/stable/losing] ([MSP value])
- Recommendation: [pricing action]

### [Brand 2] (Challenger, [X]% share)
[Similar structure]

### Competition
[Key competitive dynamics]
[Private label observations]

### Key Recommendations
1. [Top priority action]
2. [Second priority action]
3. [Third priority action]

## Slide 3: Market Context

[Channel 1]
- Change in Value: [YoY %]
- Change in Volume: [YoY %]
- Change in Price: [YoY %]
- Key observations: [2-3 bullet points]

[Repeat for each channel]

## Slide 4-5: CSF & MCV Analysis

[Tables showing CSF, MCV, Price by brand and channel]
[Trend analysis if data available]

## Slides 6+: Detailed Findings

[Per-channel deep dives]
[PPG-level analysis if applicable]
[Variant analysis if applicable]

## Final Slide: Recommendations

[Detailed recommendations with:]
- Priority level (1, 2, 3)
- Specific action (price increase/decrease/hold %)
- Expected impact (revenue, volume, share)
- Timeline
- Risk considerations
```

**Narrative generation guidelines:**

**For Executive Summary:**
- Lead with overall market health assessment
- Summarize each major brand (3-5 key points)
- Highlight competitive dynamics
- Provide clear, actionable recommendations

**For Brand Insights:**
Synthesize multiple metrics:
- High CSF + Less elastic + Positive MSP → "Strong pricing power, can consider price increases"
- Low CSF + Highly elastic + Negative MSP → "Vulnerable position, needs marketing support"
- High CSF + Market leader → "Protected position, focus on maintaining loyalty"
- Low CSF + Market follower → "High competitive pressure, differentiation required"

**Interpretation templates (from client rules):**

**CSF Insights:**
- High: "Strong customer loyalty, low switching risk, protected from competitive pressure"
- Medium: "Moderate loyalty, some switching risk, performance depends on pricing and promotions"
- Low: "Weak loyalty, high switching risk, vulnerable to price changes and competitive actions"

**Price Elasticity Insights:**
- Less elastic: "Low price sensitivity, price increases likely absorbed, limited volume loss expected"
- Moderately elastic: "Customers respond noticeably to price changes, pricing actions should be cautious"
- Highly elastic: "Very price sensitive, small price increases may lead to significant volume loss"

**MSP Insights:**
- Positive: "Brand gaining market share, indicates improving competitiveness"
- Stable: "Market share stable, brand maintaining position"
- Negative: "Brand losing market share, indicates competitive pressure"

**Market Position:**
- Leader: "Dominant player, customers prefer this brand, competitive pressure low"
- Follower: "Not market leader, customers spread across brands, competitive pressure higher"

**Competitive Position:**
- Higher than competition: "CSF advantage over competitors, switching threat low"
- Equal to competition: "Neutral position, outcomes driven by price and promotions"
- Lower than competition: "CSF disadvantage, switching threat exists even if CSF is high"

### Step 4: Output presentation outline

Save the generated outline as markdown:
- Filename: `presentation-outline.md`
- Location: Same directory as input CSV or specified output path
- Format: Clean markdown with clear heading hierarchy

Report to user:
- Number of channels and brands covered
- Total slides in outline
- Key recommendations identified
- Next steps (human review, PowerPoint creation)

## Scripts

**enhance_results.py** - CSV enhancement script
- Location: `scripts/enhance_results.py`
- Self-contained with uv inline metadata
- Handles all deterministic categorizations

## Workflow Summary

```
Input: 6.Brand_Level_Results.csv
  ↓
Phase 1: Run enhance_results.py
  ↓
Output: 6.Brand_Level_Results_Enhanced.csv
  ↓
Phase 2: LLM generates outline from enhanced CSV
  ↓
Output: presentation-outline.md
  ↓
Human: Creates PowerPoint from outline
```

## Client Interpretation Rules Reference

From `parsed_data/Summary.docx/` - these are the authoritative rules:

**CSF (Consumer Surplus Factor)**
- Measures gap between consumer willingness to pay and actual price
- Formula: CSF = MCV / Current Price
- Indicates pricing power and customer loyalty

**Price Elasticity (PE)**
- Sensitivity of demand to 5% price change
- Negative values expected (higher price → lower volume)
- Magnitude indicates price sensitivity

**Market Share Potential (MSP)**
- Difference between NewMShare and MShare
- Indicates future trajectory
- Positive = gaining, Negative = losing share

**MCV (Maximum Consumer Value)**
- Highest price loyal customers will pay
- Varies by brand strength and differentiation

## Examples

Working example in `examples/uk_brownsauce/`:
- `6.Brand_Level_Results.csv` - Stage 6 output (input to workflow)
- `6.Brand_Level_Results_Enhanced.csv` - After Phase 1 (script adds 5 columns)
- `presentation-outline.md` - After Phase 2 (LLM generates slide structure)

Real client examples in project `runs/`:
- `runs/uk_brownsauce/` - Complete example with final presentation
- `runs/ukbbq_20250111/` - Recent project with Brand-Level Results

## Important Notes

**Data quality:**
- Verify CSV has required columns before processing
- Check for missing values in key fields (CSF, PE, MSP, MShare)
- Validate that Channel and Brand columns are populated

**Scope handling:**
- Brand-level analysis: Variant = "all", PPG = "all"
- Variant-level: PPG = "all", Variant varies
- PPG-level: Both Variant and PPG vary

**Channel-specific analysis:**
- Always group by channel first
- Market leader determined per channel
- Competitive comparisons within channel only

**Presentation customization:**
- Adjust slide count based on scope
- Simple projects: 15-20 slides
- Complex projects: 25-40 slides
- PPG-level: May need 40+ slides

## Troubleshooting

**CSV parsing errors:**
- Verify required columns exist
- Check for proper CSV formatting
- Ensure numeric fields are valid numbers

**Missing categorizations:**
- Check threshold values match client rules
- Verify data is not missing (NaN/null)
- Review thresholds for edge cases near boundaries

**Incomplete outline:**
- Ensure all channels in CSV are represented
- Check that brand data is complete
- Verify market share totals make sense

## Next Steps After Outline Generation

1. Review outline for accuracy and completeness
2. Validate recommendations align with business context
3. Create PowerPoint presentation using outline as guide
4. Generate charts and tables from enhanced CSV
5. Add visual elements and formatting
6. Review with stakeholders

## References

**Client methodology (authoritative sources):**
- `parsed_data/Summary.docx/` - CSF interpretation rules and thresholds
- `parsed_data/CSF_ReadMe.docx/` - Complete CSF methodology documentation

**Real client examples:**
- `runs/uk_brownsauce/` - Complete example with presentation
- `runs/ukbbq_20250111/` - Recent example with Brand-Level Results
- Use actual client presentations as templates for slide design and formatting
