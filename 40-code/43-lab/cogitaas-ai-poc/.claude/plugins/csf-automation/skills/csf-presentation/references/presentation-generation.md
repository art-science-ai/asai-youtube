# Stage 7: Presentation Generation

## Overview

Transform quantitative CSF analysis results into stakeholder-ready PowerPoint presentations with data-driven narratives, visual charts, and strategic pricing recommendations.

**Assumption**: Stages 1-6 have already been completed (Data Collection, Data Preparation, EDA, Modelling, Model Selection, and Results Calculation).

**Current State**: ~1 week manual effort
**Target**: 2-4 hours with AI assistance

---

## Input Data

### Primary Input: Brand-Level Results CSV

**Location**: `6.Brand_Level_Results.csv` (output from Stage 6)

**Key Fields**:

| Field | Description | Example |
|-------|-------------|---------|
| Market | Geographic market | `uk`, `us` |
| Channel | Retail channel | `supermarket`, `tesco`, `walmart` |
| Brand | Product brand | `heinz`, `kraft` |
| Variant | Product variant | `all`, `regular`, `light` |
| PPG | Price Point Group | `all`, `jar_30oz`, `squeezy_18oz` |
| MCV | Maximum Consumer Value | `10.04` |
| Price | Current selling price | `5.57` |
| CSF | Consumer Surplus Factor (MCV/Price) | `1.80` |
| MSP | Market Share Potential | `0.0017` |
| MShare | Current market share | `0.317` |
| NewMShare | Projected market share | `0.319` |
| Price_elas | Price elasticity | `-6.24` |
| Revenue | Current revenue | `10370792.86` |
| Volume | Current volume | `1861485.95` |

### Secondary Inputs

- EDA outputs from Stage 3 (Power BI dashboards)
- Model features from Stage 4
- Business scope definition (channels, brands, variants, PPGs)

---

## Stage 7 Sub-stages

### 7a - Interpretation of Results

**Purpose**: Analyze quantitative results and generate structured interpretive insights in YAML format

**Status**: Automated via `skills/interpret-results/`

**Documentation**: [.plugins/csf/skills/interpret-results/SKILL.md](skills/interpret-results/SKILL.md)

**Output**: `interpretation.yaml` with:
- Project metadata
- Channel-level brand analysis
- CSF, PE, MSP categorizations
- Competitive comparisons
- Market position analysis
- Strategic assessments

**Detailed workflow**: See the interpret-results skill documentation

---

### 7b - Presentation Planning

**Purpose**: Create a structured plan listing all required charts and narrative sections

**Status**: Manual (reference documentation available)

**Documentation**: [presentation-planning.md](presentation-planning.md)

**Process**:
- Determine presentation structure (typically 15-30 slides)
- List required charts (RPI curves, comparison tables, market context charts)
- List narrative sections (executive summary, methodology, market context, recommendations)
- Create plan document

**Output**: Presentation plan (markdown or YAML) outlining slide structure and required elements

---

### 7c - Presentation Execution

**Purpose**: Build the actual PowerPoint presentation using the plan

**Status**: Manual (reference documentation available)

**Documentation**: [presentation-execution.md](presentation-execution.md)

**Process**:
- Generate charts from Stage 6 data
- Write narratives based on 7a interpretation YAML
- Assemble PowerPoint with consistent formatting
- Ensure executive-ready polish

**Output**: PowerPoint presentation file (`.pptx`)

---

## Data Flow

```
Stage 6: Brand-Level Results (CSV)
    ↓
Stage 7a: Interpret Results (automated)
    ↓
    Output: interpretation.yaml
    ↓
Stage 7b: Generate Presentation Plan (manual)
    ↓
    Output: presentation_plan.md or .yaml
    ↓
Stage 7c: Execute Presentation Generation (manual)
    ↓
    Output: presentation.pptx
```

---

## AI Automation Opportunities

### High Automation Potential

| Task | Current | AI Approach |
|------|---------|-------------|
| CSF categorization | Manual | Rule-based automation (implemented in 7a skill) |
| CSF comparison to competition | Manual | Automated analysis (implemented in 7a skill) |
| Chart generation | Manual in Excel/PPT | Template-based generation |
| Comparison tables | Manual | Automated table creation |

### Medium Automation Potential

| Task | Current | AI Approach |
|------|---------|-------------|
| Narrative writing | Expert writing | LLM with examples |
| Insight extraction | Manual analysis | Pattern matching + LLM |
| Executive summary | Manual | LLM synthesis |

### Requires Human Review

| Task | Why Human Needed |
|------|------------------|
| Strategic recommendations | Business context, client relationship |
| Final presentation polish | Client-specific formatting |
| Outlier explanations | Domain expertise required |

---

## Reference Examples

### UK_BBQ (20 slides)
- Scope: BBQ Sauce category, UK market, 2 channels (Supermarkets, Tesco), 3 main brands
- Key insights: Heinz stability, HP channel differentiation, Bull's Eye needs marketing
- Location: `Data_Sharing/full_examples/UK_BBQ/8.Presentation.pptx/`

### UK_BrownSauce
- Scope: Brown Sauce category, UK market
- Location: `Data_Sharing/full_examples/UK_BrownSauce/10.Presentation.pptx/`

### US_Spoonables (Most Comprehensive - 463 lines text)
- Scope: Mayo/Dressing category, US market (Walmart, Target), multiple variants
- Features: Detailed PPG analysis, variant-level breakdown, channel-specific recommendations
- Location: `Data_Sharing/full_examples/US_Spoonables/12.Presentation.pptx/`

---

## Quality Checklist

- [ ] All brands and channels in scope are covered
- [ ] CSF values are correctly interpreted
- [ ] Competitive comparisons are accurate
- [ ] Recommendations align with CSF analysis
- [ ] RPI curves are properly generated
- [ ] Narratives are consistent with data
- [ ] Executive summary highlights key findings
- [ ] Presentation follows standard structure

---

## Next Steps

1. **Stage 7a** (Automated): Use `interpret-results` skill to generate interpretation YAML
2. **Stage 7b** (Manual): Create presentation plan using [presentation-planning.md](presentation-planning.md)
3. **Stage 7c** (Manual): Execute presentation generation using [presentation-execution.md](presentation-execution.md)
4. Create human review checkpoints for quality assurance
