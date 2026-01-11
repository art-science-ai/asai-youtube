# Stage 7b: Presentation Planning

## Purpose

Create a structured plan listing all required charts and narrative sections for the CSF results presentation.

**Input**: YAML interpretation file from Stage 7a
**Output**: Presentation plan document (markdown or YAML)
**Status**: Manual process with reference documentation

---

## Process

### Step 1: Determine Presentation Structure

**Typical Structure**: 15-30 slides

**Structure varies by**:
- Project scope (number of channels, brands, categories)
- Complexity of analysis (brand-level vs variant-level vs PPG-level)
- Client requirements (executive briefing vs detailed analysis)

**Standard slide sections**:
1. Title and agenda
2. Executive summary (2-3 slides)
3. Methodology (3-4 slides)
4. Market context (1-2 slides per channel)
5. CSF & MCV learnings (1-2 slides per category)
6. RPI curves (1-2 slides per brand/channel)
7. Recommendations (1-2 slides)
8. Next steps/discussion

---

### Step 2: List Required Charts

#### Standard Charts

**1. RPI Curves (Relative Price Index)**
- One per channel or brand
- X-axis: Price points
- Y-axis: Market share response
- Shows elasticity visually
- Current price marker
- Optimal price marker (if applicable)

**2. CSF & MCV Comparison Tables**
- Side-by-side brand comparison
- Current vs optimal pricing
- Gap analysis (CSF, MCV, MSP)
- Channel-specific tables

**3. Market Share Scenarios**
- Current vs optimized state
- Revenue/volume impact projections
- Brand-by-brand breakdown

**4. Market Context Charts**
- Value/Volume/Price YoY changes
- Competitive positioning
- Distribution metrics
- Channel health indicators

**5. Trend Charts (if available)**
- CSF trends over time
- Price evolution
- Market share changes

---

### Step 3: List Narrative Sections

Based on reference examples (UK_BBQ, UK_BrownSauce, US_Spoonables), standard sections include:

#### Executive Summary (2-3 slides)
- Overall market performance
- Key takeaways by brand/category
- Top 3-5 actionable recommendations
- Expected impact (revenue, volume, share)
- Priority ranking

#### Methodology (3-4 slides)
- CSF objective (what it measures)
- How CSF relates to pricing power
- Value left on table concept
- Methodology summary (stages 1-6)
- Key metrics explanation (MCV, CSF, MSP, RPI)

#### Market Context (1-2 slides per channel)
- Channel health indicators
- YoY changes in value, volume, price
- Competitive dynamics
- Distribution changes
- Key observations

#### CSF & MCV Learning (1-2 slides per category)
- Brand comparison tables
- CSF and MCV values
- Market share potential
- Channel-specific insights
- Competitive positioning

#### RPI Curves (1-2 slides)
- Per-brand or per-channel curves
- Current price and RPI values
- Elasticity interpretation
- Pricing headroom

#### Recommendations (1-2 slides)
- Clear action items (Increase/Hold/Decrease)
- Price change percentages
- Priority ranking
- Expected impact
- Risk considerations

---

### Step 4: Create Plan Document

#### Example Output (UK BBQ Format)

