# Parsing Office / BI Documents into Repo-Friendly Artifacts

Goal: reliably **extract** common document formats into a **structured, versionable folder** (CSV/JSON/assets) — with clarity on the trade-off between **visual fidelity** (what it looks like) and **semantic fidelity** (editable/searchable structure).

---

## PPTX (PowerPoint)

### Option 1 — **Text + assets → Markdown** (semantic-first)

* Use a PPTX→MD converter that:

  * extracts slide text into Markdown (titles, bullets)
  * extracts images into a folder and references them
* Best when: you want searchable, editable notes and can tolerate layout loss.

### Option 2 — **Render slides to images/PDF + Markdown index** (visual-first)

* Export slide visuals (PDF or one image per slide) and produce Markdown that references them.
* Best when: you want maximum “what it looked like” fidelity; MD is mostly an index/caption layer.

### Option 3 — **Programmatic generation/editing (template-driven)**

* Use a slide generation library (e.g., JS-based) to generate decks deterministically from data/templates.
* Best when: you control the deck authoring pipeline; less suitable for arbitrary round-tripping.

---

## DOCX (Word)

### Option 1 — **High-level library for common edits + extraction**

* Extract paragraphs, headings, tables, images into a folder representation.
* Best when: you mostly need content extraction and light edits.

### Option 2 — **DOCX → HTML/Markdown via conversion tool**

* Convert to HTML/MD for downstream processing.
* Best when: you want fast publishing / knowledge-base ingestion.
* Caveat: complex Word constructs (tracked changes, floats, advanced styles) can degrade.

### Option 3 — **OOXML (XML) “escape hatch” for fidelity**

* DOCX is a ZIP of XML parts; for tricky edits or exact preservation, modify specific XML parts.
* Best when: fidelity matters and libraries don’t support the specific feature.

---

## XLSX (Excel)

Markdown is usually the wrong “truth format”. Prefer:

* **values** (CSV/Parquet)
* **formulas** (sidecar)
* **types & formats** (sidecar)
* **merges, dimensions, names** (sidecar)
* **images/charts** (assets + metadata; often also a PDF snapshot)

### Option 1 — **Data + formulas export with a workbook library** (semantic-first)

* Read workbook structure and export per sheet:

  * `values.csv`
  * `formulas.csv` (same shape)
  * `meta.json` (formats/types/merges/row/col sizes/names)
  * `media/` (embedded images)
* Best when: version control & diffing matter.

### Option 2 — **Engine-based export for visuals + data export** (visual-first)

* Export workbook/sheets to **PDF** for chart/layout fidelity.
* Also export sheet data to CSV.
* Best when: charts/formatting must be preserved visually; you still want data usable.

### Option 3 — **“Unzip-first” for assets** (pragmatic supplement)

* XLSX is a ZIP; you can extract embedded media from `xl/media/` and relationships for mapping.
* Best when: you primarily want embedded images and don’t need full workbook semantics.

---

## PBIX (Power BI)

PBIX includes:

* **report layout/visual definitions**
* **semantic model** (tables, measures)
* **Power Query (M) mashup**

### Option 1 — **Extract-to-folder toolchain (source-control-first)**

* Use a PBIX project extraction tool that produces a structured folder for version control and diffs.
* Best when: you want a repo-friendly representation and collaboration workflows.

### Option 2 — **Model/query introspection library**

* Parse PBIX to extract:

  * model metadata
  * query (M) definitions
  * possibly tables
* Best when: your goal is analysis, governance, or building a downstream data/model pipeline.

### Option 3 — **Container inspection (ZIP-level)**

* Treat PBIX as a container for inspection and targeted extraction.
* Best when: debugging / forensics; avoid manual edits unless you deeply understand internals.

---

## Recommendation Pattern

For each doc type, pick two artifacts:

1. **Semantic artifact** (diffable/searchable)

* PPTX: Markdown text + extracted images
* DOCX: Markdown/HTML text + extracted images/tables
* XLSX: CSV/Parquet + formulas + JSON metadata
* PBIX: extracted project folder + model/query metadata

2. **Visual truth artifact** (faithful rendering)

* PPTX: slide images or PDF
* DOCX: PDF
* XLSX: PDF (especially for charts)
* PBIX: export screenshots/PDF (when needed) + extracted folder

This “dual artifact” approach keeps both fidelity types without forcing Markdown/JSON to encode complex layout.

