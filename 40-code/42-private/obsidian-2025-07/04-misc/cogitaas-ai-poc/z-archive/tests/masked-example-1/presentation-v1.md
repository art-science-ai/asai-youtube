# Presentation Draft v1: Masked Example - LMTGT Liquid Channel

> **AI-Generated Draft** | Following `workflows/presentation-generation.md`
>
> **Status**: Steps 1-2 Complete | Step 3 Charts Listed

---

## Reasoning: Understanding the Input Data

Before generating this presentation, I analyzed the input data structure:

**Data Sources Used**:
- `2.BrandVariant_Level_Results/data.json` - 6 brand-level records
- `3.BrandVariant_PPG_Level_Results/data.json` - 38 PPG-level records

**Scope Identified**:
- **Market**: LMTGT (masked identifier)
- **Channel**: Liquid (single channel)
- **Brands**: 6 competing brands in the category
- **PPG Types**: 7 pack size segments (big pack, big sachet, mini pack, small pack, medium pack 500-800ml, medium pack 900-1000ml, others)

**Key Observation**: All 6 brands have CSF values between 1.01 and 1.52 - significantly below the "Healthy" threshold of 2.3. This suggests systemic pricing pressure across the category, likely indicating a highly competitive, price-sensitive market.

---

# Step 1: Pricing Power Assessment

## 1.1 Brand-Level CSF Analysis

| Brand | MCV | Current Price | CSF | Category | Interpretation |
|-------|-----|---------------|-----|----------|----------------|
| **mama cplus** | 25.03 | 16.43 | **1.52** | Borderline | Highest pricing power in category |
| **wings ekonomi cplus** | 21.36 | 14.18 | **1.51** | Borderline | Strong value positioning |
| **sunlight cplus** | 32.79 | 21.83 | **1.50** | Borderline | Premium priced but justified by MCV |
| **mama core** | 25.28 | 17.16 | **1.47** | Unhealthy | Core brand under pressure |
| **others cplus** | 23.06 | 16.45 | **1.40** | Unhealthy | Low pricing power |
| **sunlight core** | 31.46 | 22.80 | **1.38** | Unhealthy | **Lowest CSF despite highest MCV** |

### Reasoning: CSF Threshold Application

I applied the standard CSF thresholds from `workflows/presentation-generation.md`:

```
CSF > 2.3  → Healthy (high pricing power)     → 0 brands
CSF 1.8-2.2 → Optimal                         → 0 brands
CSF 1.6-1.8 → Borderline                      → 0 brands
CSF < 1.6  → Unhealthy (low pricing power)   → 6 brands (ALL)
```

**Critical Finding**: No brands achieve even "Borderline" healthy status. The entire category is under pricing pressure. However, relative positioning matters - `mama cplus` at 1.52 has 10% more pricing headroom than `sunlight core` at 1.38.

---

## 1.2 PPG-Level CSF Analysis (Pack Size Breakdown)

### Top Performing PPGs (CSF > 1.6 - Relative "Stars")

| Brand | PPG | MCV | Price | CSF | Market Share |
|-------|-----|-----|-------|-----|--------------|
| **wings ekonomi cplus** | small pack | 23.81 | 10.83 | **2.20** | 0.21% |
| **sunlight cplus** | big sachet | 36.65 | 19.74 | **1.86** | 0.04% |
| **mama cplus** | big pack | 23.25 | 13.04 | **1.78** | 0.20% |
| **mama core** | big pack | 23.46 | 13.58 | **1.73** | 0.38% |
| **others cplus** | big pack | 22.06 | 13.68 | **1.61** | 0.23% |
| **wings ekonomi cplus** | big pack | 19.73 | 12.16 | **1.62** | 0.14% |
| **mama core** | medium pack 500-800ml | 23.54 | 14.66 | **1.61** | 6.51% |
| **mama cplus** | medium pack 500-800ml | 23.32 | 14.51 | **1.61** | 3.14% |

