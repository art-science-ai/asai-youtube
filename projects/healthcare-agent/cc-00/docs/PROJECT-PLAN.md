# Healthcare AI assistant project plan

## Project overview

Healthcare AI assistant built with Chainlit UI and Claude Agent SDK that helps doctors:
1. Create patient records from clinical visit transcripts
2. Generate PDF reports from existing patient records

## Current status

### Completed

#### Infrastructure
- ✅ Docker containerization fully working
- ✅ All system dependencies resolved (grpc, libstdc++, etc.)
- ✅ Database schema created (SQLite with patients table)
- ✅ Project structure organized (src/agents, src/utils, src/database)
- ✅ uv for Python dependency management
- ✅ Claude Pro OAuth credentials mounted from ~/.claude

#### Dependencies
- ✅ Fixed pyproject.toml version constraints
  - claude-agent-sdk: 0.1.0 → 0.1.20 (latest available)
  - Migrated from deprecated tool.uv.dev-dependencies to dependency-groups.dev
  - Added hatchling build configuration for src layout
- ✅ All packages installed correctly in Docker

#### Code structure
- ✅ Main Chainlit app (app.py)
- ✅ Base agent orchestrator (src/agents/base_agent.py)
- ✅ Record creation sub-agent (src/agents/record_agent.py)
- ✅ Report generation sub-agent (src/agents/report_agent.py)
- ✅ PDF generator utility (src/utils/pdf_generator.py)
- ✅ Database initialization (src/database/init.sql)
- ✅ Comprehensive logging added

#### API fixes
- ✅ Updated imports from ClaudeAgent → ClaudeSDKClient
- ✅ Updated usage to match SDK 0.1.20 API (async with, query, receive_response)
- ✅ Removed outdated @cl.on_file_upload decorator
- ✅ Removed ANTHROPIC_API_KEY requirement (using Claude Pro credentials)

### Remaining work

#### Critical issue: Sub-agent pickle error
**Status:** BLOCKING

**Problem:**
- The ClaudeSDKClient cannot be passed as sub-agents in the agents parameter
- Error: "cannot pickle 'TextIOWrapper' instances"
- Occurs when trying to serialize sub-agent configurations

**Root cause:**
- In base_agent.py lines 49-52, we're passing ClaudeAgentOptions objects as sub-agents
- These options may contain file handles or other non-serializable objects
- The SDK is trying to pickle these when connecting

**Possible solutions:**
1. Don't use sub-agents at all - have single agent with more comprehensive system prompt
2. Use the SDK's proper sub-agent configuration (needs research into SDK docs/examples)
3. Use simple query() function instead of ClaudeSDKClient for simpler use case
4. Create sub-agents dynamically within tool calls instead of pre-configuring them

**Next steps:**
- Research claude-agent-sdk documentation for proper sub-agent usage
- Look at SDK examples on GitHub for sub-agent patterns
- Consider simplifying to single agent approach if sub-agents too complex

#### Feature completion
Once agent issue resolved:

- Test record creation workflow
  - Upload transcript
  - Extract patient data
  - Confirm and save to database

- Test report generation workflow
  - Query patient by name/ID
  - Generate PDF report
  - Download report

- File upload handling
  - Test with .txt files
  - Test with larger transcripts

- Error handling improvements
  - Better user-facing error messages
  - Graceful handling of missing patients
  - Database connection error handling

## File structure

```
.
├── app.py                          # Main Chainlit entry point
├── pyproject.toml                  # Python dependencies
├── uv.lock                         # Locked dependencies
├── Dockerfile                      # Container definition
├── docker-compose.yml              # Container orchestration
├── .dockerignore                   # Files to exclude from build
├── .env                           # Environment variables (not in git)
├── .env.example                   # Example env file
├── src/
│   ├── __init__.py
│   ├── agents/
│   │   ├── __init__.py
│   │   ├── base_agent.py          # Main orchestrator (NEEDS FIX)
│   │   ├── record_agent.py        # Record creation sub-agent
│   │   └── report_agent.py        # Report generation sub-agent
│   ├── database/
│   │   ├── __init__.py
│   │   └── init.sql               # Database schema
│   └── utils/
│       ├── __init__.py
│       └── pdf_generator.py       # PDF report generator
├── data/
│   ├── healthcare.db              # SQLite database (created at runtime)
│   └── reports/                   # Generated PDF reports
└── tests/
    └── __init__.py
```

## Docker commands

```bash
# Start application
docker compose up -d

# View logs (real-time)
docker compose logs -f

# Stop application
docker compose down

# Rebuild after code changes
docker compose up --build -d

# Check container status
docker ps | grep healthcare
```

## Access

- Web UI: http://localhost:8000
- Credentials: Uses ~/.claude OAuth (Claude Pro subscription)
- Database: ./data/healthcare.db (volume mounted)
- Reports: ./data/reports/ (volume mounted)

## Technical notes

### Why Docker?
- NixOS environment had missing system libraries (libstdc++.so.6)
- grpc package requires C extensions
- Docker provides consistent environment with all dependencies

### Why create agent on-demand?
- ClaudeSDKClient contains file handles that can't be pickled
- Chainlit session storage requires picklable objects
- Solution: Create fresh agent for each message

### Current blocker
The sub-agent architecture needs rework. The SDK may not support passing ClaudeAgentOptions as sub-agents the way we're doing it. Need to either:
- Find correct SDK pattern for sub-agents
- Simplify to single agent
- Use alternative delegation pattern

## Priority next session

1. Fix sub-agent pickle error (try simplified single agent first)
2. Test end-to-end workflow with real transcript
3. Verify PDF generation works
4. Add sample transcript for testing
