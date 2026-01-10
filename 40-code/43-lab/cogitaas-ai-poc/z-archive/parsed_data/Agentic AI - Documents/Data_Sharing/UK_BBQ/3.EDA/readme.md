# Parsing for 3.EDA
File type: Power BI (.pbix)
Tools used: zipfile (Python standard), xmltodict for XML to JSON conversion
Process: Treated as ZIP file, extracted DataModelSchema.pbism XML and converted to JSON.
Output files:
- data.json: JSON representation of the data model schema
