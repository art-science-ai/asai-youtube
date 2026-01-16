# Parsing for 1.Raw_Data
File type: Excel (.xlsx or .xlsm)
Tools used: openpyxl for loading workbook and extracting text, pandas for converting sheets to CSV
Process: Extracted text content from all cells in all sheets and saved to text.txt. Created sheets.csv with sheet names, row counts, and column counts. Saved each sheet as a separate CSV file.
Output files:
- text.txt: Concatenated text from all sheets
- sheets.csv: Summary of sheets
- {sheet}.csv: CSV for each sheet
