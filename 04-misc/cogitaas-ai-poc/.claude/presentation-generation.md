# Presentation Generation Workflow

## Overview

The Presentation stage (Stage 7) transforms quantitative CSF analysis results into a stakeholder-ready PowerPoint presentation with data-driven narratives, visual charts, and strategic pricing recommendations. This is the most labor-intensive deliverable in the CSF workflow, typically requiring ~1 week of manual effort.

**Goal for AI Automation**: Reduce presentation generation time from 1 week to hours while maintaining narrative quality and strategic insights.

---

## Inputs

### Primary Input: Brand-Level Results (Stage 6 Output)

**Format**: CSV (parsed to JSON)
**Location**: `Data_Sharing/{Project}/6.Brand_Level_Results/`

**Key Fields**:
| Field | Description | Example |
|-------|-------------|---------|
| `Market` | Geographic market | `uk`, `us` |
| `Channel` | Retail channel | `supermarket`, `tesco`, `walmart` |
| `Brand` | Product brand | `heinz`, `kraft` |
| `Variant` | Product variant | `all`, `regular`, `light` |
| `PPG` | Price Point Group | `all`, `jar_30oz`, `squeezy_18oz` |
| `MCV` | Maximum Consumer Value - highest price loyal consumers will pay | `10.04` |
| `Price` | Current selling price | `5.57` |
| `CSF` | Consumer Surplus Factor (MCV / Price) | `1.80` |
| `MSP` | Market Share Potential at optimal price | `0.0017` |
| `MShare` | Current market share | `0.317` |
| `NewMShare` | Projected market share post-optimization | `0.319` |
| `Revenue` | Current revenue | `10370792.86` |
| `Volume` | Current volume | `1861485.95` |
| `Price_elas` | Price elasticity | `-6.24` |
| `CS` | Consumer Surplus in currency | `14526929.77` |

### Secondary Inputs

1. **EDA Outputs (Stage 3)**: Market context, historical trends, competitive landscape
2. **Model Features (Stage 4)**: Statistical backing for recommendations
3. **Business Scope Definition**: Channels, brands, variants, PPGs in scope

---

## Process Steps

### Step 1: Pricing Power Assessment

Categorize each brand/channel/variant combination based on CSF thresholds:

| CSF Range | Category | Interpretation | Action |
|-----------|----------|----------------|--------|
| CSF > 2.3 | **Healthy** | High pricing power, value left on table | Can increase price |
| CSF 1.8-2.2 | **Optimal** | Balanced pricing | Hold current price |
| CSF < 1.6 | **Unhealthy** | Low pricing power, overpriced | Consider price decrease |

**Process**:
1. Calculate CSF for each brand-channel-variant-PPG combination
2. Compare MCV Index vs Price Index:
   - MCV Index > Price Index → Has pricing power (can increase)
   - MCV Index < Price Index → Overpriced (decrease recommended)
   - MCV Index ≈ Price Index → At parity (hold)
3. Flag outliers and special cases for manual review

### Step 2: Strategic Recommendations Generation

For each entity in scope, determine recommendation:

**Decision Framework**:
```
IF CSF > 2.3 AND competitive_position == "strong":
    recommendation = "INCREASE"
    rationale = "High pricing power with room to capture more value"

ELIF CSF < 1.6 OR (MCV_Index < Price_Index):
    recommendation = "DECREASE"
    rationale = "Overpriced relative to consumer willingness to pay"

ELSE:
    recommendation = "HOLD"
    rationale = "Optimal pricing at current levels"
```

