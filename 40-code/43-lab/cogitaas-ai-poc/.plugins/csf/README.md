# Consumer Surplus Factor (CSF) Workflow

## Overview

The Consumer Surplus Factor (CSF) workflow is an 8-stage analytical process that helps determine optimal pricing strategies for products by measuring the gap between consumer willingness to pay (Maximum Consumer Value - MCV) and current selling prices.

**Typical Scope**: 3-4 channels with 5-6 brands each. Variants (product flavors/sizes) may increase complexity and time.

---

## The 8 Stages

### Stage 1: Data Collection

**Purpose**: Gather raw sales and market data from multiple sources

**Inputs**:
- Third-party data from IRI, Nielsen, IMRB
- In-house sales data (primary or secondary)
- Promotional calendars

**Process**:
- Collect raw CSV files organized by channel and time period
- Gather promotional activity calendars

**Output**: Raw data files (e.g., `1.Raw_Data.xlsx`)

**Time**: Varies by data availability

---

### Stage 2: Data Preparation

**Purpose**: Transform raw data into modeling-ready format

**Inputs**:
- Raw CSV files from Stage 1
- Business scope definitions

**Process**:
- Scope identification and validation
- Data cleaning and transformation
- Standardize fields (pack sizes, time fields)
- Handle missing/duplicate/incorrect values
- Retain only in-scope channels, brands, variants, PPGs
- Group out-of-scope items under "RestOfCategory" or "Others"

**Output**: Processed and validated data (e.g., `2.Predefined_Data for EDA and Modelling.csv`)

**Time**: 2-3 hours

**Critical Note**: The entire modelling pipeline is automated and requires data in a fixed column structure.

---

### Stage 3: EDA and Data Validation

**Purpose**: Explore data, validate insights with client

**Inputs**:
- Prepared data from Stage 2

**Process**:
- Create interactive Power BI dashboards or webapps
- Review market trends, share, price, distribution
- Validate insights with client (Brand Managers, Category Managers)
- Iterate based on client feedback (may modify scope, add visualizations)

**Output**: Power BI dashboards or webapp visualizations (e.g., `3.EDA.pbix`)

**Time**: <1 hour per iteration

---

### Stage 4: Modelling

**Purpose**: Build statistical models to understand price-demand relationships

**Inputs**:
- Validated data from Stage 3

**Process**:
- **Feature Engineering**:
  - Dependent variable (Y): Volume or Vol Kalman (smoothed volume)
  - Independent variables (X): Price, relative price, distribution, competitive price, trend, seasonality

- **Model Building**:
  - Build 5 different models:
    1. SOLS
    2. Ridge
    3. Lasso
    4. Bayesian Ridge
    5. Bayesian Lasso

**Output**: Model features file (e.g., `4.Model_Features.csv`) with multiple model selection options

**Time**: 5-6 hours average

---

### Stage 5: Model Selection

**Purpose**: Select the best-fit model based on statistical and business criteria

**Inputs**:
- Model selection files from Stage 4

**Process**:
- **Statistical Filtering**:
  - Check price p-value must be significant
  - Verify price elasticity is negative (as expected)
  - Check distribution elasticity is positive
  - Compare Adjusted R², AIC, model stability

- **Business Context Evaluation**:
  - Ensure model aligns with known market trends
  - Validate meaningful market share for brands

- **Expert Review**: Annotate with yes/no decisions

**Output**: Annotated model selection file (e.g., `5.Model_Selection.xlsx`)

**Time**: 8-16 hours average (most time-intensive stage)

---

### Stage 6: Results and Outputs

**Purpose**: Calculate key pricing metrics from selected models

**Inputs**:
- Selected models from Stage 5

**Process**:
- **Calculate Key Metrics** at scope level (brand/variant/PPG):
  - **MCV** (Maximum Consumer Value): Highest price most loyal consumers will pay
  - **CSF** (Consumer Surplus Factor): MCV / Price (measures pricing power)
  - **MSP** (Market Share Potential): Potential share change at optimal price
  - **RPI** (Relative Price Index): Curve showing market share response to price changes
  - **Inflection Point**: Price level where MSP becomes zero

**Output**: Brand-level results (e.g., `6.Brand_Level_Results.csv`) and RPI curve files

**Time**: <1 hour (automated calculations)

---

### Stage 7: Presentation Generation

**Purpose**: Transform quantitative results into stakeholder-ready PowerPoint presentation

**Inputs**:
- Results from Stage 6
- EDA outputs from Stage 3

**Process** (broken into three parts):
- **7a) Interpretation of Results**: Analyze CSF, price elasticity, market share, and competitive positioning
- **7b) Generate Presentation Plan**: Create list of required charts and narrative sections
- **7c) Execute Presentation**: Build PowerPoint with data-driven stories and strategic recommendations

**Output**: PowerPoint presentation (e.g., `8.Presentation.pptx`)

**Time**: ~1 week manual (target: 2-4 hours with AI assistance)

**See**: `presentation-generation.md` for detailed workflow

**Implementation**: Stage 7a is automated via the `interpret-results` skill in `skills/interpret-results/`

