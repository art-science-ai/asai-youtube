## Parsing file types

Cogitaas uses a variety of closed or proprietary file formats like docx, pptx, xlsx, pbix, etc. We need a variety of tools to help with parsing such file types.

Local tools for parsing/extracting text/data (CLI or scriptable; install via nix for CLI or uv for Python scripts). For binary files (docx, pptx, pdf, pbix), prioritize text extraction.

- **csv**:
  - csvkit: CLI tool for CSV manipulation (Python-based). Install: `nix run nixpkgs#csvkit`. Example: `csvjson input.csv > output.json` (converts to JSON). Pros: Flexible ETL, handles large files. Cons: Requires Python runtime.
  - awk: Shell command for text processing. Install: Built-in or `nix run nixpkgs#awk`. Example: `awk -F',' '{print $1}' input.csv` (prints first column). Pros: Fast, no dependencies. Cons: Less structured for complex CSV.
  - pandas: Python script for dataframes. Install: `uv add pandas`. Example: `import pandas as pd; df = pd.read_csv('input.csv'); print(df.head())`. Pros: Powerful analysis. Cons: Python-only.

- **xlsx**:
  - openpyxl: Python library for reading/writing. Install: `uv add openpyxl`. Example: `from openpyxl import load_workbook; wb = load_workbook('file.xlsx'); print(wb.active['A1'].value)`. Pros: Native Excel support, handles xlsm. Cons: Python-only.
  - Apache POI (Java): Library for Office files. Install: `nix run nixpkgs#apache-poi`. Example: Java script (e.g., `java -cp poi.jar YourParser input.xlsx`). Pros: Cross-platform via JVM. Cons: Java setup required.
  - xlrd: Python for legacy Excel. Install: `uv add xlrd`. Example: `import xlrd; wb = xlrd.open_workbook('file.xls'); print(wb.sheet_by_index(0).cell(0,0).value)`. Pros: Simple. Cons: Read-only, older formats.

- **xlsm**: Same as xlsx (openpyxl handles macros; e.g., `wb = load_workbook('file.xlsm', keep_vba=True)`).

- **pptx**:
  - pandoc: CLI converter to text/markdown. Install: `nix run nixpkgs#pandoc`. Example: `pandoc input.pptx -t plain -o output.txt`. Pros: Fast, preserves structure. Cons: No images/tables.
  - python-pptx: Python for manipulation. Install: `uv add python-pptx`. Example: `from pptx import Presentation; prs = Presentation('file.pptx'); for slide in prs.slides: print(slide.shapes.title.text)`. Pros: Full control. Cons: Python-only.
  - LibreOffice (CLI): Office suite converter. Install: `nix run nixpkgs#libreoffice`. Example: `libreoffice --headless --convert-to txt input.pptx`. Pros: Handles complex layouts. Cons: Slower, full suite.

- **docx**:
  - pandoc: CLI converter. Install: `nix run nixpkgs#pandoc`. Example: `pandoc input.docx -t plain -o output.txt`. Pros: Quick text extraction. Cons: Loses formatting.
  - python-docx: Python library. Install: `uv add python-docx`. Example: `from docx import Document; doc = Document('file.docx'); for para in doc.paragraphs: print(para.text)`. Pros: Detailed parsing. Cons: Python-only.
  - Apache POI: Java library. Install: `nix run nixpkgs#apache-poi`. Example: Java script for text extraction. Pros: Robust. Cons: Java setup.

- **pdf**:
  - pdftotext: CLI from poppler. Install: `nix run nixpkgs#poppler_utils`. Example: `pdftotext input.pdf output.txt`. Pros: Fast text extraction. Cons: No tables/images.
  - PyPDF2: Python library. Install: `uv add PyPDF2`. Example: `import PyPDF2; pdf = PyPDF2.PdfReader('file.pdf'); print(pdf.pages[0].extract_text())`. Pros: Scriptable. Cons: Python-only.
  - pdfplumber: Python for tables. Install: `uv add pdfplumber`. Example: `import pdfplumber; with pdfplumber.open('file.pdf') as pdf: print(pdf.pages[0].extract_text())`. Pros: Layout-aware. Cons: Heavier.

- **pbix**:
  - pbixray: Python library. Install: `uv add pbixray`. Example: `import pbixray; data = pbixray.parse('file.pbix'); print(data['metadata'])`. Pros: Extracts VertiPaq. Cons: Python-only, niche.
  - jq: CLI JSON processor (after unzip). Install: `nix run nixpkgs#jq`. Example: `unzip file.pbix; jq '.report.layout' Report/Layout`. Pros: Fast JSON queries. Cons: Manual unzip.
  - unzip + python: Script to unzip and parse JSON. Install: Built-in unzip, `uv add` for script. Example: `import zipfile, json; z = zipfile.ZipFile('file.pbix'); data = json.load(z.open('Report/Layout'))`. Pros: Flexible. Cons: Custom script.
