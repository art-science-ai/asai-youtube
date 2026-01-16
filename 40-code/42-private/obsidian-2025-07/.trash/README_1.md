# AI Notes Zettelkasten Vault

## Overview

A minimal, durable Obsidian setup for an **AI‑assisted Zettelkasten**. It moves from external sources → structured ideas → published outputs, while preserving provenance and dense interlinking.

**Benefits**
- **Speed**: AI agents handle ingestion, summaries, and first‑pass idea generation.
- **Integrity**: verbatim content preserved alongside interpretation; every claim cites sources with precise locations.
- **Composability**: writing assembles "evidence packs" (Ideas) into Projects without touching Sources.

---
## Usage
Note: I recommend using Gemini, especially for longer form content because it's much cheaper. Use headless mode which can be further automated with bash scripts or more sophisticated automation tools.

```bash
## Claude Code - Interactive
claude
@web-content-extractor SOURCE_URL

## Claude Code - Headless
claude -p "use web-content-extractor agent to extract SOURCE_URL" --dangerously-skip-permissions --verbose

## Gemini CLI - Interactive
gemini
Extract SOURCE_URL by following the instructions in @web-content-extractor

## Gemini CLI - Headless
cat .claude/agents/web-content-extractor.md | gemini -p "SOURCE_URL" -y

## Opencode - Interactive
opencode
@web-content-extractor SOURCE_URL

## Opencode - Headless
opencode run "SOURCE_URL" --model "opencode/grok-code" --agent "web-content-extractor"
```

---

## AI Agents

This vault uses Claude Code agents to automate workflow stages:

### Active Agents

- **`web-content-extractor`** — Ingests YouTube videos and web articles, extracting metadata, transcripts/text, and generating AI summaries. Creates complete Source notes in `21-zettel-sources/`. See `.claude/agents/web-content-extractor.md`

### Planned Agents

- **`idea-generator`** — Analyzes Sources to extract scoped claims, find supporting evidence with precise timestamps/pages, and create interconnected Idea notes.
- **`project-assembler`** — Helps assemble ready Ideas into Project outlines, identifies gaps in evidence, and suggests counterpoints to address.

> Agents are invoked automatically by Claude Code when you provide URLs or request specific tasks. You can also invoke them manually via the Task tool.

---

# Workflows

This section defines the **lifecycle** (states + transitions), then details each stage with **Input → Process → Output / State changes**. Keep it simple; specific tools can evolve later.

## Lifecycle overview

```
[Inbox]
   |
   v
[Ingest via web-content-extractor agent]
   |
   v
[Source (status: drafted → reviewed)]
   |    (contains metadata, summaries, AND verbatim content)
   |
   | cites (with precise time/page markers)
   v
[Idea (status: drafted → reviewed)]
   |    (scoped claims with evidence + sideways links)
   |
   v
[Project (status: backlog → draft → published)]
```

### State model (at a glance)
- **Source**: `drafted → reviewed` (metadata + summaries + verbatim content)
- **Idea**: `drafted → reviewed` (claims with multi-source evidence)
- **Project**: `backlog → draft → published` (published deliverables)

> Write from **Ideas**, not directly from **Sources**. This keeps drafts stable if source summaries change.

---

## 1) Inbox capture

**Input**
A link + one‑line why‑it‑matters.

**Process**
Create a minimal Inbox note (or task) holding `original_url`.

**Output / State changes**
Triggers **Ingest**.

---

## 2) Ingest → Source

**Input**
`original_url` (YouTube video or web article).

**Process**
Use the `web-content-extractor` agent to:
- Fetch/transcribe content (via yt-dlp for YouTube, WebFetch for articles)
- Extract metadata (title, author, date, etc.)
- Generate AI summaries (TLDR, key ideas, detailed summary, quotes)
- Preserve verbatim content in Raw section