---

### Stage 7a Implementation Notes

**Status**: Skill implemented and working with known issues documented below

**Location**: `.plugins/csf/skills/interpret-results/`

**What it does**:
- Automates CSV → YAML transformation with deterministic categorizations
- Applies CSF, PE, and MSP interpretation rules
- Generates competitive comparisons and market position analysis
- Creates structured YAML ready for presentation planning (Stage 7b)

**Known Issues** (high priority to address):

1. **PE Categorization Threshold Bug**
   - Script uses `-7.0` but documentation specifies `-8.0`
   - Impact: PE values between -7.0 and -8.0 are misclassified
   - File: `scripts/interpret_results.py` line 107

2. **Missing CSV Schema Validation**
   - Script assumes column names exist without validation
   - Impact: Cryptic errors if CSV has different structure
   - Fix: Add required columns check at start of `process_csv()`

3. **CSF Threshold Edge Cases**
   - 0.01 difference can change category (1.69 → low, 1.70 → medium)
   - Consider: Document if thresholds are business-validated or add buffer zones

4. **Competitor Narrative Hard Limit**
   - Only shows first 3 competitors in narratives
   - Impact: In channels with many brands, important context may be hidden
   - File: `scripts/interpret_results.py` lines 235, 240

**Documentation Issues**:

5. **Example YAML is Truncated**
   - `examples/uk_bbq/output-2.yaml` only shows 1 of 4 channels
   - Could mislead users about full output structure

6. **Two-Output Terminology Confusing**
   - "Output 1" and "Output 2" not self-documenting
   - Consider: `interpretation-deterministic.yaml` and `interpretation-enhanced.yaml`

**Validation Checklist** for new projects:
- [ ] Verify PE threshold matches business rules (-4/-8 or -4/-7?)
- [ ] Confirm CSF thresholds (1.7/2.0) are appropriate for market
- [ ] Check CSV columns match expected names
- [ ] Review competitor count per channel (if >6, narratives truncate)
- [ ] Spot-check categorizations against manual calculations

---

### Stage 8: Scenario Planner

**Purpose**: Interactive tool for pricing scenario evaluation

**Inputs**:
- Same inputs as Stage 7

**Process**:
- Run scenario analysis code
- Data entry and formatting
- Create interactive planning tool with three sections:
  - **Current**: Present situation (MS, CSF, financial metrics)
  - **Projected**: Expected outcome if conditions unchanged
  - **Simulated**: User can change inputs (price, margin) to see impact on MS, volume, revenue, contribution

**Output**: Scenario planner Excel file (e.g., `11.Scenario_Planner.xlsm`) or webapp

**Time**: 2-3 hours for Excel, <1 hour for webapp

---

### Ad-hoc Q&A

**Purpose**: Address client questions after initial delivery

**Timing**: Typically 3-4 months after delivery

---

## Key Metrics Reference

| Metric | Definition | Interpretation |
|--------|------------|----------------|
| **MCV** | Maximum Consumer Value | Highest price loyal consumers will pay |
| **CSF** | Consumer Surplus Factor = MCV / Price | Measure of pricing power/value left on table |
| **MSP** | Market Share Potential | Potential share change at optimal price |
| **RPI** | Relative Price Index | Curve showing MS response to price changes |
| **PE** | Price Elasticity | Sensitivity of demand to price changes |

## CSF Threshold Guidelines

| CSF Range | Category | Action |
|-----------|----------|--------|
| CSF > 2.3 | Healthy (high pricing power) | Can increase price |
| CSF 1.8-2.2 | Optimal | Hold current price |
| CSF < 1.6 | Unhealthy (low pricing power) | Consider price decrease |

## File Naming Convention

Files are numbered sequentially to indicate workflow stage:
- `1.Raw_Data` - Stage 1 output
- `2.Predefined_Data for EDA and Modelling` - Stage 2 output
- `3.EDA` - Stage 3 output
- `4.Model_Features` - Stage 4 output
- `5.Model_Selection` - Stage 5 output
- `6.Brand_Level_Results` - Stage 6 output
- `7.Presentation` (or `8.Presentation` in some cases) - Stage 7 output
- `8.Scenario_Planner` (or `11.Scenario_Planner`) - Stage 8 output

---

## References

### Main Documentation
- `presentation-generation.md` - Overview of Stage 7 (all sub-stages)
- `presentation-planning.md` - Detailed Stage 7b workflow
- `presentation-execution.md` - Detailed Stage 7c workflow

### Skills
- `skills/interpret-results/SKILL.md` - Stage 7a automated interpretation skill
- `skills/interpret-results/examples/uk_bbq/` - Working example with CSV → YAML transformation

### Methodology
- `parsed_data/CSF_ReadMe.docx/` - Complete methodology documentation
- `parsed_data/Summary.docx/` - CSF interpretation rules and decision logic
- `Data_Sharing/full_examples/` - Complete example projects (UK_BBQ, UK_BrownSauce, US_Spoonables)
- `Data_Sharing/masked_examples/` - Anonymized examples for AI workflow testing
