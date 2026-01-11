## Overview
- This is a presentation using the marp framework

## Marp
- We will create the presentation in a markdown file and export to PDF / HTML for presentation
- References
  - [marp-team/marp: The entrance repository of Markdown presentation ecosystem](https://github.com/marp-team/marp)
  - [marp-team/marpit: The skinny framework for creating slide deck from Markdown](https://github.com/marp-team/marpit)
  - [marp-team/marp-cli: A CLI interface for Marp and Marpit based converters](https://github.com/marp-team/marp-cli)

## Presentation structure

### Overall organization
- Each bullet in the outline / table of contents should correspond to 1 slide or 2 slides
- Every alternate slide should ideally include an image or diagram or quote or something
- Follow practices of making engaging presentations

### Table of Contents & Agenda slides
- **Main agenda slide**: Include a complete nested outline in an HTML comment block showing all sections and subsections with numbering (e.g., 1.1, 1.2, 2.1, etc.)
- **Section agenda slides**: Each major section should have its own agenda slide listing its subsections with numbers
- **Synchronization**: All individual slide headers must exactly match their corresponding TOC/agenda items (same wording and numbering)

### Slide numbering & headers
- Use hierarchical numbering: `### 1.1 Topic name`, `### 2.3 Another topic`, etc.
- Slide headers should follow the pattern: `### X.Y Descriptive title`
- For historical/temporal content: Include time periods in headers (e.g., `### 1.3 Rule-based era (1950s-2000s): GOFAI, Expert Systems, Logic`)
- When a topic requires multiple slides: Use `(continued)` suffix for subsequent slides (e.g., `### 1.2 Birth of AI (continued)`)

### Comments & speaker notes
- Use HTML comment blocks `<!-- ... -->` for speaker notes on individual slides
- Speaker notes should guide what to say or demo during that slide
- The full outline in the main agenda slide comment serves as a quick reference map

### Frontmatter settings
- Specify theme in frontmatter (e.g., `theme: rose-pine-moon`) and ensure `.marprc` points to the theme

### Markdown header levels

Use a three-tier hierarchy for clear visual structure:

**H1 (`#`)** - Title slide only
- Used once at the beginning of the presentation
- Example: `# The Art and Science of AI for Cogitaas`

**H2 (`##`)** - Structural/navigational slides
- Main agenda slide: `## Agenda`
- Section headers (combined with section agenda): `## 1. The Science of how AI works`
- Special closing slides: `## References`, `## Q&A`, `## Thank You`
- These create visual breaks and help audience navigate

**H3 (`###`)** - Content slides
- All numbered topic slides with hierarchical numbering
- Pattern: `### X.Y Topic name` or `### X.Y Topic name (temporal context)`
- Examples:
  - `### 1.1 Ancient dreams: Myths, magic, machines`
  - `### 2.4 AI agents: autonomous orchestration of workflows`
  - `### 1.3 Rule-based era (1950s-2000s): GOFAI, Expert Systems, Logic`

**H4-H6** - Not used
- Avoid deeper heading levels in presentations
- Use bullet points, bold text, or visual hierarchy within H3 slides instead

### Content formatting

**Text formatting conventions:**
- **Bold (`**text**`)**: Use for category labels, key terms, and bullet point headers
- *Italics (`*text*`)`: Use for foreign words, proper names, book/paper titles, and emphasis
- Code (`` `text` ``): Use for technical terms, code snippets, file names (primarily in technical sections)
- Keep formatting consistent throughout the presentation

**Bullet point style:**
- Always use `*` for bullet points (renders with better animation in Marp)
- Avoid using `-` for bullets to maintain consistency
- Sub-bullets should also use `*` with proper indentation
- **Exception - Numbered lists**: Use plain numbered list syntax (`1.`, `2.`, `3.`) without `*` when you need sequential numbering (e.g., main Agenda slide)
  - Reason: Marp interprets `* 1.` as a styled ordered list (may render as Roman numerals)
  - Use `* 1.1`, `* 1.2` for hierarchical numbering (these render correctly as bullets since `1.1` isn't valid ordered list syntax)

### Slide length guidelines

**Half-slide** (with image or diagram on ~50% of slide):
- **50-60 words maximum**
- Typically 3-4 bullets
- ~15-18 words per bullet

**Full-slide** (text only, no images):
- **90-105 words maximum** (approximately 1.75x half-slide)
- Typically 5-6 bullets
- ~15-20 words per bullet

**Per-bullet limit:**
- Keep individual bullets under 20 words to avoid excessive wrapping
- Exception: Quote slides can be longer (these are typically special format slides)

### HTML comments (speaker notes)

**Minimum requirement:**
- Every slide should have at least one HTML comment block with speaker notes
- Comments guide what to say, examples to mention, or demos to show

**Types of speaker notes:**

**❌ Unhelpful (avoid):**
- Generic instructions: "Explain how..." "Show examples of..." "Cover the basics..."
- Meta-commentary: "Speaker notes:" prefix (redundant in HTML comments)
- Process descriptions without content: "Demo..." "Live demo..." (without specific what/how)
- Obvious statements: Repeating what the slide already says

**✅ Helpful (include):**
- **Specific context**: Why something matters (e.g., "AlphaGo's victory showed AI could master intuition, not just calculation")
- **Key concept definitions**: What the "attention mechanism" is and why it revolutionized AI
- **Concrete examples**: List specific models/tools (GPT-4, Claude, Gemini) rather than just categories
- **Relationships & connections**: How ML fits within AI, how rule-based approaches complement learning
- **Historical significance**: Why 2012 was watershed moment with AlexNet
- **Specific data points**: "30-50% productivity gains for developers" instead of "significant impact"

**Detailed slides:**
- For slides with multiple distinct points, use one comment per bullet
- Place the comment directly after the related bullet (indent if it's a sub-bullet)

**Format preference:**
- Use bullet points (with `*` or `-`) within HTML comments for better scannability
- Each bullet should be a distinct talking point or example
- This makes it easier to deliver during presentations and find specific information quickly

**Example patterns:**
```markdown
### Simple slide with general notes
* Bullet 1
* Bullet 2
* Bullet 3

<!--
- The Transformer architecture revolutionized AI with the "attention mechanism"
- Foundation models trained on vast internet data can now generate coherent text, code, and images
- This breakthrough enabled applications from ChatGPT to GitHub Copilot
-->

---

### Detailed slide with per-bullet notes
* **Deep learning:** Neural Networks with many layers
  <!--
  - 2012 was the watershed moment: AlexNet crushed the ImageNet competition
  - The convergence of big data and GPU computing power unlocked automatic feature learning
  - This eliminated the need for manual feature engineering
  -->
* **Key applications:** AlphaGo, FaceID, Voice Assistants
  <!--
  - AlphaGo's victory over Lee Sedol in 2016 showed AI could master intuition
  - FaceID demonstrates how this technology is now in everyone's pocket
  - These applications were impossible with rule-based systems
  -->
```