### Reasoning: Why These PPGs Stand Out

The "big pack" and "medium pack 500-800ml" segments show stronger CSF values across multiple brands. This suggests:
1. **Economy-size consumers** are less price sensitive
2. **Value-seeking behavior** rewards larger pack sizes
3. Opportunity to **protect margins** in these segments

**Notable Exception**: `wings ekonomi cplus small pack` has CSF of 2.20 - the only PPG exceeding the "Optimal" threshold. This is a pricing anomaly worth investigating.

---

### Underperforming PPGs (CSF < 1.2 - "Problem Areas")

| Brand | PPG | MCV | Price | CSF | Market Share | Issue |
|-------|-----|-----|-------|-----|--------------|-------|
| **others cplus** | others | 19.99 | 19.78 | **1.01** | 0.15% | Nearly zero surplus |
| **sunlight cplus** | small pack | 41.57 | 39.59 | **1.05** | 0.002% | Extreme overpricing |
| **sunlight core** | medium pack 900-1000ml | 20.83 | 19.84 | **1.05** | 0.24% | At MCV ceiling |
| **mama core** | medium pack 900-1000ml | 15.63 | 14.11 | **1.11** | 0.27% | Low headroom |
| **wings ekonomi cplus** | others | 17.88 | 15.91 | **1.12** | 0.09% | Overpriced |

### Reasoning: Interpreting Low CSF Values

CSF values near 1.0 indicate the brand is priced at or above its Maximum Consumer Value - consumers perceive no surplus value. These PPGs are:
- **High risk** for volume loss if competitors undercut
- Candidates for **price reduction** or **value-add repositioning**
- Contributing to negative MSP (Market Share Potential)

---

## 1.3 Market Share Distribution by Brand

| Brand | Current Share | CSF | Strategic Position |
|-------|--------------|-----|-------------------|
| **sunlight core** | 49.90% | 1.38 | **Market leader under pressure** |
| **mama core** | 28.75% | 1.47 | Challenger with moderate headroom |
| **mama cplus** | 8.77% | 1.52 | Best-positioned premium tier |
| **wings ekonomi cplus** | 6.78% | 1.51 | Value tier with strong CSF |
| **sunlight cplus** | 0.58% | 1.50 | Niche premium, small base |
| **others cplus** | 5.23% | 1.40 | Fragmented competitors |

### Reasoning: Market Dynamics

The market leader (`sunlight core` at 49.9% share) has the **worst CSF** in the category. This creates a strategic tension:
- High market share creates pricing power expectations
- Low CSF suggests the brand is extracting maximum value but at risk
- Competitors with better CSF (`mama cplus`, `wings ekonomi cplus`) may be better positioned for price competition

---

# Step 2: Strategic Recommendations

## 2.1 Brand-Level Recommendations

### Recommendation Summary Table

| Brand | Current CSF | MSP | Recommendation | Rationale |
|-------|-------------|-----|----------------|-----------|
| **wings ekonomi cplus** | 1.51 | +0.21% | **HOLD** | Best value positioning; protect share gains |
| **mama cplus** | 1.52 | +0.34% | **SELECTIVE INCREASE** | Highest CSF; can test modest increases on strong PPGs |
| **sunlight cplus** | 1.50 | +0.02% | **HOLD** | Small base limits upside; maintain niche position |
| **mama core** | 1.47 | +0.51% | **HOLD + OPTIMIZE** | Large share gain potential through PPG optimization |
| **others cplus** | 1.40 | -0.06% | **DECREASE or REPOSITION** | Negative MSP indicates overpricing |
| **sunlight core** | 1.38 | -1.02% | **STRATEGIC DECREASE** | Market leader losing share; must protect position |

---

## 2.2 Detailed Brand Recommendations

### SUNLIGHT CORE: Strategic Decrease Required

