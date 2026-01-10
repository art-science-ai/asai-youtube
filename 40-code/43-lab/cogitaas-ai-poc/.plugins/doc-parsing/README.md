# Document Parsing Plugin

Parse proprietary Office and BI file formats (PowerPoint, Word, Excel, PDF, Power BI) into repository-friendly text artifacts. Uses multi-method extraction to ensure comprehensive content coverage.

## Supported file types

| Type | Extension | Methods | Primary Outputs |
|------|-----------|---------|-----------------|
| PowerPoint | `.pptx` | 4 | Markdown text, images, slide notes |
| Word | `.docx` | 4 | Markdown text, images, tables |
| Excel | `.xlsx` | 4 | CSV files, JSON metadata, formulas |
| PDF | `.pdf` | 4 | Markdown text, tables, layout info |
| Power BI | `.pbix` | 2 | JSON metadata, DAX measures, model structure |

## Installation

Install from gtd-cc marketplace:

```bash
/plugin marketplace add nikhilmaddirala/gtd-cc
/plugin install doc-parsing@gtd-cc
```

## Usage

### /parse-docs

Parse documents using natural language requests:

```bash
# Parse all supported files
/parse-docs Parse files from ./documents to ./parsed

# Parse specific file types
/parse-docs Parse PowerPoint and Word files from ~/presentations to ~/parsed

# Force reparse everything
/parse-docs Reparse everything from ./docs to ./output, force regenerate
```

The command extracts parameters from your request, copies parsing scripts to your project, adapts configuration, and executes the workflow.

## Current State and Improvements

### Current Approach

The parsing scripts currently use a multi-method strategy, running 4 methods per file type (except PBIX which uses 2). Each method produces outputs in its own subdirectory, allowing for comparison and selection of best extraction method. This approach provides comprehensive coverage but generates significant output volume.

### Analysis Results

Based on comprehensive review of parsed outputs from real CSF workflow documents, following observations were made:

#### Word Documents (.docx)

**Recommended method:** `python_docx_detailed`

