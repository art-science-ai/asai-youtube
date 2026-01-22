# Healthcare AI Assistant

## What This Is

A personal healthcare AI assistant that helps doctors populate medical records from plain text conversation transcripts and generate patient summary reports. Uses a Chainlit web chat interface to trigger Claude-powered agents that extract medical data (Diagnosis, Plan, Prescriptions) and store it in SQLite.

## Core Value

Doctors can save time on documentation by uploading plain text visit transcripts and automatically extracting structured patient records with diagnosis, treatment plan, and prescriptions.

## Requirements

### Validated

(None yet — ship to validate)

### Active

- [ ] Web chat interface (Chainlit) for text, image, and file exchange
- [ ] Patient records database (SQLite) storing Diagnosis, Plan, Prescriptions
- [ ] AI Agent 1: Extract patient record from plain text transcript
- [ ] AI Agent 2: Generate patient summary report from existing record
- [ ] Single-session workflow: upload transcript → extract → save → summarize
- [ ] Simple patient identification and lookup

### Out of Scope

- Multi-patient management system — keep it simple for personal use (just basic patient lookup)
- Real-time transcription — works with existing plain text transcripts, no audio processing
- HIPAA compliance infrastructure — personal tool, not handling regulated protected health information
- Multi-user support — single user tool, no authentication needed
- OAuth/login system — personal deployment
- Complex patient history timeline — single visit focus for prototype
- Integration with external EHR systems — standalone tool

## Context

Personal automation tool for a doctor who already has plain text transcripts of patient conversations and wants to reduce time spent on manual documentation. The tool extracts structured medical data (Diagnosis, Plan, Prescriptions) using AI and can generate condensed patient summaries.

## Constraints

- **Tech Stack**: Chainlit (UI), Claude Agent SDK (AI agents), SQLite (database) — chosen for simplicity and AI capabilities
- **Deployment**: Personal tool (local or simple server), not multi-tenant SaaS
- **Compliance**: Not regulated — no HIPAA requirements, personal use
- **Input Format**: Plain text transcript files
- **Output**: Structured patient records with Diagnosis, Plan, Prescriptions
- **Workflow**: Single-session prototype (not long-term patient management system)

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Chainlit for UI | Purpose-built for AI chat interfaces, Python-native, handles file uploads | — Pending |
| Claude Agent SDK | Best-in-class medical text understanding, structured extraction | — Pending |
| SQLite for database | Simple, file-based, no server setup needed for personal tool | — Pending |
| Single-session workflow | Focused prototype vs. complex multi-patient system | — Pending |
| No HIPAA compliance | Personal use, not handling regulated PHI | — Pending |

---
*Last updated: 2025-01-20 after initialization*