**Current State**:
- Market Share: 49.90% (dominant)
- CSF: 1.38 (lowest in category)
- MSP: -1.02% (losing share)
- Price Elasticity: -13.18 (highly elastic)

**Recommendation**: **DECREASE prices selectively on high-volume PPGs**

**Reasoning**:
1. **MSP of -1.02%** means the brand is projected to lose 1% market share at current pricing
2. **Price elasticity of -13.18** indicates consumers are highly responsive to price changes
3. As market leader, protecting volume is more valuable than margin on individual units
4. **Focus areas**:
   - medium pack 500-800ml (CSF 1.32, 9.6% share) - significant volume
   - mini pack (CSF 1.37, 14.3% share) - second largest segment
   - big sachet (CSF 1.41, 17.4% share) - largest segment

**Expected Impact**:
- Stem share losses in core segments
- Force competitors to respond, potentially weakening their margins
- Reestablish value perception with price-sensitive consumers

---

### MAMA CORE: Hold + Optimize PPG Mix

**Current State**:
- Market Share: 28.75% (strong #2)
- CSF: 1.47 (above category average)
- MSP: +0.51% (gaining share)
- Price Elasticity: -10.87 (moderate)

**Recommendation**: **HOLD overall pricing; OPTIMIZE individual PPGs**

**Reasoning**:
1. **MSP of +0.51%** indicates current pricing is sustainable
2. Significant **PPG variance** suggests optimization opportunity:
   - **Increase**: big pack (CSF 1.73), medium pack 500-800ml (CSF 1.61)
   - **Hold**: mini pack (CSF 1.58), big sachet (CSF 1.42)
   - **Decrease**: medium pack 900-1000ml (CSF 1.11), others (CSF 1.24)

**Expected Impact**:
- Maintain positive share trajectory
- Improve margin mix through selective increases on strong PPGs
- Address underperforming "others" and "900-1000ml" segments

---

### MAMA CPLUS: Selective Increase

**Current State**:
- Market Share: 8.77%
- CSF: 1.52 (highest in category)
- MSP: +0.34% (gaining share)
- Price Elasticity: -10.16 (moderate)

**Recommendation**: **SELECTIVE INCREASE on high-CSF PPGs**

**Reasoning**:
1. **Highest CSF** in category provides pricing headroom
2. **Strong PPGs for increase**:
   - big pack (CSF 1.78) - can tolerate 5-8% increase
   - medium pack 500-800ml (CSF 1.61) - largest volume segment
   - mini pack (CSF 1.58) - moderate increase possible
3. **Hold or decrease**:
   - others (CSF 1.23) - overpriced
   - small pack (CSF 1.36) - at ceiling

**Expected Impact**:
- Capture additional margin from value-conscious consumers
- Fund potential competitive responses in "cplus" tier
- Test price elasticity limits on strongest segments

---

### WINGS EKONOMI CPLUS: Hold Position

**Current State**:
- Market Share: 6.78%
- CSF: 1.51 (second highest)
- MSP: +0.21% (gaining share)
- Price Elasticity: -10.21 (moderate)

**Recommendation**: **HOLD current pricing**

**Reasoning**:
1. Value tier positioning is working - gaining share
2. **Outstanding performer**: small pack at CSF 2.20 (unique in category)
3. Competitive pressure from `mama cplus` limits increase potential
4. Current trajectory is positive without intervention

**Exception**: Consider **modest increase** on small pack (CSF 2.20) - significant headroom exists.

---

### SUNLIGHT CPLUS: Hold Niche

**Current State**:
- Market Share: 0.58% (niche)
- CSF: 1.50
- MSP: +0.02% (stable)

**Recommendation**: **HOLD - protect niche position**

**Reasoning**:
1. Small market share limits strategic options
2. Premium pricing (highest MCV at 32.79) is appropriate for segment
3. No urgent action required; monitor competitive dynamics

---

### OTHERS CPLUS: Reposition or Decrease

**Current State**:
- Market Share: 5.23%
- CSF: 1.40 (below average)
- MSP: -0.06% (losing share)

**Recommendation**: **DECREASE prices or REPOSITION value proposition**

**Reasoning**:
1. Negative MSP indicates current pricing is not sustainable
2. Fragmented competitor set may require differentiation strategy
3. **Focus decrease** on:
   - others (CSF 1.01) - critical overpricing
   - big sachet (CSF 1.23) - significant volume segment
   - medium pack 900-1000ml (CSF 1.24) - underperforming

---

## 2.3 Recommendation Summary Matrix

```
                    INCREASE         HOLD            DECREASE
                    ─────────────────────────────────────────────
High Share (>20%)                    mama core       sunlight core
                                     (optimize PPG)  (protect share)

Medium Share (5-20%) mama cplus     wings ekonomi    others cplus
                    (selective)      cplus           (reposition)

Low Share (<5%)                      sunlight cplus
                                     (maintain niche)
```

---

# Step 3: Chart Requirements (Specifications Only)

> **Note**: This section lists the charts required for the final presentation with detailed specifications. Chart generation to follow in v2.

---

## 3.1 Executive Summary Charts

### Chart 1: Category CSF Overview (Bubble Chart)

**Purpose**: Show relative positioning of all 6 brands on CSF vs Market Share

**Specifications**:
- **X-axis**: Current Market Share (0% to 55%)
- **Y-axis**: CSF (1.0 to 1.6)
- **Bubble Size**: Revenue (proportional)
- **Bubble Color**: Recommendation category (Green=Increase, Yellow=Hold, Red=Decrease)
- **Reference Lines**:
  - Horizontal line at CSF = 1.6 (threshold)
  - Horizontal line at CSF = 2.3 (healthy threshold - will be off chart)

**Data Points**:
| Brand | X (Share) | Y (CSF) | Size (Revenue) | Color |
|-------|-----------|---------|----------------|-------|
| sunlight core | 49.90% | 1.38 | 936B | Red |
| mama core | 28.75% | 1.47 | 539B | Yellow |
| mama cplus | 8.77% | 1.52 | 165B | Green |
| wings ekonomi cplus | 6.78% | 1.51 | 127B | Yellow |
| others cplus | 5.23% | 1.40 | 98B | Red |
| sunlight cplus | 0.58% | 1.50 | 11B | Yellow |

**Insight Callout**: "Market leader has lowest CSF - strategic vulnerability"

---

### Chart 2: MSP Waterfall (Horizontal Bar Chart)

**Purpose**: Show projected market share change by brand

**Specifications**:
- **Y-axis**: Brand names (sorted by MSP descending)
- **X-axis**: MSP value (-1.5% to +1.0%)
- **Bar Colors**: Green for positive, Red for negative
- **Reference Line**: Vertical at 0%

**Data Points**:
| Brand | MSP |
|-------|-----|
| mama core | +0.51% |
| mama cplus | +0.34% |
| wings ekonomi cplus | +0.21% |
| sunlight cplus | +0.02% |
| others cplus | -0.06% |
| sunlight core | -1.02% |

**Insight Callout**: "Mama brands gaining; Sunlight core projected to lose 1% share"

---

## 3.2 Brand-Level Analysis Charts

### Chart 3: CSF by PPG Heatmap (For Each Brand)

**Purpose**: Visualize CSF performance across pack sizes for quick identification of strong/weak PPGs

**Specifications**:
- **Rows**: PPG types (big pack, big sachet, mini pack, small pack, medium 500-800ml, medium 900-1000ml, others)
- **Columns**: Brands (6 brands)
- **Cell Color**: Heat scale from Red (CSF < 1.2) → Yellow (1.2-1.5) → Green (>1.6)
- **Cell Value**: CSF number displayed

**Color Thresholds**:
- Red: CSF < 1.2 (critical)
- Orange: CSF 1.2-1.4 (concerning)
- Yellow: CSF 1.4-1.6 (acceptable)
- Light Green: CSF 1.6-1.8 (good)
- Dark Green: CSF > 1.8 (excellent)

**Example Data (partial)**:
```
                    others   sunlight  wings    mama    mama    sunlight
                    cplus    cplus     ekonomi  core    cplus   core
big pack            1.61     -         1.62     1.73    1.78    1.42
big sachet          1.23     1.86      1.43     1.42    1.46    1.41
mini pack           1.40     1.60      1.56     1.58    1.58    1.37
small pack          1.49     1.05*     2.20*    1.36    1.36    1.42
medium 500-800ml    1.41     1.47      1.53     1.61    1.61    1.32
medium 900-1000ml   1.24     -         -        1.11    -       1.05*
others              1.01*    -         1.12     1.24    1.23    1.28
```
*Starred values are extreme cases requiring attention

---

### Chart 4: Price vs MCV Scatter Plot (Per Brand)

**Purpose**: Show relationship between current price and maximum consumer value by PPG

**Specifications** (generate 6 charts, one per brand):
- **X-axis**: Current Price
- **Y-axis**: Maximum Consumer Value (MCV)
- **Points**: Each PPG for that brand
- **Point Size**: Market share
- **Diagonal Line**: 45-degree reference (Price = MCV, i.e., CSF = 1.0)
- **Point Labels**: PPG name

**Interpretation Guide**:
- Points **above diagonal**: Has pricing headroom (CSF > 1)
- Points **on diagonal**: At maximum price (CSF ≈ 1)
- Points **below diagonal**: Theoretical only (CSF < 1 means negative surplus)

---

## 3.3 PPG Deep-Dive Charts

### Chart 5: Revenue vs CSF Quadrant Analysis

**Purpose**: Identify strategic priorities by combining revenue importance with pricing health

**Specifications**:
- **X-axis**: Revenue (log scale recommended due to range)
- **Y-axis**: CSF (1.0 to 2.3)
- **Quadrants**:
  - Top-Right: "Stars" (High revenue, High CSF) - Protect & grow
  - Top-Left: "Niche Winners" (Low revenue, High CSF) - Consider expansion
  - Bottom-Right: "Cash Cows at Risk" (High revenue, Low CSF) - Urgent attention
  - Bottom-Left: "Question Marks" (Low revenue, Low CSF) - Review portfolio fit
- **Reference Lines**:
  - Vertical at median revenue
  - Horizontal at CSF = 1.5

**Key Data Points to Highlight**:
- `sunlight core_big sachet` (327B revenue, 1.41 CSF) - Largest segment, concerning CSF
- `wings ekonomi cplus_small pack` (3.9B revenue, 2.20 CSF) - Small but exceptional
- `mama core_mini pack` (118B revenue, 1.58 CSF) - Strong performer

---

### Chart 6: Competitive Elasticity Network Diagram

**Purpose**: Visualize cross-price elasticity relationships between brands

**Specifications**:
- **Nodes**: Each brand (6 nodes)
- **Node Size**: Market share
- **Edges**: Cross-price elasticity values
- **Edge Thickness**: Absolute elasticity magnitude
- **Edge Color**: Direction (Green = substitutes, Red = complements)

**Key Relationships to Visualize** (from data):
| From Brand | To Brand | Elasticity | Interpretation |
|------------|----------|------------|----------------|
| mama core | sunlight core | 1.24 | Weak substitute |
| mama cplus | mama core | 9.38 | Strong substitute |
| wings ekonomi | mama cplus | 10.95 | Strong substitute |
| sunlight core | mama cplus | 4.86 | Moderate substitute |

**Insight**: The "mama" brands are highly substitutable with each other (elasticity 9.38). Strategic coordination between core and cplus lines is essential.

---

## 3.4 RPI Curve Charts

### Chart 7: RPI Curves by Brand (6 Charts)

**Purpose**: Show price-volume relationship and identify optimal price points

**Specifications** (one chart per brand):
- **X-axis**: Price Index (relative to current price, 80% to 120%)
- **Y-axis**: Projected Market Share Change
- **Curve**: Fitted from price elasticity data
- **Reference Points**:
  - Current price (100%) marked
  - MCV price marked
  - Optimal price (if different) marked

**Curve Generation Formula**:
```
ΔShare = Price_elasticity × (ΔPrice / Current_Price)
```

**Example for Sunlight Core**:
- Current Price: 22.80
- Price Elasticity: -13.18
- MCV: 31.46
- At +10% price: Share change = -13.18 × 0.10 = -1.32%
- At -10% price: Share change = -13.18 × (-0.10) = +1.32%

---

### Chart 8: PPG-Level RPI Comparison (Selected PPGs)

**Purpose**: Compare price response across pack sizes for a single brand

**Specifications**:
- **X-axis**: Price Index (80% to 120%)
- **Y-axis**: Projected Volume Change
- **Lines**: One line per PPG (color-coded)
- **Generate for**: Top 2-3 brands by share (sunlight core, mama core, mama cplus)

**Insight**: Shows which PPGs are most/least price sensitive within a brand portfolio

---

## 3.5 Recommendation Visualization Charts

### Chart 9: Action Priority Matrix

**Purpose**: Summarize recommendations in actionable format

**Specifications**:
- **Y-axis**: Urgency (High to Low)
- **X-axis**: Impact (Low to High)
- **Quadrants**:
  - Top-Right: "Act Now"
  - Top-Left: "Quick Wins"
  - Bottom-Right: "Strategic Projects"
  - Bottom-Left: "Monitor"
- **Points**: Each brand-PPG combination with recommendation

**Placement Logic**:
- Urgency = |MSP| (higher absolute MSP = more urgent)
- Impact = Revenue × |CSF deviation from 1.5|

---

### Chart 10: Before/After Share Projection (Stacked Bar)

**Purpose**: Show projected market share distribution after recommendations implemented

**Specifications**:
- **Two Bars**: "Current" and "Projected"
- **Segments**: Each brand (color-coded)
- **Values**: Market share percentages
- **Annotations**: Net change arrows between bars

**Data**:
| Brand | Current | Projected | Change |
|-------|---------|-----------|--------|
| sunlight core | 49.90% | 48.88% | -1.02% |
| mama core | 28.75% | 29.27% | +0.52% |
| mama cplus | 8.77% | 9.11% | +0.34% |
| wings ekonomi cplus | 6.78% | 6.99% | +0.21% |
| sunlight cplus | 0.58% | 0.59% | +0.02% |
| others cplus | 5.23% | 5.17% | -0.06% |

---

## Chart Generation Notes

**Tools Required**:
- Python: `matplotlib`, `seaborn`, `plotly` for interactive versions
- Or: PowerPoint native charts with data import
- Or: Power BI for interactive dashboard

**Data Transformations Needed**:
1. Merge brand-level and PPG-level data on Brand key
2. Calculate Price Index = (Current Price / MCV) × 100
3. Generate RPI curve points from elasticity formulas
4. Aggregate competitive elasticities into network format

**Template Considerations**:
- Use consistent color palette across all charts
- Ensure brand colors are distinct and accessible
- Include data source citations on each chart

---

## Next Steps (v2)

1. Generate actual chart images using `matplotlib`/`plotly`
2. Create PowerPoint slides with chart placements
3. Write narrative transitions between sections
4. Add executive summary slide with key callouts
5. Review with domain expert for business context validation

---

## References

- Input data: `parsed_data/Agentic AI - Documents/Data_Sharing/Masked_Example/`
- Workflow spec: `workflows/presentation-generation.md`
- CSF methodology: `parsed_data/Agentic AI - Documents/CSF_ReadMe/text.txt`
