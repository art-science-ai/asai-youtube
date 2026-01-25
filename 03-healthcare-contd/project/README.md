# Healthcare AI assistant

## Overview

### About
- AI-powered clinical documentation tool that helps doctors populate medical records from conversation transcripts
- Uses natural language interaction to query patient records and generate professional reports
- Built as a learning project exploring the Claude Agent SDK + Chainlit stack

### Key features
- Paste or upload visit transcripts and extract structured SOAP notes (Subjective, Objective, Assessment, Plan)
- Query patient records using natural language
- Generate professional patient summary reports
- Web chat interface with file upload support

### Technology / architecture
- UI: Chainlit (web chat with file uploads and streaming)
- AI: Claude Agent SDK with specialized skills for record creation and report generation
- Database: SQLite accessed via the `sqlite3` CLI
- Deployment: Docker


## User guide

### Quick start
```bash
cp .env.example .env
# Edit .env and add your ANTHROPIC_API_KEY
docker compose up --build
```
Open http://localhost:8000 in your browser.

### Prerequisites
- Docker and Docker Compose
- An Anthropic API key from https://console.anthropic.com/

### Configuration
- `ANTHROPIC_AUTH_TOKEN` — required, your API key (or proxy token)
- `ANTHROPIC_BASE_URL` — API endpoint (default: `https://api.anthropic.com`)
- `API_TIMEOUT_MS` — request timeout in milliseconds

### Usage examples
- Paste a visit transcript into the chat and the agent will extract a SOAP note
- Ask about a patient by name (e.g., "Show me Lucas Brown's records")
- Request a report (e.g., "Generate a summary report for Harper Harris")
- Upload a transcript file using the attachment button

The app seeds the database with sample patients and visits on first run. You can start querying immediately without adding data manually.


## Developer guide

### Developer cheatsheet

Docker:
- First run (or after changing requirements.txt): `docker compose up --build`
- After code/config changes (app.py, skills, database code): `docker compose restart`
- Full reset (clears database): `rm data/patients.db && docker compose restart`

Devbox:
- Enter shell: `devbox shell`
- Run dev server (with hot reload): `devbox run dev`
- Seed database: `devbox run seed`
- Full reset: `devbox run reset`

Only changes to `requirements.txt` require a Docker rebuild. Everything else (skills, app code, database schema) is picked up on restart.

### Architecture
- `app.py` creates a `ClaudeSDKClient` per chat session, maintaining conversation state across messages
- The client is configured with `allowed_tools=["Bash"]` and `setting_sources=["project"]`
- `setting_sources=["project"]` loads the skills from `.claude/skills/` at runtime
- The agent uses `sqlite3` CLI commands to read/write the database at `data/patients.db`
- The database is initialized and seeded on each chat session start (idempotent)

### Directory map
- `app.py` — Chainlit app + Agent SDK client
- `database/` — SQLite schema and seed data
  - `models.py` — schema (patients + visits with SOAP fields)
  - `seed.py` — database seeding logic
  - `seed_corpus.py` — auto-generated corpus data (from download script)
- `.claude/skills/` — Agent skill definitions
  - `record-creation.md` — transcript extraction skill
  - `report-generation.md` — report generation skill
- `.chainlit/` — Chainlit UI configuration
- `sample-transcripts/` — example visit transcripts for testing
- `scripts/` — utility scripts
  - `download-transcripts.py` — fetches sample data from Omi-Health SOAP dataset
- `Dockerfile` / `docker-compose.yml` — container configuration
- `devbox.json` — local dev environment (alternative to Docker)

### Sample data

The project uses two types of sample data from the Omi-Health dataset, which provides medical dialogues with pre-formatted SOAP notes:

**Labeled data** (pre-seeded in database):
- 7 patient records with SOAP-formatted clinical documentation
- Each record includes: subjective, objective, assessment, and plan sections
- Used for testing queries and report generation

**Unlabeled transcripts** (in `sample-transcripts/`):
- 5 raw doctor-patient dialogues
- Used for testing the record extraction skill
- Format: `Doctor:` / `Patient:` conversation turns

To regenerate sample data from the Omi-Health corpus:
```bash
devbox run download
```

To reset the database with fresh seed data:
```bash
rm data/patients.db && devbox run seed
# or with Docker:
rm data/patients.db && docker compose restart
```