**Breakdown Dimensions**:
- By channel (Supermarket, Tesco, Convenience, etc.)
- By brand (Heinz, HP, Bull's Eye, etc.)
- By variant (Regular, Light, Organic, etc.)
- By PPG/pack size (30oz Jar, 18oz Squeezy, etc.)

### Step 3: Chart and Visual Creation

**Required Visualizations**:

1. **RPI Curves** (Relative Price Index)
   - X-axis: Price points
   - Y-axis: Market share response
   - Shows elasticity visually
   - One per channel or brand

2. **MCV/CSF Comparison Tables**
   - Side-by-side brand comparison
   - Current vs optimal pricing
   - Gap analysis (value left on table)

3. **Market Share Scenarios**
   - Current state vs optimized state
   - Revenue/volume impact projections

4. **Market Context Charts**
   - Value/Volume/Price YoY changes
   - Competitive positioning
   - Distribution metrics

### Step 4: Narrative Development

Transform data insights into stakeholder-friendly stories:

**Narrative Components**:
1. **Executive Summary** (2-3 slides)
   - Key takeaways by category
   - Top 3-5 actionable recommendations
   - Expected impact (revenue/share)

2. **Market Context** (1-2 slides per channel)
   - Channel health indicators
   - Competitive dynamics
   - Recent trends affecting pricing

3. **Brand Deep-Dives** (2-4 slides per brand)
   - CSF performance analysis
   - Channel-specific insights
   - Variant/PPG breakdown where relevant

4. **Recommendations Summary** (1-2 slides)
   - Clear action items
   - Priority ranking
   - Risk considerations

### Step 5: Presentation Assembly

**Standard Structure** (15-30 slides):

```
Slide 1:     Title (Project name, market, date)
Slides 2-3:  Agenda / Table of Contents
Slides 4-6:  Executive Summary & Key Takeaways
Slide 7:     CSF Methodology Reminder
Slides 8-10: Market Context by Channel
Slides 11-N: Channel/Brand Analysis (bulk of presentation)
             - For each channel:
               - Market overview
               - CSF & MCV learnings
               - RPI curves
               - Brand-specific insights
Slide N+1:   Recommendations Summary
Slide N+2:   Next Steps / Discussion
Slide N+3:   Thank You / Contact
```

---

## Outputs

### Primary Output: PowerPoint Presentation

**Format**: .pptx
**Location**: `Data_Sharing/{Project}/7.Presentation/`

**Characteristics**:
- 15-30 slides depending on scope
- Mix of data tables, charts, and narrative text
- Executive-ready formatting
- Clear recommendation callouts

### Supplementary Outputs

1. **Extracted Text** (`text.txt`): Plain text extraction for reference/search
2. **Parsing Readme** (`readme.md`): Documentation of file processing

---

## AI Automation Opportunities

### High Automation Potential

| Component | Current State | AI Approach |
|-----------|--------------|-------------|
| CSF threshold categorization | Manual calculation | Rule-based automation |
| Recommendation generation | Expert judgment | Decision tree + LLM rationale |
| Standard chart creation | Manual in Excel/PPT | Template-based generation |
| Slide structure | Manual layout | Template population |

### Medium Automation Potential

| Component | Current State | AI Approach |
|-----------|--------------|-------------|
| Narrative writing | Expert writing | LLM with examples |
| Insight extraction | Manual analysis | Pattern matching + LLM |
| Brand comparisons | Manual side-by-side | Automated diff analysis |

### Requires Human Review

| Component | Why Human Needed |
|-----------|------------------|
| Strategic recommendations | Business context, client relationship |
| Outlier explanations | Domain expertise required |
| Final presentation polish | Client-specific formatting |
| Executive summary tone | Stakeholder communication style |

---

## Example Presentations Analysis

### UK_BBQ (20 slides, 7,023 bytes text)

**Scope**: BBQ Sauce category, UK market, 4 channels, 3 brands

**Key Insights Generated**:
- Heinz: "Has potential market stability given consolidation at right price"
- HP: "Subpar CSF compared to HP in Tesco where priced lower to Heinz"
- Bull's Eye: "Least CSF in both channels even after price reductions"

**Data Points Presented**:
- Channel performance: Supermarkets -3.8% value, +0.5% volume, -4.3% price
- Tesco: -3.0% value, +6.7% volume, -9.1% price
- CSF scores: Supermarkets 3.1 CSF (14.9 MCV), Tesco 3.6 CSF (17.1 MCV)

### US_Spoonables (Most Comprehensive - 463 lines text)

**Scope**: Mayo/Dressing category, US market (Walmart, Target), multiple variants

**Structure Highlights**:
- Detailed PPG size analysis (30oz Jar: 51% share, Squeezy 18-22oz: 16%)
- Variant-level breakdown (Small/Medium/Large)
- Channel-specific recommendations

---

## Implementation Notes

### Parsing Tools

**Text Extraction** (`scripts/extract_text.py`):
```python
from pptx import Presentation

def extract_text_from_pptx(pptx_path):
    presentation = Presentation(pptx_path)
    extracted_text = ""
    for slide_number, slide in enumerate(presentation.slides):
        extracted_text += f"\nSlide {slide_number + 1}:\n"
        for shape in slide.shapes:
            if hasattr(shape, "text"):
                extracted_text += shape.text + "\n"
    return extracted_text
```

### Data Dependencies

```
Stage 6 (Brand-Level Results)
    ↓
    data.json (parsed CSV)
    ↓
Stage 7 (Presentation)
    ↓
    - Analysis & categorization
    - Chart generation
    - Narrative writing
    - PowerPoint assembly
    ↓
Output: presentation.pptx + text.txt
```

---

## Workflow Metrics

| Metric | Current (Manual) | Target (AI-Assisted) |
|--------|------------------|---------------------|
| Time to complete | ~1 week | 2-4 hours |
| Iterations needed | 3-5 rounds | 1-2 rounds |
| Expert hours | 40+ hours | 4-8 hours (review only) |
| Consistency | Variable | Standardized |

---

## Next Steps for AI Workflow Development

1. **Template Creation**: Build PowerPoint templates with placeholder structures
2. **Narrative Examples**: Curate best-practice narrative examples from UK_BBQ, UK_BrownSauce, US_Spoonables
3. **Decision Rules**: Codify CSF threshold rules and recommendation logic
4. **Chart Generation**: Develop automated RPI curve and comparison chart generation
5. **LLM Prompt Engineering**: Design prompts for insight extraction and narrative writing
6. **Validation Pipeline**: Create human review checkpoints for quality assurance

---

## References

- `parsed_data/Agentic AI - Documents/Data_Sharing/UK_BBQ/7.Presentation/` - Complete example
- `parsed_data/Agentic AI - Documents/Data_Sharing/US_Spoonables/9.Presentation/` - Most detailed example
- `parsed_data/Agentic AI - Documents/CSF_ReadMe/text.txt` - Methodology documentation
- `scripts/extract_text.py` - PPTX parsing script
