## Workflows overview

The Consumer Surplus Factor (CSF) workflow follows these stages:

- Average case: 3-4 channels with 5-6 brands each
- Variants (product flavors/sizes) may increase complexity and time
 1. Data Collection - IRI, Nielsen, IMRB, in-house
  data, promo calendars
 2. Data Preparation - Scope identification and
 modeling-ready data preparation
 3. EDA and Data Validation - Power BI or webapp
 dashboards
 4. Modelling - Feature creation, model building
 5. Model Selection - Statistical filtering and
 business context selection
 6. Results and Outputs - MCV, CSF, MSPs
 calculation, RPI curves
 7. Presentation - PowerPoint generation
 8. Scenario Planner - Strategic planning

Scope of project depends on num of chanels and brands

- Average case = Usually 3-4 channels + Each channel has 5-6 brands
- Sometimes we have variants in the scope, that will increase the time

  

### 1. Data Collection
- **Inputs**:
  - Third-party data from IRI, Nielsen, IMRB
  - In-house sales data
  - Promo calendars
  - Example: `Data_Sharing/UK_BBQ/1.Raw_Data/`
- **Process**:
  - Gather raw sales and market data from multiple sources
  - Collect promotional activity calendars
- **Outputs**:
  - Raw CSV files organized by channel and time period
- **Notes**:
  - Scope typically includes 3-4 channels with 5-6 brands each
  - Variants (product flavors/sizes) may increase complexity

### 2. Data Preparation
- **Inputs**:
  - Raw CSV files from Data Collection
  - Business scope definitions
- **Process**:
  - Scope identification and validation
  - Data cleaning and transformation
  - Creating modeling-ready datasets
- **Outputs**:
  - Processed and validated data files
  - Example: `Data_Sharing/UK_BBQ/2.Predefined_Data_for_EDA_and_Modelling/`
- **Notes**:
  - Critical data quality checks performed here
  - Time taken: 2-3 hours

### 3. EDA and Data Validation
- **Inputs**:
  - Prepared data from previous stage
- **Process**:
  - Exploratory data analysis
  - Create interactive dashboards
  - Client review and feedback iterations
- **Outputs**:
  - Power BI dashboards or webapp visualizations
  - Example: `Data_Sharing/UK_BBQ/3.EDA/`
- **Notes**:
  - Often requires back-and-forth with client
  - Time taken: < 1 hour per iteration

### 4. Modelling
- **Inputs**:
  - Validated data from EDA stage
- **Process**:
  - Feature engineering and creation
  - Model building using various statistical methods
- **Outputs**:
  - Model features file: `4.Model_Features.csv`
  - Multiple model selection options
  - Example: `Data_Sharing/UK_BBQ/4.Model_Features/`
- **Notes**:
  - Time taken: 5-6 hours average
  - Varies based on project scope

### 5. Model Selection
- **Inputs**:
  - Model selection CSV from previous stage
  - Example: `5.Model_Selection/` files
- **Process**:
  - Statistical filtering of models
  - Business context evaluation
  - Expert review and annotation
- **Outputs**:
  - Annotated model selection file with yes/no decisions
  - Example: `Data_Sharing/UK_BBQ/5.Model_Selection/`
- **Notes**:
  - Most time-intensive stage
  - Time taken: 8-16 hours average

### 6. Results and Outputs
- **Inputs**:
  - Selected models from previous stage
- **Process**:
  - Calculate MCV (Marginal Cost of Verification)
  - Calculate CSF (Consumer Surplus Factor)
  - Generate MSPs (Marginal Selling Prices)
  - Create RPI (Relative Price Index) curves
- **Outputs**:
  - Brand-level results
  - PPG (Price Positioning Guide) if in scope
  - Example: `Data_Sharing/UK_BBQ/6.Brand_Level_Results/`
- **Notes**:
  - Automated calculations from selected models
  - Time taken: < 1 hour

### 7. Presentation
- **Inputs**:
  - Results from previous stage
  - EDA outputs as needed
- **Process**:
  - **Step 1**: Pricing power analysis
    - Healthy (high pricing power)
    - Unhealthy (low pricing power)
    - Average
  - **Step 2**: Strategic recommendations
    - Increase/Decrease/Stay the same
  - **Breakdowns**: By packs, variants, channels
  - Create supporting charts and narratives
- **Outputs**:
  - PowerPoint presentation with story and insights
  - Example: `Data_Sharing/UK_BBQ/7.Presentation/`
- **Notes**:
  - Most labor-intensive deliverable
  - Iterative brand-by-brand analysis
  - Time taken: 1 week average

### 8. Scenario Planner
- **Inputs**:
  - Same inputs as presentation stage
- **Process**:
  - Run scenario analysis code
  - Data entry and formatting
  - Create interactive planning tool
- **Outputs**:
  - Scenario planner Excel file
  - Example: `Data_Sharing/UK_BBQ/8.Scenario_Planner/`
- **Notes**:
  - Time taken: 2-3 hours for Excel, < 1 hour for web app

### Ad-hoc Q&A
- **Inputs**:
  - Completed analysis results
  - Client questions after review
- **Process**:
  - Address client queries
  - Provide additional insights
- **Notes**:
  - Typically occurs 3-4 months after delivery