**Why this works best:**
- Converts heading styles to proper Markdown headers (e.g., ## 1. Introduction)
- Extracts tables as both JSON and formatted Markdown tables
- Preserves document structure and semantic hierarchy
- Includes metadata (author, created/modified dates)
- Clean, diffable markdown format suitable for version control

**Issues with other methods:**
- `python_docx_basic`: Loses heading structure, treats all paragraphs equally
- `docx2txt`: Plain text without structure preservation
- `markitdown`: Failed on some test files (e.g., CSF_ReadMe.docx)

#### PDF Documents (.pdf)

**Recommended method:** `markitdown` (for text-heavy documents) or `pdfplumber` (for documents with tables)

**Why markitdown works best for AI understanding:**
- Removes page boundaries that interrupt document flow
- No "## Page X" headers that create noise for AI
- Produces continuous, natural markdown
- Clean structure preserves semantic meaning

**When to use pdfplumber:**
- Documents contain complex tables that need structured extraction
- Tables should be preserved as JSON for programmatic access
- Layout information is important for understanding document structure

**Issues with other methods:**
- `pypdf`: Adds page headers that disrupt reading flow
- `pdfminer`: Outputs plain text instead of markdown, harder to diff
- All methods except pdfplumber: Tables lost or poorly formatted

#### PowerPoint Presentations (.pptx)

**Recommended method:** `python_pptx_detailed`

**Why this works best:**
- Includes slide layout names (e.g., "1_Title Slide") providing context
- Captures speaker notes important for presentation understanding
- Preserves slide-by-slide structure with clear markdown headers
- Slide metadata JSON enables programmatic access to structure

**Advantages for AI:**
- Layout information helps understand presentation purpose
- Notes contain additional context not visible on slides
- Structured format enables slide-level analysis

**Issues with other methods:**
- `python_pptx_basic`: Missing layout and notes context
- `python_pptx_images`: Only images, no text content
- `markitdown`: Uses HTML comments instead of structured headers

#### Excel Spreadsheets (.xlsx)

**Recommended methods:** Combined approach using both `pandas_basic` and `pandas_detailed`

**Why pandas_basic for humans:**
- CSV files are universally readable and viewable
- Git can diff CSV files reasonably well
- Metadata.json provides schema information
- Standard format for data exchange

**Why pandas_detailed for AI:**
- Provides data type information for each column
- Includes statistical summaries (mean, std, min, max)
- Shows missing value counts to assess data quality
- Helps AI understand data structure and quality

**Complementary benefits:**
- CSVs for actual data access
- JSON for schema and statistics
- Both formats serve different purposes effectively

**Issues with other methods:**
- `openpyxl_structure`: JSON arrays harder to diff and read than CSVs
- `openpyxl_formulas`: Only useful for formula analysis, not data access

##### Additional Excel Parsing Methods Worth Considering

Based on research into Python Excel parsing ecosystem, several alternative methods offer advantages for specific use cases:

**markitdown** - Microsoft's Excel to Markdown converter
- Converts Excel tables directly to Markdown format
- Ideal for "docs as code" workflows
- Produces clean, diffable markdown tables
- Preserves table structure better than CSV for human reading
- Limitations: Doesn't preserve formulas or calculate values
- Use case: Documentation, wikis, static sites where Excel tables need to be version-controlled

**python-calamine** - Rust-based high-performance reader
- 18x faster than pandas for large files (benchmarks show significant speedup)
- Based on Rust calamine library with Apache Arrow backend
- Memory-efficient for large datasets
- Best for: Performance-critical workflows with large Excel files
- Trade-offs: Less mature than pandas/openpyxl, fewer features for writing
- Consider: When parsing 100K+ row Excel files where speed is critical

**polars** - Multi-threaded data processing with Excel support
- Faster than pandas for data loading and transformations
- Lazy evaluation reduces memory footprint
- Native Excel reading via `polars.read_excel()`
- Best for: Large datasets requiring data processing after loading
- Consider: When you need both fast loading and data transformation capabilities

**formulas (vinci1it2000/formulas)** - Excel formula interpreter
- Parses and compiles Excel formulas to Python
- Evaluates formulas without Excel installed
- Supports most Excel functions (450+ functions)
- Best for: Understanding business logic embedded in spreadsheets
- Output: AST representation of formulas, enabling analysis of dependencies
- Use case: Reverse-engineering Excel algorithms, validating formula logic

**xlcalculator** - Excel formula to Python converter with evaluation
- Converts Excel formulas to equivalent Python code
- Supports named ranges and cell references
- Evaluates formulas with original Excel semantics
- Best for: Extracting and testing spreadsheet logic
- Limitations: Doesn't support all Excel functions
- Consider: When you need to understand or validate formula calculations

**openpyxl with Table Support** - Structured table extraction
- Excel's "Insert > Table" feature creates semantic tables
- openpyxl can read table definitions (table name, columns, styles)
- Provides access to structured ranges beyond regular cell ranges
- Best for: Well-structured Excel files using table objects
- Advantages: Preserves table-level metadata (headers, totals, filters)
- Code: `from openpyxl.worksheet.table import Table`

**openpyxl with Named Ranges** - Extract defined names
- Named ranges capture business logic (e.g., "Sales_Data", "Input_Range")
- Provides semantic context beyond cell coordinates
- Can document ranges that span multiple sheets
- Best for: Complex workbooks with defined ranges and constants
- Code: `from openpyxl import defined_names`

**pyxlsb** - Binary Excel (XLSB) format reader
- XLSB is compressed binary format for very large workbooks
- More efficient than XLSX for big files
- Best for: Excel files saved in XLSB format
- Note: Niche use case, not commonly used unless files are very large

**xlwings** - Full Excel integration via COM
- Requires Excel installed (Windows/Mac only)
- Can extract charts, formatting, conditional formatting
- Access to all Excel features including macros
- Best for: Desktop automation scenarios, extracting visual elements
- Limitations: Platform-dependent, requires Excel installation, not suitable for servers

**MarkItDown for Excel** - CLI tool for Excel to Markdown conversion
- Command-line tool from Microsoft
- Converts entire workbooks to markdown with multiple sheets
- Generates table of contents linking to sheet sections
- Best for: Quick conversion of Excel docs to markdown for static sites
- Install: `pip install markitdown`

**Recommendations for "docs as code":**
1. **Primary**: Continue with `pandas_basic` + `pandas_detailed` for most use cases
2. **Supplemental**: Add `markitdown` method for Excel files that need markdown documentation
3. **Performance**: Use `python-calamine` for large files (100K+ rows) where speed matters
4. **Formulas**: Add `formulas` library method for workbooks with complex business logic
5. **Structured Data**: Use `openpyxl` with table support for files using Excel Table objects

**Comparison Summary:**

| Method | Best For | "Docs as Code" | Speed | Complexity | Excel Required |
|---------|-----------|-------------------|-------|-------------|----------------|
| pandas_basic | General data access | Good | Medium | Low |
| pandas_detailed | AI understanding | Good | Low | No |
| markitdown | Documentation | Excellent | Medium | No |
| python-calamine | Large files | Medium | Very Fast | No |
| polars | Data processing | Medium | Very Fast | No |
| formulas | Formula analysis | N/A | Medium | No |
| xlcalculator | Formula validation | N/A | Medium | No |
| openpyxl tables | Structured workbooks | Good | Medium | No |
| xlwings | Full extraction | Poor | Fast | Yes |

**Key Insights:**
- For typical CSF workflow Excel files (Model Selection results, predefined data): Current approach is optimal
- `markitdown` is missing from current implementation and would be excellent for documentation use cases
- For very large files (100K+ rows), `python-calamine` could provide 18x speedup
- Formula understanding requires specialized libraries beyond current implementation

#### Power BI Files (.pbix)

**Recommended method:** `pbixray`

**Why this works best:**
- Extracts semantic model structure (tables, measures, relationships)
- Exports tables as CSV files for data access
- Provides DAX expressions in readable format
- Captures the data model, which is what matters for AI understanding

**Advantages:**
- Understands PBIX internal structure better than raw extraction
- Preserves model relationships and dependencies
- Measure definitions include expressions and data types

**Issues with other methods:**
- `zipfile`: More useful for debugging than production parsing

### Proposed Improvements

#### 1. Select Primary Methods

Implement a configuration-based approach to select primary parsing methods for production use:

```yaml
# config/parsing.yaml
primary_methods:
  docx: python_docx_detailed
  pdf: markitdown  # or pdfplumber for tables
  pptx: python_pptx_detailed
  xlsx: pandas_basic  # with pandas_detailed for AI analysis
  pbix: pbixray
```

Benefits:
- Reduces output volume significantly
- Simplifies downstream processing
- Provides clear, consistent outputs
- Maintains ability to run all methods for comparison when needed

#### 2. Consolidation Script

Create a script that extracts only best outputs into a clean structure:

```python
# scripts/consolidate_parsed.py
"""
Extract best parsing outputs into a consolidated structure
optimized for 'docs as code' workflow.
"""
```

Consolidated structure:
```
docs-as-code/
  document_name/
    content.md          # Primary markdown content
    metadata.json       # Document metadata
    tables/            # Extracted tables (if any)
    images/            # Extracted images (if any)
    schema.json         # Data schema (for XLSX/PBIX)
```

#### 3. Add Documentation Files

Include a README.md in each parsed directory documenting:
- Which methods were used and why
- Parsing warnings or issues
- Any content limitations (e.g., missing images, corrupted tables)
- Timestamp and version information

Example:
```
CSF_ReadMe.docx/
  content.md
  metadata.json
  table_1.json
  PARSE_INFO.md       # New file
```

#### 4. Failure Tracking

Enhance parsing_results.json to track failures more comprehensively:

```json
{
  "timestamp": "2026-01-02T11:05:20",
  "methods": {
    "method1_python_docx_basic": {
      "success": true,
      "warning": null
    },
    "method2_markitdown": {
      "success": false,
      "error": "markitdown not available",
      "traceback": "..."
    }
  },
  "summary": {
    "total": 4,
    "successful": 3,
    "failed": 1,
    "primary_method": "python_docx_detailed"
  }
}
```

#### 5. Table Quality Assessment

Add validation for extracted tables to detect and handle:
- Empty cells vs. null values
- Merged cells that disrupt structure
- Headers in unexpected positions
- Inconsistent row counts

#### 6. Performance Optimization

For large document sets:
- Implement parallel parsing where methods are independent
- Cache results to avoid re-parsing unchanged files
- Provide progress indicators for long-running operations
- Support incremental updates (only changed files)

#### 7. AI-Friendly Enhancements

Add features specifically to improve AI understanding:
- Semantic section detection (identify document sections)
- Content summarization for quick previews
- Entity extraction (people, organizations, dates)
- Relationship mapping (cross-references between documents)

### Recommended Implementation Priority

1. **High Priority:**
   - Implement primary method selection via configuration
   - Create consolidation script for clean outputs
   - Add PARSE_INFO.md documentation files

2. **Medium Priority:**
   - Enhanced failure tracking in parsing_results.json
   - Table quality validation
   - Performance optimizations for large document sets

3. **Low Priority:**
   - AI-friendly enhancements (summaries, entity extraction)
   - Advanced table structure detection
   - Cross-document relationship mapping

### Future Considerations

- Support for additional file types (e.g., .vsdx, .pub, .mpp)
- Incremental parsing for large files (parse only changed sections)
- Real-time parsing with file watchers
- Integration with document management systems (SharePoint, Google Drive)
- Version-aware parsing (track changes across document versions)

