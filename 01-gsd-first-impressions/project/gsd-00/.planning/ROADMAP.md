# Roadmap: Healthcare AI Assistant

## Overview

A three-phase journey from basic chat interface to full AI-powered medical documentation workflow. Starting with Chainlit web UI and SQLite database foundation, then building the core record extraction agent that converts conversation transcripts into structured patient data (Diagnosis, Plan, Prescriptions), and finally adding report generation that produces professional PDF summaries for download.

## Phases

**Phase Numbering:**
- Integer phases (1, 2, 3): Planned milestone work
- Decimal phases (2.1, 2.2): Urgent insertions (marked with INSERTED)

Decimal phases appear between their surrounding integers in numeric order.

- [x] **Phase 1: Foundation** - Web chat interface with SQLite database for patient records
- [ ] **Phase 2: Record Extraction** - AI agent that extracts structured medical data from visit transcripts
- [ ] **Phase 3: Report Generation** - PDF report generation from patient records

## Phase Details

### Phase 1: Foundation

**Goal**: User can interact with web chat interface and store patient records in SQLite database

**Depends on**: Nothing (first phase)

**Requirements**: UI-01, UI-02, UI-03, DB-01, DB-02, DB-03

**Success Criteria** (what must be TRUE):
1. User can send text messages through web chat interface and see responses
2. User can upload plain text transcript files through chat interface
3. User can paste raw visit transcript text directly into chat
4. System stores patient records with Diagnosis, Plan, Prescriptions, and timestamp in SQLite
5. User can look up existing patient records by simple patient name/ID

**Plans**: 2 plans in 2 waves

Plans:
- [x] 01-01-PLAN.md — Chainlit web chat interface setup with text, file upload, and paste support
- [x] 01-02-PLAN.md — SQLite database schema and patient lookup integration with chat interface

**Completed:** 2025-01-20

### Phase 2: Record Extraction

**Goal**: User can upload visit transcripts and extract structured patient records with AI assistance

**Depends on**: Phase 1

**Requirements**: REC-01, REC-02, REC-03, REC-04, REC-05, REC-06, REC-07

**Success Criteria** (what must be TRUE):
1. User can upload transcript and agent extracts Diagnosis from conversation
2. User can upload transcript and agent extracts Plan (treatment recommendations)
3. User can upload transcript and agent extracts Prescriptions
4. Agent displays extracted findings for user review before saving
5. User can ask questions about extraction results and get clarifications
6. User can request adjustments to extracted findings (e.g., "add aspirin to prescriptions")
7. User can save reviewed findings to patient record in database

**Plans**: 2 plans in 2 waves

Plans:
- [ ] 02-01-PLAN.md — Claude agent for medical data extraction from transcripts with Pydantic validation and tool use
- [ ] 02-02-PLAN.md — Review workflow with interactive Q&A, approve/adjust/cancel actions, and database integration

### Phase 3: Report Generation

**Goal**: User can generate and download professional PDF patient summary reports

**Depends on**: Phase 2

**Requirements**: UI-04, RPT-01, RPT-02, RPT-03, RPT-04, RPT-05

**Success Criteria** (what must be TRUE):
1. User can specify patient details through chat (name, visit date, provider)
2. Agent analyzes patient record including diagnosis, treatment plan, and prescriptions
3. Agent generates condensed patient summary with diagnosis, treatment, and current status
4. System generates professional PDF report from summary
5. User can download generated PDF report through chat interface

**Plans**: 2 plans

Plans:
- [ ] 03-01: Claude agent for patient summary generation
- [ ] 03-02: PDF report generation and download workflow

## Progress

**Execution Order:**
Phases execute in numeric order: 1 → 2 → 3

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Foundation | 2/2 | ✓ Complete | 2025-01-20 |
| 2. Record Extraction | 0/2 | Ready to execute | - |
| 3. Report Generation | 0/2 | Not started | - |
