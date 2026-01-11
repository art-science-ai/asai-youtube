# Stage 7c: Presentation Execution

## Purpose

Build the actual PowerPoint presentation using the plan from Stage 7b and the interpretation YAML from Stage 7a.

**Input**:
- Presentation plan from Stage 7b
- Interpretation YAML from Stage 7a
- Stage 6 Brand-Level Results CSV
- EDA outputs from Stage 3

**Output**: PowerPoint presentation file (`.pptx`)
**Status**: Manual process with reference documentation

---

## Process

### Step 1: Generate Charts

#### 1.1 RPI Curves (Relative Price Index)

**Data source**: Stage 6 RPI curve files

**Chart elements**:
- X-axis: Price points (current price ±20% range)
- Y-axis: Market share
- Multiple lines per brand
- Current price marker (vertical line)
- Optimal price marker (if applicable)
- Inflection point marker

**Styling guidelines**:
- Use brand colors for each line
- Add data labels for key points
- Include legend
- Clear axis labels
- Gridlines for readability

**Tools**:
- Excel (from Stage 6 output)
- Python (matplotlib/plotly)
- R (ggplot2)

#### 1.2 Comparison Tables

**CSF & MCV Comparison Tables**

**Table structure**:
```
| Brand | CSF | CSF Category | MCV | Current Price | MSP | Market Share |
|-------|-----|-------------|-----|---------------|-----|--------------|
| Heinz | 3.1 | High | 14.9 | 4.80 | +0.002 | 51.4% |
| HP | 2.8 | High | 13.5 | 4.82 | -0.001 | 28.0% |
```

**Formatting**:
- Color-code CSF categories (green=high, yellow=medium, red=low)
- Highlight leaders in each metric
- Use conditional formatting for visual impact
- Include currency symbols

**Channel-specific tables**: Create separate tables per channel if differences are significant

#### 1.3 Market Context Charts

**Value/Volume/Price Changes**

**Chart type**: Stacked bar chart or grouped bar chart

**Data points**:
- YoY value change (%)
- YoY volume change (%)
- YoY price change (%)

**Styling**:
- Group by channel
- Use consistent color scheme
- Add data labels
- Include benchmark line (0% = no change)

#### 1.4 Market Share Scenarios

**Chart type**: Bar chart with before/after comparison

**Data points**:
- Current market share
- Projected market share (at optimal price)
- Share change (absolute and %)

**Styling**:
- Side-by-side bars
- Growth arrow for positive changes
- Decline arrow for negative changes
- Highlight brands with >1% change

---

### Step 2: Write Narratives

#### 2.1 Use 7a Interpretation YAML

The 7a interpretation YAML provides structured insights:

**Per-brand insights available**:
- `csf_insight`: CSF interpretation (high/medium/low)
- `pe_insight`: Price elasticity interpretation
- `msp_insight`: Market share potential interpretation
- `market_share_position`: Leader/follower context
- `competitive_position`: Competitive comparison narrative
- `overall_assessment`: Strategic synthesis (enhanced by Claude)

**Example usage**:
```yaml
# From interpretation.yaml
brands:
  - brand: heinz
    interpretation:
      overall_assessment: "Dominant market leader (51% share) with strong pricing power. High CSF (2.32) combined with less elastic demand (-3.79) and positive momentum (MSP +0.0015) creates excellent pricing opportunity. Can consider 5-7% price increase with minimal volume risk."
```

**Convert to presentation narrative**:
- Synthesize multiple brands into coherent story
- Group similar insights
- Highlight key differences
- Focus on actionable recommendations

#### 2.2 Narrative Writing Guidelines

**Executive Summary**:
- Start with overall market health
- Highlight 3-5 key findings
- Group by brand or category
- Include top recommendations
- Quantify expected impact

**Per-brand insights**:
- Lead with CSF level and interpretation
- Explain competitive position
- Note market share trends (positive/negative MSP)
- Provide specific pricing recommendation
- Include rationale

**Recommendations**:
- Clear action items (Increase/Hold/Decrease)
- Specific price change percentages
- Priority ranking (high/medium/low)
- Expected impact (revenue, volume, share)
- Risk considerations