```markdown
# Presentation Plan - UK BBQ

## Presentation Structure: 20 slides

### Slide 1: Title
- Project name: UK BBQ Sauce CSF Analysis
- Market: UK
- Date: June 2025

### Slide 2: Agenda
- Methodology overview
- BBQ brand results
- Salad Cream brand results
- Recommendations

### Slides 3-6: Methodology
- Slide 3: CSF objective
- Slide 4: What CSF measures (value left on table)
- Slide 5: How CSF informs pricing power
- Slide 6: Methodology summary (stages 1-6)

### Slide 7: Executive Summary - Main Takeaways
- Overall market trends
- BBQ insights
- Salad Cream insights

### Slides 8-11: UK BBQ - Market Context
- Slide 8: Supermarkets context (value/volume/price changes)
- Slide 9: Supermarkets key observations
- Slide 10: Tesco context
- Slide 11: Tesco key observations

### Slides 12-13: UK BBQ - CSF & MCV Learning
- Slide 12: CSF/MCV/MSP comparison table (all brands, both channels)
- Slide 13: Channel-level insights and key findings

### Slides 14-15: UK BBQ - RPI Curves
- Slide 14: Supermarket RPI curves (Heinz, HP, Bull's Eye)
- Slide 15: Tesco RPI curves (Heinz, HP, Bull's Eye)

### Slides 16-17: UK Salad Cream
- Slide 16: Market Context and CSF/MCV learnings
- Slide 17: RPI curves

### Slides 18-19: Recommendations
- Slide 18: BBQ recommendations (Heinz, HP, Bull's Eye)
- Slide 19: Salad Cream recommendations (Heinz, Private Label)

### Slide 20: Next Steps/Discussion

## Required Charts

1. Supermarkets Market Context - Value/Vol/Price changes
2. Tesco Market Context - Value/Vol/Price changes
3. BBQ - CSF/MCV/MSP Comparison Table (both channels)
4. BBQ - RPI Curves - Supermarkets (Heinz, HP, Bull's Eye)
5. BBQ - RPI Curves - Tesco (Heinz, HP, Bull's Eye)
6. Salad Cream - CSF/MCV/MSP Comparison Table
7. Salad Cream - RPI Curves (Heinz, Private Label)

## Required Narratives

1. Executive Summary with key takeaways
2. Per-brand insights:
   - BBQ: Heinz, HP, Bull's Eye
   - Salad Cream: Heinz, Private Label
3. Per-channel observations:
   - Supermarkets
   - Tesco
4. Strategic recommendations for each brand:
   - Price increase/decrease/hold
   - Expected impact
   - Priority ranking
```

---

## Planning Templates

### Template 1: Single Category, Multiple Channels

**Use when**: One product category across 3-4 channels

**Structure**:
- 1 title slide
- 1 agenda slide
- 3-4 methodology slides
- 2-3 executive summary slides
- 2-3 slides per channel (market context + CSF learnings)
- 1-2 RPI curve slides per channel
- 2-3 recommendation slides
- 1 next steps slide

**Total**: 18-25 slides

### Template 2: Multiple Categories, Multiple Channels

**Use when**: Multiple product categories (e.g., BBQ + Salad Cream)

**Structure**:
- 1 title slide
- 1 agenda slide (by category)
- 3-4 methodology slides
- 3-4 executive summary slides (by category)
- 2-3 slides per category-channel combination
- 1-2 RPI curve slides per major brand
- 3-5 recommendation slides (by category)
- 1 next steps slide

**Total**: 25-40 slides

### Template 3: PPG-Level Analysis

**Use when**: Detailed PPG (Price Point Group) analysis required

**Structure**: Same as Template 1 or 2, but with:
- Additional slides for PPG-level CSF/MCV tables
- PPG-specific recommendations
- Variant-level RPI curves

**Total**: 30-50 slides

---

## Planning Checklist

- [ ] Review 7a interpretation YAML to understand key insights
- [ ] Determine scope (channels, brands, categories, PPGs)
- [ ] Select appropriate template based on scope
- [ ] List all required charts (RPI curves, comparison tables, market context)
- [ ] List all narrative sections (executive summary, methodology, recommendations)
- [ ] Identify per-brand insights needed (from 7a YAML)
- [ ] Identify per-channel observations needed (from 7a YAML)
- [ ] Draft slide-by-slide outline
- [ ] Estimate slide count
- [ ] Review with stakeholder if needed

---

## Input from Stage 7a

When creating the presentation plan, reference the 7a interpretation YAML:

**Project metadata**:
- Project name, market, categories
- Level of analysis (brand/variant/PPG)
- Channels included

**Per-brand insights**:
- CSF category (high/medium/low) and value
- Price elasticity category and value
- Market share position (leader/follower)
- Competitive comparisons
- Overall assessment (strategic insights)

**Key findings to highlight**:
- Brands with highest CSF (pricing power)
- Brands losing share (negative MSP)
- Competitive dynamics (CSF differences)
- Channel-specific patterns

---

## Next Steps

After completing the presentation plan:

1. Review plan for completeness and flow
2. Validate against 7a interpretation YAML
3. Get stakeholder buy-in on structure if needed
4. Proceed to Stage 7c: Execute Presentation Generation

See: [presentation-execution.md](presentation-execution.md)