**Output / State changes**
- **Source**: `status: drafted` — Single note containing metadata, AI summaries, and verbatim content.
- Saved to `21-zettel-sources/src {title-slug}.md`

---

## 3) Ideas (generate + harden)

**Input**
One or more **Source** notes with precise time/page markers.

**Process**
*(Planned: `idea-generator` agent will automate initial extraction)*

For each Idea:
- Write a **scoped claim** (one crisp sentence)
- Add ≥1 **Support** with precise location (`00:11:23` or `p.217`)
- Add ≥1 **sideways link** to an existing Idea
- Run **reuse check** (search 2–3 phrasings + antonyms):
  - Same claim & scope ⇒ reuse existing; append evidence
  - Narrower ⇒ new Idea **refines →** parent
  - Opposing ⇒ new Idea **challenges ↔** sibling
  - Mere quote ⇒ keep in Source; don't mint Idea
- Raise to **ready**: clear claim; (≥2 supports OR 1 support + 1 challenge); ≥2 sideways links

**Output / State changes**
- **Idea**: `∅ → drafted → reviewed`
- Saved to `30-ideas/idea {claim-slug}.md`

---

## 4) Project (assemble → publish)

**Input**
A set of **ready** Ideas.

**Process**
*(Planned: `project-assembler` agent will help with outline generation)*

- Create a **Project** with audience/purpose
- List 3–5 **claims to prove** and attach `ideas_used`
- Add ≥1 opposing Idea under `counterpoints_to_address`
- Map sections → specific Ideas (evidence packs)
- Draft and publish

**Output / State changes**
- **Project**: `backlog → draft → published`
- Record `published_url`, `published_date`
- Saved to `40-projects/project {slug}.md`

---

# Principles

Brief rules to keep the graph coherent and low‑entropy.

- **Provenance**: Sources contain both summaries AND verbatim content. All interpretation stays in AI notes section; raw content preserved separately.
- **Link topology**: Projects link to **Ideas**; Ideas cite **Sources** with precise locations (time/page). Avoid Project → Source links.
- **Sideways verbs (Idea ↔ Idea)**: `refines →`, `generalizes →`, `implies →`, `depends_on →`, `example_of →`, `challenges ↔`, `supports ↔`, `contrasts ↔`, `related ↔`.
- **Merge / split**: merge duplicates into canonical Idea (move evidence; add aliases; leave redirect). Split multi‑claim notes; connect with `related ↔` or `depends_on →`.
- **Guardrail**: no orphan Ideas — each must cite ≥1 Source **and** link to ≥1 sibling Idea.

---

# Organizational structure

Schemas, filenames, and folders to keep things searchable and consistent.

## Folder layout
- `.claude/agents/` — AI agent definitions for automating workflows
- `10-inbox/` — captured links and quick notes awaiting processing
- `21-zettel-sources/` — source notes (metadata + summaries + verbatim content)
- `30-ideas/` — multi‑source claims with evidence and sideways links
- `40-projects/` — deliverables assembling Ideas
- `90-templates/` — detailed note templates (see below)
- `91-workflows/` — manual workflow documentation

## Filenames
- Source: `src {title-slug}.md`
- Idea: `idea {claim-slug}.md`
- Project: `project {slug}.md`

> Prefer short, human‑readable slugs. Use lowercase with hyphens.

## Templates

Detailed templates with full schemas and examples are in `90-templates/`:

- **`template-source.md`** — Metadata, AI summaries, and verbatim content
- **`template-idea.md`** — Scoped claims with multi-source evidence and sideways links
- **`template-project.md`** — Deliverables assembling Ideas into published work

> Use these templates as references when creating notes manually or when reviewing agent-generated output.

## TODO
- [ ] Add validation and review to agents, and incorporate into note status (e.g. failed, low quality)
- [ ] Create idea agent; add idea strength / status based on how much support it has + human subjective input
- [ ] Entity creation agent: find entities in notes (e.g. people, places, organizations) and create new notes for them
