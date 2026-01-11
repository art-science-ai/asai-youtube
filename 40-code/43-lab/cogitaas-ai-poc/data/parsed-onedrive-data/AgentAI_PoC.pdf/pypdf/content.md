
## Page 1

Agent AI PoC – topic choice 
This document provides a brief overview on the chosen topic for developing and exploring 
machine intelligence. 
Background 
Cogitaas has developed a method for determining consumers’ willingness to pay for a brand.  
This method has been used by hundreds of brands across the globe to guide their strategic 
pricing decisions. Details of this approach is explained in a series of steps from data to 
decisions. 
Approach 
• Step-1: Data processing  
o Process 
▪ Data required for our pricing analytics is obtained from our clients. The 
data comprises of 2- or 3-year weekly time series data on volume sales, 
price, distribution (product availability), along with competition sales 
and distribution. 
▪ This data is available at different granularities - brand/variant/pack 
group, for analysis. The raw data is converted into a model ready format. 
o Automated/ human intervention?  
▪ yes, once the data is received, it is sent through a code to transform it 
into a model ready format 
▪ no human intervention is required in this step. 
• Step-2: Exploratory Data Analysis (EDA) 
o Process 
▪ Multiple line charts and bar charts are created for understanding market 
context and for creation of hypotheses. 
o Automated/human intervention 
▪ The process is automated; there is a code to prepare the required charts 
▪ Human intervention to understand these charts and to create 
hypotheses about the brand and its competitors. 
o Need of machine intelligence? 
▪ Maybe. It will be nice to have a summary based on data and charts along 
with some hypotheses on what may be happening to a brand. 
• Step-3: Modelling and validation 
o Process 
▪ Forms the core of the analysis. This step is a series of variable 
transformations, cleaning, creation of new variables to include all 
possible variable combinations and ends with an ensemble modelling 
approach. 
▪ Statistical hygiene checks and model selection is performed in this step. 
The output of this step is a final set of models that are statistically valid. 
▪ These models are fed into a planner for determining business outputs. 
o Automated/ human intervention? 
▪ Process from data transformation to final set of statistically valid models 
is automated. 


## Page 2

▪ On this valid set of models another round of filter is applied by a human 
combining business sense checks, EDA and planner results 
o Need of machine intelligence? 
▪ Ideally yes, but it will be too complicated at this stage of exploration. 
• Step-4: Business recommendations and storyline 
o Process 
▪ The model outputs are woven into a narrative to form a story. 
▪ It is about landing the model recommendations in a business-friendly 
language with reasons. 
▪ Kind of a structured output.  
o Automated/human intervention? 
▪ No automation. Completely manual and time consuming 
o Need of machine intelligence? 
▪ Yes, to reduce the time taken to build the narrative. Most likely choice for 
developing agent ai. 
 