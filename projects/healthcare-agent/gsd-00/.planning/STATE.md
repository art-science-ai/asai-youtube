# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2025-01-20)

**Core value:** Doctors can save time on documentation by uploading plain text visit transcripts and automatically extracting structured patient records with diagnosis, treatment plan, and prescriptions.
**Current focus:** Phase 2: Record Extraction

## Current Position

Phase: 2 of 3 (Record Extraction)
Plan: 2 of 2 in current phase
Status: Awaiting verification
Last activity: 2026-01-20 — Awaiting manual verification of 02-02-PLAN.md

Progress: [██████████░░] 67%

## Performance Metrics

**Velocity:**
- Total plans completed: 4
- Average duration: 3 min 15s
- Total execution time: 0.2 hours

**By Phase:**

| Phase | Plans | Total | Avg/Plan |
|-------|-------|-------|----------|
| 01-foundation | 2 | 2 | 2 min |
| 02-record-extraction | 2 | 2 | 4 min |

**Recent Trend:**
- Last 5 plans: 2 min (01-01), 2 min (01-02), 4 min (02-01), 5 min (02-02*)
- Trend: - (insufficient data)
*02-02 awaiting verification

*Updated after each plan completion*

## Accumulated Context

### Decisions

Decisions are logged in PROJECT.md Key Decisions table.
Recent decisions affecting current work:

**01-01: Chainlit Web Interface Setup**
- Chose Chainlit for UI framework (purpose-built for AI chat, handles file uploads natively)
- Using uv for Python dependency management
- Decorator-based event handlers (@cl.on_chat_start, @cl.on_message)
- Virtual environment with isolated dependencies
- Configuration in .chainlit/config.toml for project settings

**01-02: SQLite Patient Records Database**
- SQLite for persistence (built into Python, no external dependencies)
- Pipe-separated command format for simple parsing (save: name|id|diagnosis|plan|prescriptions)
- Database auto-initialization on chat start for seamless UX
- Flexible lookup by patient_name OR patient_id, returns most recent match
- Graceful error handling with None returns and stderr logging

**02-01: Claude Medical Data Extraction Agent**
- Pydantic v2 for schema validation (auto-generates JSON Schema, keeps extraction in sync)
- AsyncAnthropic client for non-blocking AI operations (prevents UI blocking in Chainlit)
- Tool use pattern with @beta_tool decorator (structured extraction vs direct JSON prompting)
- MedicalExtraction model with Field descriptions for better Claude context
- Separate module architecture: models/ for schemas, agents/ for orchestration

**02-02: Interactive Extraction Workflow Integration**
- Chainlit action buttons for approve/adjust/cancel workflow (intuitive vs command syntax)
- Session state for multi-turn conversations (extraction_results, pending_adjustment, pending_save)
- Conversational adjustment workflow using Claude to update extraction based on natural language
- Safe file handling with encoding fallback (UTF-8, latin-1) for robust transcript reading
- Preserved existing save/lookup commands for backward compatibility
- Separate helper functions for cleaner code organization

### Pending Todos

None yet.

### Blockers/Concerns

**01-01: NixOS System Library Dependencies**
- Chainlit runtime requires libstdc++.so.6 (C++ standard library)
- On NixOS/containerized environments, requires: `nix shell nixpkgs#stdenv.cc.cc.lib`
- Application structure verified and syntactically correct
- Runtime can be tested on non-NixOS or using nix-shell wrapper
- Not blocking for development - code is correct and ready for next phase

## Session Continuity

Last session: 2026-01-20
Stopped at: Awaiting manual verification of 02-02-PLAN.md (interactive extraction workflow)
Resume file: None