Data source: [Omi-Health medical-dialogue-to-soap-summary](https://huggingface.co/datasets/omi-health/medical-dialogue-to-soap-summary)

### Development standards
- Adding a new skill:
  - Create a new markdown file in `.claude/skills/`
  - Include a "When to use" section so the agent knows when to activate it
  - Include database schema and example `sqlite3` commands if the skill needs data access
  - The skill is picked up automatically on next container start (no code changes needed)
- Modifying the database schema:
  - Update the schema in `database/models.py`
  - Update the schema section in each skill markdown file that references it
  - Update `database/seed.py` if new sample data is needed
  - Reset the database: `rm data/patients.db && docker compose restart`

### Docker details
- Base image: `python:3.12-slim` with uv for dependency management
- Node.js 22 is installed (required by the Claude Code CLI bundled with the SDK)
- `sqlite3` CLI is installed for database operations
- The local project directory is bind-mounted into the container (`.:/app`), so code and config changes are live without rebuilding
- SQLite database lives at `data/patients.db` within the bind mount (accessible from host for monitoring)
- Podman-specific directives (`userns_mode: keep-id`, `x-podman`) are included — Docker ignores them safely
- To reset the database: `rm data/patients.db && docker compose restart`

### Monitoring the database

During development, open a terminal alongside the chat UI to watch database changes in real time.

The database is bind-mounted to `data/patients.db` on the host, so you can query it directly from a devbox shell:
```bash
# Live tail with watch (refreshes every second)
watch -n 1 "sqlite3 data/patients.db 'SELECT * FROM visits ORDER BY id DESC LIMIT 10;'"

# VisiData — terminal spreadsheet with sorting, filtering, and charting
vd data/patients.db

# sqlit — Python TUI with fuzzy search, filtering, and vim keybindings
uvx sqlit-tui data/patients.db

# lazysql — Go TUI inspired by lazygit (refresh with R)
lazysql "file:data/patients.db"
```

The TUI tools don't auto-refresh — use `R` or re-run the query after each chat interaction.


## Roadmap

Done:
- [x] Docker build with uv
- [x] Devbox workflow
- [x] Response streaming
- [x] SOAP format — database uses Subjective, Objective, Assessment, Plan structure
- [x] Sample data — Omi-Health dataset with pre-formatted SOAP notes

TODO:
- [ ] Container isolation — set `HOME=/tmp/claude-home` so CLI state doesn't pollute the bind mount
- [ ] Error handling — surface SDK connection errors to the user
- [ ] Langfuse integration — capture latency, token usage, and quality metrics
- [ ] Expose on the internet — reverse proxy with TLS termination


## References
- [Claude Agent SDK (Python)](https://pypi.org/project/claude-agent-sdk/)
- [Claude Agent SDK documentation](https://docs.claude.com/en/api/agent-sdk/overview)
- [Chainlit documentation](https://docs.chainlit.io/)
- [Omi-Health SOAP dataset](https://huggingface.co/datasets/omi-health/medical-dialogue-to-soap-summary) — sample transcript data with pre-formatted SOAP notes


## Appendix

### Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Chainlit UI                            │
│                  (Web chat + file uploads)                  │
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      app.py                                 │
│            (ClaudeSDKClient per session)                    │
└─────────────────────────────┬───────────────────────────────┘
                              │
              ┌───────────────┴───────────────┐
              ▼                               ▼
┌─────────────────────────┐     ┌─────────────────────────────┐
│   .claude/skills/       │     │      Claude API             │
│  ├─ record-creation.md  │     │   (via Agent SDK)           │
│  └─ report-generation.md│     └──────────────┬──────────────┘
└─────────────────────────┘                    │
                                               ▼
                              ┌─────────────────────────────────┐
                              │         Bash tool               │
                              │   (sqlite3 CLI commands)        │
                              └───────────────┬─────────────────┘
                                              │
                                              ▼
                              ┌─────────────────────────────────┐
                              │      data/patients.db           │
                              │  ┌───────────┬───────────────┐  │
                              │  │ patients  │    visits     │  │
                              │  │  - name   │  - transcript │  │
                              │  │  - dob    │  - subjective │  │
                              │  │  - active │  - objective  │  │
                              │  │  _problems│  - assessment │  │
                              │  │           │  - plan       │  │
                              │  └───────────┴───────────────┘  │
                              └─────────────────────────────────┘
```

### Retrospective and learnings
- Ran into several issues with docker/podman and claude code cli compatibility. Claude code doesn't run as root even inside a docker container — that's unexpected behavior worth noting.
- Maybe explore other alternatives for reproducible environments - devbox, etc.
- Provide Claude Code with a browser use skill / tool.