**Tone**:
- Business-friendly (not overly technical)
- Data-driven (back all claims with numbers)
- Action-oriented (focus on recommendations)
- Client-specific (use their terminology)

---

### Step 3: Assemble PowerPoint

#### 3.1 Structure and Flow

**Slide order**:
1. Title
2. Agenda
3. Methodology (3-4 slides)
4. Executive Summary (2-3 slides)
5. Market Context (1-2 slides per channel)
6. CSF & MCV Learnings (1-2 slides per category)
7. RPI Curves (1-2 slides)
8. Recommendations (1-2 slides)
9. Next Steps/Discussion

**Narrative flow**:
- Start with "why it matters" (executive summary)
- Explain "how we got here" (methodology)
- Show "what we found" (market context, CSF learnings)
- End with "what to do" (recommendations)

#### 3.2 Visual Design

**Consistent formatting**:
- Use master slides for consistent layout
- Apply brand colors
- Standard font sizes (title: 32-40pt, body: 18-24pt)
- Consistent chart styling

**Visual hierarchy**:
- Title slides: Section dividers with clear titles
- Content slides: One main idea per slide
- Use bold/italics sparingly for emphasis
- White space for readability

**Data visualization best practices**:
- Label all axes clearly
- Include units (currency, percentage)
- Use legends for multi-series charts
- Avoid 3D effects (harder to read)
- Color-code consistently (e.g., green=positive, red=negative)

#### 3.3 Executive-Ready Polish

**Review checklist**:
- [ ] No typos or grammatical errors
- [ ] All numbers are accurate (cross-check with source data)
- [ ] Charts are legible (test at 100% zoom)
- [ ] Narratives flow logically
- [ ] Recommendations are clear and actionable
- [ ] Formatting is consistent
- [ ] Slide titles are descriptive
- [ ] Presenter notes included (if needed)

**Pre-delivery validation**:
- Review with subject matter expert
- Spot-check calculations
- Verify all charts reflect latest data
- Test presentation on projector/screen
- Time the presentation (should be 20-30 minutes)

---

## Example Content Structure

### Executive Summary Example

```markdown
Slide: Executive Summary - UK BBQ

**Overall Market**
- UK BBQ sauce category declining 3.4% in value, 3.5% in volume
- Private label gaining share despite price increases
- Channel-specific dynamics: Iceland stable, national chains declining

**Key Findings by Brand**

**Heinz** (Market Leader, 31.7% share)
- CSF: 1.80 (medium) - moderate pricing power
- Price elasticity: -6.24 (moderately elastic)
- Gaining share (+0.17% MSP)
- Recommendation: Hold price, focus on promotional efficiency

**HP** (Challenger, 9.4% share)
- CSF: 1.72 (medium) - weaker than Heinz
- Price elasticity: -6.96 (moderately elastic)
- Losing share (-0.23% MSP)
- Recommendation: Avoid price increases, invest in marketing

**Bull's Eye** (Niche Player, 6.7% share)
- CSF: 1.68 (low) - vulnerable position
- Price elasticity: -7.30 (highly elastic)
- Losing share rapidly (-0.25% MSP)
- Recommendation: Reposition or consider exit

**Top Recommendations**
1. Heinz: Hold price, optimize promotions (Expected: +£50K revenue)
2. HP: £0.15 price decrease to stabilize share (Expected: +2% volume)
3. Bull's Eye: Marketing investment or portfolio review
```

### Methodology Slide Example

```markdown
Slide: What is CSF?

**Consumer Surplus Factor (CSF)**

CSF measures the gap between what consumers are willing to pay and what they actually pay.

**Key Metrics**:

**MCV** (Maximum Consumer Value)
- Highest price loyal customers will pay
- Varies by brand strength and differentiation

**CSF** = MCV / Current Price
- CSF > 2.0: High pricing power (can increase price)
- CSF 1.8-2.2: Optimal pricing
- CSF < 1.6: Low pricing power (vulnerable to competition)

**Business Application**:
- Identify pricing opportunities
- Quantify "value left on table"
- Prioritize brand investments
- Scenario planning
```

