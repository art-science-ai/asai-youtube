---
description: Create source notes from URLs (YouTube, web articles, research content) with metadata
---

# Web Content Extractor Workflow

## Overview

This workflow creates source notes from URLs (YouTube videos, web articles, research content) with comprehensive metadata extraction and attribution. It should be used when users want to capture web content for later reference, research, or integration into their Zettelkasten system. Commands and agents should reference this workflow directly and follow the process exactly as written.

## Context

- **User provides**: URL(s) to process and extraction preferences
- **Workflow validates**: URL accessibility, content type, and extraction requirements
- **Workflow creates**: Source notes with extracted content and metadata
- **Integration**: Supports multiple AI interfaces (Claude Code, Gemini CLI, Opencode)

## Process

### 1. Validate and categorize URLs

- **URL Validation**:
  - Check URL format and accessibility
  - Verify no duplicate processing for existing source notes
  - Validate domain accessibility and content availability
  - Check for rate limiting or access restrictions

- **Content Type Classification**:
  - **YouTube**: Video URLs (youtube.com/watch, youtu.be)
  - **Web Articles**: Standard web pages with article content
  - **Research Papers**: Academic papers, PDFs, research documents
  - **Social Media**: Twitter, LinkedIn, forum posts
  - **Documentation**: Technical documentation, guides
  - **Multimedia**: Image galleries, audio content

- **Extraction Priority Assessment**:
  - High: Valuable research content, educational content
  - Medium: General articles, blog posts
  - Low: Casual content, social media updates
  - Skip: Low-value or duplicate content

### 2. Extract content using appropriate tools

**For YouTube Videos:**
- Use YouTube API or scraping tools to extract:
  - Video title and description
  - Channel information and subscriber count
  - Duration and upload date
  - Video transcript (if available)
  - Key topics and tags
- Process transcript using AI to identify:
  - Main themes and key takeaways
  - Actionable insights and ideas
  - Related concepts and references

**For Web Articles:**
- Use web scraping or APIs to extract:
  - Article title and author information
  - Publication date and source
  - Full article content
  - Metadata (reading time, tags, categories)
  - Images and embedded media
- Use AI to process content and extract:
  - Summary and key points
  - Important quotes and statistics
  - Related topics and references
  - Personal relevance and insights

**For Research Content:**
- Extract from papers, reports, and documents:
  - Title, author, publication details
  - Abstract and key findings
  - Methodology and conclusions
  - Citations and references
- Process for research value:
  - Identify key hypotheses and theories
  - Extract supporting evidence
  - Note methodological strengths/weaknesses

### 3. Create source note structure

**File Naming Convention:**
- Use pattern: `source-[unique-id]-[title-slug].md`
- Example: `source-20241201-youtube-video-title.md`
- Ensure uniqueness within source notes folder

**Metadata Structure:**
```yaml
---
global-created: 2024-12-01
global-type: source-note
global-modified: 2024-12-01
source-url: https://example.com/url
source-title: Extracted Title
source-type: youtube|article|research|social|documentation
source-author: Author Name (if available)
source-date: 2024-12-01 (original publication)
source-duration: 15:30 (video duration, if applicable)
source-reading-time: 5 min (estimated reading time)
---

# Source Note Title

## Source Information
- **Original URL**: [URL link](source-url)
- **Source Type**: source-type
- **Author**: source-author (if available)
- **Published**: source-date
- **Duration**: source-duration (if applicable)
- **Reading Time**: source-reading-time

## Content Summary
[AI-generated summary of key content]

## Key Takeaways
- [Key point 1]
- [Key point 2]
- [Key point 3]

## Notable Quotes
> "Important quote or statistic"
> "Another significant point"

## Personal Insights
[Personal thoughts, connections, and relevance]

## Related Concepts
- [[related-note-1]]
- [[related-note-2]]
- [[related-concept]]

## Action Items
- [ ] Action item derived from this content
- [ ] Research follow-up needed

## Tags
#web-content #source-note #[source-type]
```

### 4. Establish linking and relationships

**Backlinking Strategy:**
- Create reference links in relevant existing notes
- Establish bidirectional links when appropriate
- Link to related ideas and concepts in Zettelkasten
- Connect to relevant projects and areas in PARA system

**Content Integration:**
- Identify where source content connects to:
  - Existing projects (02-03/01-projects/*)
  - Relevant areas (02-03/02-areas/*)
  - Resource collections (02-03/03-resources/*)
  - Zettelkasten ideas (02-03/04-zettelkasten/*)
- Create integration notes where multiple sources relate to a topic

### 5. Post-processing validation

**Quality Assurance:**
- Validate all extracted content for completeness and accuracy
- Check metadata consistency and completeness
- Verify all links work correctly
- Ensure proper attribution and source attribution

**Organization and Cleanup:**
- Move source notes to appropriate folder (02-03/05-references)
- Update source note tracking and indexing
- Remove duplicate or low-value extractions
- Commit changes with descriptive message

## Guidelines

- **Always preserve source attribution** - Maintain clear links to original content
- **Extract responsibly** - Respect copyright and terms of service
- **Maintain content quality** - Ensure extracted content is valuable and relevant
- **Use appropriate extraction tools** - Match tool to content type and requirements
- **Support multiple AI interfaces** - Ensure workflow works with Claude Code, Gemini CLI, Opencode
- **Avoid over-processing** - Some content may be better as simple references
- **Use absolute paths** for all file operations to ensure accuracy
- **Provide clear documentation** of extraction process and sources

## Final Review

Verify that the web content extraction workflow completed successfully:

- [ ] All URLs validated and categorized correctly
- [ ] Content extracted using appropriate tools for each type
- [ ] Source notes created with proper structure and metadata
- [ ] Content processed for insights and personal relevance
- [ ] Links and relationships established bidirectionally
- [ ] Notes organized in appropriate reference folder
- [ ] Quality validation completed successfully
- [ ] No copyright or attribution issues introduced
- [ ] Changes committed with descriptive message
- [ ] Process supports multiple AI interfaces consistently