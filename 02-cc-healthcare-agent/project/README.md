# Healthcare AI assistant

An AI-powered clinical documentation tool that helps doctors populate medical records from conversation transcripts and interact with patient records using natural language.

## Features

- Paste or upload visit transcripts and extract structured clinical data (diagnosis, plan, prescriptions)
- Query patient records using natural language
- Generate professional patient summary reports
- Web chat interface with file upload support

## Architecture

- UI: Chainlit (web chat with file uploads and streaming)
- AI: Claude Agent SDK with specialized skills for record creation and report generation
- Database: SQLite accessed via the `sqlite3` CLI
- Deployment: Docker

The agent uses the `Bash` tool to run `sqlite3` commands directly. Skills defined in `.claude/skills/` teach the agent the database schema and how to perform common operations.


## Getting started

### Prerequisites

- Docker and Docker Compose
- An Anthropic API key from https://console.anthropic.com/

### Running the app

```bash
cp .env.example .env
# Edit .env and add your ANTHROPIC_API_KEY
docker compose up --build
```

Open http://localhost:8000 in your browser.

### Usage

- Paste a visit transcript into the chat and the agent will extract the diagnosis, plan, and prescriptions
- Ask about a patient by name (e.g., "Show me John Smith's records")
- Request a report (e.g., "Generate a summary report for Maria Garcia")
- Upload a transcript file using the attachment button

### Sample data

The app seeds the database with sample patients and visits on first run. You can start querying immediately without adding data manually.


## Developer guide

### Project structure

```
├── app.py                        # Chainlit app + Agent SDK client
├── database/
│   ├── models.py                 # SQLite schema (patients + visits)
│   └── seed.py                   # Sample data for development
├── .claude/
│   └── skills/
│       ├── record-creation.md    # Transcript extraction skill
│       └── report-generation.md  # Report generation skill
├── .chainlit/
│   └── config.toml               # Chainlit UI configuration
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
├── .env.example
└── .gitignore
```

### How it works

- `app.py` creates a `ClaudeSDKClient` per chat session, maintaining conversation state across messages
- The client is configured with `allowed_tools=["Bash"]` and `setting_sources=["project"]`
- `setting_sources=["project"]` loads the skills from `.claude/skills/` at runtime
- The agent uses `sqlite3` CLI commands to read/write the database at `/app/data/patients.db`
- The database is initialized and seeded on each chat session start (idempotent)

### Adding a new skill

- Create a new markdown file in `.claude/skills/`
- Include a "When to use" section so the agent knows when to activate it
- Include database schema and example `sqlite3` commands if the skill needs data access
- The skill is picked up automatically on next container start (no code changes needed)

### Modifying the database schema

- Update the schema in `database/models.py`
- Update the schema section in each skill markdown file that references it
- Update `database/seed.py` if new sample data is needed
- Delete the Docker volume to reset: `docker compose down -v && docker compose up --build`

### Environment variables

- `ANTHROPIC_AUTH_TOKEN` — required, your API key (or proxy token)
- `ANTHROPIC_BASE_URL` — API endpoint (default: `https://api.anthropic.com`)
- `API_TIMEOUT_MS` — request timeout in milliseconds

### Docker details

- Base image: `python:3.12-slim`
- Node.js 22 is installed (required by the Claude Code CLI bundled with the SDK)
- `sqlite3` CLI is installed for database operations
- The local project directory is bind-mounted into the container (`.:/app`), so code and config changes are live without rebuilding
- SQLite database is persisted in a named Docker volume (`patient-data`), separate from the bind mount
- To reset the database: `docker compose down -v`

### Development workflow

```bash
# First time (or after changing requirements.txt)
docker compose up --build

# After code/config changes (app.py, skills, database code)
docker compose restart

# Full reset (clears database)
docker compose down -v && docker compose up
```

Only changes to `requirements.txt` require a rebuild. Everything else (skills, app code, database schema) is picked up on container restart.

## Roadmap

- [ ] Integrate Langfuse for tracing and evaluation — instrument agent calls to capture latency, token usage, and quality metrics across both skills
- [ ] Expose on the internet via reverse proxy — set up behind a reverse proxy on a self-hosted server with TLS termination
- [ ] Improve container isolation — the bind mount causes Claude Code CLI to write runtime files (debug/, statsig/, todos/, settings.local.json) into the project's `.claude/` directory since `HOME=/app` inside the container. Need to separate the CLI's runtime state from the project skills directory

## Retrospective and learnings
- Ran into several issues with docker/podman and claude code cli compatability. Claude code doesn't run as root even inside a docker container??? That's weird.
- Maybe explore other alternatives for reproducible environments - devbox, etc.
- Provide Claude Code with a browser use skill / tool.


## References

- [Claude Agent SDK (Python)](https://pypi.org/project/claude-agent-sdk/)
- [Claude Agent SDK documentation](https://docs.claude.com/en/api/agent-sdk/overview)
- [Chainlit documentation](https://docs.chainlit.io/)
- [Microsoft clinical visit note corpus](https://github.com/microsoft/clinical_visit_note_summarization_corpus) — sample transcript data