### Recommendations Slide Example

```markdown
Slide: Recommendations - UK BBQ

**Priority 1: Heinz - Hold Price (National Chains)**

**Action**: Maintain current price point (£5.57)
**Rationale**: Medium CSF (1.80) with moderately elastic demand (-6.24)
**Expected Impact**: Maintain share, stabilize revenue
**Timeline**: Immediate

**Priority 2: HP - Reduce Price to Compete**

**Action**: Decrease price by £0.15 to £5.54
**Rationale**: Losing share (-0.23% MSP), need to close gap with Heinz
**Expected Impact**: +2% volume, +£75K revenue
**Timeline**: Next promotional cycle

**Priority 3: Bull's Eye - Strategic Review**

**Action**: Portfolio review or significant repositioning
**Rationale**: Lowest CSF (1.68), highly elastic (-7.30), losing share
**Expected Impact**: Stop share decline, improve profitability
**Timeline**: Q3 planning cycle
```

---

## Quality Checklist

### Content Accuracy
- [ ] All numbers match Stage 6 results
- [ ] CSF values and interpretations are correct
- [ ] Competitive comparisons are accurate
- [ ] Market share data is current
- [ ] Recommendations align with CSF analysis

### Presentation Quality
- [ ] No typos or grammatical errors
- [ ] Consistent formatting throughout
- [ ] Charts are legible and labeled
- [ ] Slide titles are descriptive
- [ ] Logical flow from start to finish
- [ ] Presenter notes included (if needed)

### Business Value
- [ ] Executive summary highlights key findings
- [ ] Recommendations are clear and actionable
- [ ] Expected impact is quantified
- [ ] Risk considerations included
- [ ] Next steps are defined

---

## Tools and Resources

### PowerPoint Creation
- **Microsoft PowerPoint**: Standard tool, most compatible
- **Google Slides**: Collaborative editing
- **Apple Keynote**: Design-focused alternative

### Chart Generation
- **Excel**: From Stage 6 output files
- **Python**: matplotlib, plotly for custom charts
- **R**: ggplot2 for publication-quality charts

### Data Analysis
- **Pandas**: Data manipulation (Python)
- **dplyr**: Data manipulation (R)
- **Power Query**: Excel data transformation

---

## Time Estimates

| Task | Manual | With Templates |
|------|--------|----------------|
| Generate charts | 2-3 hours | 1-2 hours |
| Write narratives | 3-4 hours | 1-2 hours |
| Assemble PowerPoint | 2-3 hours | 1-2 hours |
| Review and polish | 1-2 hours | 1 hour |
| **Total** | **8-12 hours** | **4-7 hours** |

---

## Automation Opportunities (Future)

### Potential Automations

1. **Chart generation from YAML**:
   - Script to read interpretation YAML
   - Auto-generate RPI curves in Python
   - Export to PowerPoint-ready format

2. **Narrative drafting with LLM**:
   - Provide 7a YAML as context
   - Generate executive summary
   - Draft per-brand insights
   - Human review and refinement

3. **Slide template population**:
   - Python-pptx library
   - Template-based slide generation
   - Auto-populate charts and text
   - Manual review and polish

### Tool Suggestions

- **python-pptx**: PowerPoint generation from Python
- **pptx-template**: Template-based population
- **LLM integration**: GPT-4/Claude for narrative generation

---

## Next Steps

1. Complete presentation plan from Stage 7b
2. Generate all required charts from Stage 6 data
3. Write narratives using 7a interpretation YAML
4. Assemble PowerPoint with consistent formatting
5. Review with subject matter expert
6. Validate all calculations and data
7. Final polish and pre-delivery check
8. Deliver presentation to client

---

## References

- Stage 7a interpretation YAML structure: [../skills/interpret-results/SKILL.md](../skills/interpret-results/SKILL.md)
- Stage 7b planning guide: [presentation-planning.md](presentation-planning.md)
- Example presentations: `Data_Sharing/full_examples/`
- CSF methodology: `parsed_data/CSF_ReadMe.docx/`
