## Welcome to Your Digital Garden

This document is your personal guide to using this Obsidian vault. It's designed to be a living system for thinking and creating, powered by a few simple but powerful principles.

## Core Principles

This vault operates on four simple rules:

1.  **Everything Starts in the Inbox:** All new information, no matter how small, goes into the `00-Inbox` first. This keeps your vault clean and your mind clear.
2.  **Structure is Metadata:** A note's identity is defined by its YAML `type` property (e.g., `type: person`), not by which folder it's in. This is the key to the whole system.
3.  **Connections are Key:** The real power comes from linking notes together. Always ask: "What does this relate to?"
4.  **Explore with Hubs:** Use dynamic `Bases` to view structured data (like all your projects) and manual `MOCs` to explore interconnected concepts.

## The Daily Workflow

Follow this process to cultivate your knowledge garden.

### Step 1: Capture
- **Action:** Add any new thought, idea, meeting note, or web clipping directly into the `00-Inbox`.
- **Goal:** Get information out of your head and into the system quickly, without worrying about organization.

### Step 2: Process & Structure
- **Action:** Regularly review your `00-Inbox`. For each item that has lasting value, create a new note in the `20-Permanent` folder using a **Template**.
- **Details:**
    1.  Use the `Templater` plugin to select the correct template (e.g., `T-Person`, `T-Meeting`).
    2.  This inserts the correct YAML frontmatter. Fill out the properties based on the **Note Schemas** below.
    3.  Write the body of the note, summarizing and synthesizing the information in your own words.
- **Goal:** Transform raw information into structured, permanent notes.

### Step 3: Connect
- **Action:** As you write, generously link to other notes. Use `[[wikilinks]]` in the body and in the YAML properties.
- **Goal:** Weave your new note into your existing knowledge web, creating context and new associations.

### Step 4: Refine (From Fleeting to Permanent)
- **Action:** Periodically review your daily notes (`10-Daily`) and AI chat logs.
- **Details:**
    1.  Look for core concepts or valuable insights within these logs.
    2.  For each one, **extract** it into a new, dedicated `concept` note in `20-Permanent`.
    3.  Rewrite the idea in your own words.
    4.  In the new note, link back to the source (e.g., `source: "[[2025-07-16]]"`).
- **Goal:** Turn the raw stream of daily thoughts into refined, permanent assets in your knowledge base.

### Step 5: Explore
- **Action:** Use your `Hubs` to navigate and discover connections.
- **Details:**
    - Go to the `30-Bases` folder to see dynamic, database-like views of your notes (e.g., all books you're reading).
    - Create and explore `Maps of Content (MOCs)` to follow trails of thought on specific topics.
- **Goal:** Use your knowledge base to generate new ideas and insights.

## The Vault's Anatomy

This section is the technical reference for how the vault is structured.

### Folder Structure
*   `0-inbox`: Temporary holding area for all new, unprocessed information.
*   `1-daily`: Daily notes, journals, and logs.
*   `2-permanent`: The core of your vault. Contains all processed, structured notes.
*   `3-bases`: Holds the special notes that create database-like views of your vault.
*   `8-attachments`: All non-note files (images, PDFs, etc.).
*   `9-system/templates`: Note templates for the `Templater` plugin.

### Note Schemas

This section is the single source of truth for the structure of your notes. Use it as a reference when creating templates in the `9-system/templates` folder.

---
```yaml
# Note Schemas

person:
  type: person
  status: # active-contact, colleague, etc.
  company:
  tags: []

meeting:
  type: meeting
  date: YYYY-MM-DD
  attendees: [] # list of [[links]] to people
  project: # [[link]] to project
  tags: []

source:
  type: source
  author: # [[link]] to person
  status: # to-read, reading, finished
  rating: # 1-5
  tags: []

project:
  type: project
  status: # planning, in-progress, completed
  due_date: YYYY-MM-DD
  tags: []

concept:
  type: concept
  related: [] # list of [[links]] to concepts
  tags: []
```
---

## Finding Information

This section will cover various strategies and tools for efficiently searching and finding notes within your vault.

### Searching for Content

Placeholder for how to search for content. This might include:
- Basic text search (`Ctrl/Cmd + Shift + F`)
- Regular expressions in search
- Searching within specific folders

### Finding Files by Type or Property

Placeholder for how to find files based on their type or properties. This might include:
- Using Dataview queries for specific YAML properties (e.g., `type: person`)
- Filtering by tags
- Using the graph view to discover connections

## AI Collaboration

For guidance on collaborating with AI assistants like Claude Code, see [[AI-COLLABORATION]].

# Obsidian setup
- Settings
	- Editor > vim mode
- Plugins