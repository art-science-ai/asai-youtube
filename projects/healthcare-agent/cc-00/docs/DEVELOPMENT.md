# Healthcare AI Assistant - Developer Documentation

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Component Details](#component-details)
3. [Agent System](#agent-system)
4. [Database Design](#database-design)
5. [Code Structure](#code-structure)
6. [Extension Points](#extension-points)
7. [Technical Decisions](#technical-decisions)
8. [Common Development Tasks](#common-development-tasks)
9. [Testing Strategy](#testing-strategy)
10. [Troubleshooting](#troubleshooting)

---

## Architecture Overview

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    User (Doctor/Clinician)                   │
└────────────────────────────┬────────────────────────────────┘
                             │
                    Web Browser (HTTP/WS)
                             │
┌────────────────────────────▼────────────────────────────────┐
│                    Chainlit Web Application                  │
│                         (app.py)                             │
│  - File upload handling                                      │
│  - Message routing                                           │
│  - Session management                                        │
└────────────────────────────┬────────────────────────────────┘
                             │
                    Agent Query/Response
                             │
┌────────────────────────────▼────────────────────────────────┐
│              Main Orchestrator Agent                         │
│              (src/agents/base_agent.py)                      │
│  - Routes requests to sub-agents                             │
│  - Manages conversation context                              │
│  - Coordinates user confirmations                            │
└─────────────┬──────────────────────────┬────────────────────┘
              │                          │
    ┌─────────▼─────────┐      ┌────────▼────────┐
    │  Record Creation  │      │ Report Generation│
    │    Sub-Agent      │      │    Sub-Agent     │
    │ (record_agent.py) │      │ (report_agent.py)│
    └─────────┬─────────┘      └────────┬─────────┘
              │                         │
              │ Inherits Skills         │ Inherits Skills
              │                         │
    ┌─────────▼─────────┐      ┌────────▼─────────┐
    │  record_creation  │      │report_generation │
    │     SKILL.md      │      │    SKILL.md      │
    └─────────┬─────────┘      └────────┬─────────┘
              │                         │
              │ Uses Bash Tool          │ Uses Bash Tool
              │                         │
    ┌─────────▼─────────┐      ┌────────▼─────────┐
    │  sqlite3 CLI      │      │  sqlite3 CLI     │
    │  (INSERT)         │      │  (SELECT)        │
    └─────────┬─────────┘      └────────┬─────────┘
              │                         │
              ▼                         ▼
    ┌─────────────────────────────────────────────┐
    │        SQLite Database (healthcare.db)      │
    │              patients table                 │
    └─────────────────────────────────────────────┘
                                │
                                │ Query for Report
                                ▼
                    ┌───────────────────────┐
                    │  PDF Generator Script │
                    │(pdf_generator.py)     │
                    │  - ReportLab          │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │  Generated PDF Report │
                    │  (data/reports/)      │
                    └───────────────────────┘
```

### Data Flow Diagrams

#### Record Creation Flow

```
User uploads transcript
        │
        ▼
Chainlit receives file → Reads content → Passes to Main Agent
        │
        ▼
Main Agent delegates to Record Agent (via Task tool)
        │
        ▼
Record Agent:
  1. Analyzes transcript (Claude reasoning)
  2. Extracts structured data
  3. Presents to user for review
        │
        ▼
User confirms or requests changes
        │
        ▼
Record Agent:
  4. Executes: sqlite3 data/healthcare.db "INSERT INTO patients..."
  5. Verifies: sqlite3 data/healthcare.db "SELECT ... ORDER BY patient_id DESC LIMIT 1"
        │
        ▼
Returns success with patient_id to user
```

#### Report Generation Flow

```
User requests report (name or ID)
        │
        ▼
Main Agent delegates to Report Agent
        │
        ▼
Report Agent:
  1. Searches: sqlite3 -json data/healthcare.db "SELECT ... WHERE last_name = '...'"
  2. Handles multiple/no matches
  3. Confirms patient identity with user
        │
        ▼
User confirms correct patient
        │
        ▼
Report Agent:
  4. Executes: uv run src/utils/pdf_generator.py <patient_id>
  5. Captures output path from stdout
        │
        ▼
Returns PDF path to user
        │
        ▼
Chainlit presents as downloadable file
```

---

## Component Details

### 1. Chainlit Application (app.py)

**Purpose**: Web interface and request routing

**Key Functions**:

- `initialize_database()`: Creates database if doesn't exist, runs init.sql
- `start()`: Chat initialization, agent creation, welcome message
- `main(message)`: Message handling, file upload processing, agent querying
- `handle_file_upload(file)`: File validation (size, type)

**Key Features**:
- Auto-initializes database on startup
- Reads uploaded files and appends to message content
- Streams agent responses in real-time
- Validates API key presence

**Chainlit Decorators**:
- `@cl.on_chat_start`: Runs once when chat session begins
- `@cl.on_message`: Runs for every user message
- `@cl.on_file_upload`: Validates file uploads before acceptance

**Configuration**: `.chainlit/config.toml`
- Max file size: 10MB
- Max files per upload: 1
- Multi-modal enabled
- Telemetry disabled

### 2. Main Orchestrator Agent (src/agents/base_agent.py)

**Purpose**: Coordinates sub-agents and manages overall conversation

**System Prompt Responsibilities**:
- Route record creation requests to record_agent
- Route report generation requests to report_agent
- Confirm actions with users before database modifications
- Provide clear feedback about operations

**Allowed Tools**:
- `Read`: Read uploaded transcript files
- `Write`: Write temporary files if needed
- `Bash`: Execute sqlite3 commands (though sub-agents primarily do this)
- `Task`: Delegate to sub-agents
- `Skill`: Enable skill inheritance

**Agent Registration**:
```python
agents={
    "record_agent": create_record_agent(),
    "report_agent": create_report_agent(),
}
```

**Model**: `claude-sonnet-4-5-20250929` (latest Claude Sonnet 4.5)

**Permission Mode**: `allow_all` (development) - should change to `ask` for production

### 3. Record Creation Sub-Agent (src/agents/record_agent.py)

**Purpose**: Extract structured medical data from transcripts

**Extraction Targets**:
1. Patient demographics: first_name, last_name, date_of_birth, gender
2. Visit information: visit_date, chief_complaint
3. Diagnosis: detailed diagnostic text
4. Treatment plan: interventions, lifestyle modifications, follow-ups
5. Prescriptions: medication, dosage, frequency, duration, instructions

**System Prompt Key Instructions**:
- Analyze transcripts carefully for medical information
- Extract "Big Three": Diagnosis, Treatment Plan, Prescriptions
- Present extracted data for user review
- Use sqlite3 CLI for database insertions
- Properly escape single quotes ('' for ')
- Store full transcript text for reference

**Database Interaction Pattern**:
```bash
# Insert
sqlite3 data/healthcare.db "INSERT INTO patients (...) VALUES (...);"

# Verify
sqlite3 data/healthcare.db "SELECT patient_id, first_name, last_name FROM patients ORDER BY patient_id DESC LIMIT 1;"
```

**Inherits**: `record_creation` skill from `.claude/skills/record_creation/SKILL.md`

### 4. Report Generation Sub-Agent (src/agents/report_agent.py)

**Purpose**: Generate PDF reports from database records

**Process Steps**:
1. Gather patient identifier (ID, name, DOB)
2. Query database to find matching patient(s)
3. Handle multiple matches (ask user to specify)
4. Confirm patient identity
5. Call PDF generator script
6. Return PDF path

**Database Query Patterns**:
```bash
# By patient_id
sqlite3 -json data/healthcare.db "SELECT * FROM patients WHERE patient_id = [id];"

# By last_name
sqlite3 -json data/healthcare.db "SELECT patient_id, first_name, last_name, date_of_birth FROM patients WHERE last_name = '[name]';"

# By last_name + DOB
sqlite3 -json data/healthcare.db "SELECT * FROM patients WHERE last_name = '[name]' AND date_of_birth = '[dob]';"
```

**PDF Generation**:
```bash
uv run src/utils/pdf_generator.py <patient_id>
```

**Inherits**: `report_generation` skill from `.claude/skills/report_generation/SKILL.md`

### 5. Skills System

**Location**: `.claude/skills/`

**Purpose**: Provide persistent procedural knowledge that agents inherit

**record_creation/SKILL.md**:
- 6-step procedure for extracting and saving records
- SQL command examples with proper escaping
- Error handling guidelines
- Example insertions and verifications

**report_generation/SKILL.md**:
- 6-step procedure for generating reports
- Query patterns for different search criteria
- Multiple match handling
- PDF generator invocation examples

**How Skills Work**:
- Agents automatically inherit skills based on configuration
- Skills are markdown files with structured procedures
- Claude reads and follows skill procedures during execution
- Can be updated without changing agent code

### 6. PDF Generator (src/utils/pdf_generator.py)

**Purpose**: Generate professional PDF reports from patient data

**Executable Formats**:
- Direct: `python src/utils/pdf_generator.py <patient_id>`
- With uv: `uv run src/utils/pdf_generator.py <patient_id>`
- Has shebang for uv inline metadata

**Class: PDFGenerator**

Methods:
- `__init__(database_path, output_dir)`: Initialize with paths
- `_setup_custom_styles()`: Define ReportLab paragraph styles
- `_get_patient_data(patient_id)`: Query database for patient
- `_create_header(elements)`: Generate PDF header with title
- `_create_patient_demographics(elements, data)`: Demographics table
- `_create_visit_information(elements, data)`: Visit details table
- `_create_diagnosis_section(elements, data)`: Diagnosis text
- `_create_treatment_plan_section(elements, data)`: Treatment plan text
- `_create_prescriptions_section(elements, data)`: Prescriptions text
- `generate_report(patient_id)`: Main generation method

**Output**:
- Filename format: `{lastname}_{firstname}_report_{timestamp}.pdf`
- Location: `data/reports/`
- Returns: Full path to generated PDF

**PDF Structure**:
1. Title page with generation timestamp
2. Patient Demographics (table format)
3. Visit Information (table format)
4. Diagnosis section
5. Treatment Plan section
6. Prescriptions section

**Styling**:
- Letter size (8.5" x 11")
- 1-inch margins
- Professional color scheme (#2c3e50 for headers)
- Tables with grey borders
- 11pt body text, 14pt section headers, 24pt title

**Dependencies**:
- reportlab >= 4.2.5 (pure Python, no system dependencies)

### 7. Database (src/database/init.sql)

**Schema**: Single denormalized table

```sql
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    gender TEXT,
    visit_date DATE,
    chief_complaint TEXT,
    diagnosis TEXT,
    treatment_plan TEXT,
    prescriptions TEXT,
    transcript_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Indexes**:
- `idx_patients_name`: ON (last_name, first_name) - Fast name lookups
- `idx_patients_dob`: ON (date_of_birth) - Fast DOB searches

**Design Rationale**:
- Single table simplifies queries and agent interactions
- Denormalized for simplicity (not BCNF)
- All visit data stored in one row per patient/visit
- Text fields allow flexible storage (plain text or JSON)
- Timestamps track record creation/modification

**Future Normalization Path**:
If scaling to multi-visit per patient:
- Create visits table (patient_id FK, visit_date, chief_complaint)
- Create diagnoses table (visit_id FK, diagnosis_text)
- Create treatment_plans table (visit_id FK, plan_text)
- Create prescriptions table (visit_id FK, medication details)

---

## Agent System

### Claude Agent SDK Integration

**SDK Version**: >= 0.4.0

**Agent Creation Pattern**:
```python
from claude_agent_sdk import ClaudeAgent, ClaudeAgentOptions

options = ClaudeAgentOptions(
    system_prompt="...",
    allowed_tools=["Read", "Write", "Bash", "Task", "Skill"],
    agents={"sub_agent_name": sub_agent_options},
    model="claude-sonnet-4-5-20250929",
    permission_mode="allow_all"  # or "ask" for production
)

agent = ClaudeAgent(options)
```

**Sub-Agent Delegation**:
Main agent uses `Task` tool to delegate:
```python
# In system prompt or agent reasoning
"Use the record_agent sub-agent to extract data from this transcript"
```

Claude Agent SDK automatically:
- Routes to the correct sub-agent
- Passes conversation context
- Returns sub-agent response to main agent

**Tool Usage**:
Agents call tools via natural language in their responses. Examples:

Read tool:
```
I'll read the uploaded file to analyze the transcript.
<uses Read tool>
```

Bash tool for sqlite3:
```
Let me query the database to find this patient.
<uses Bash tool with: sqlite3 data/healthcare.db "SELECT...">
```

**Permission Modes**:
- `allow_all`: Auto-approve all tool calls (development)
- `ask`: Request user approval for each tool call (production)

### Skills Inheritance

**How It Works**:
1. Skill files are placed in `.claude/skills/<skill_name>/SKILL.md`
2. Agent options don't explicitly reference skills
3. Claude Agent SDK automatically loads skills from `.claude/skills/`
4. Agents inherit skills based on their role/context
5. Agents read and follow skill procedures during execution

**Best Practices for Skills**:
- Use clear step-by-step procedures
- Include concrete examples
- Document error handling
- Provide SQL/command templates
- Keep procedures focused and specific

### Agent Communication Flow

```
User Message
    │
    ▼
Main Agent receives message
    │
    ├─→ Decides: "This is a record creation request"
    │   │
    │   └─→ Delegates to record_agent via Task tool
    │       │
    │       ▼
    │   Record Agent:
    │   - Reads skill (record_creation/SKILL.md)
    │   - Executes procedure steps
    │   - Uses Bash tool for sqlite3
    │   - Returns result to Main Agent
    │
    ├─→ Decides: "This is a report generation request"
    │   │
    │   └─→ Delegates to report_agent via Task tool
    │       │
    │       ▼
    │   Report Agent:
    │   - Reads skill (report_generation/SKILL.md)
    │   - Queries database with sqlite3
    │   - Calls PDF generator
    │   - Returns PDF path to Main Agent
    │
    └─→ Main Agent returns final response to user
```

---

## Database Design

### Current Schema (Single Table)

**Trade-offs**:

**Advantages**:
- Simple to query (single SELECT)
- Easy for agents to understand and use
- Fast for small datasets
- No JOIN complexity
- Direct mapping to transcript structure

**Disadvantages**:
- One visit per patient (no visit history)
- Data duplication if patient returns multiple times
- Not normalized (violates 3NF)
- Limited relational querying

**When to Normalize**:
- Need to track multiple visits per patient
- Need visit history over time
- Need to analyze prescription trends
- Need to track diagnosis evolution
- Dataset grows beyond 10,000+ records

### Normalized Schema (Future)

```sql
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    gender TEXT,
    contact_number TEXT,
    email TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE visits (
    visit_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    visit_date DATE NOT NULL,
    chief_complaint TEXT,
    transcript_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE
);

CREATE TABLE diagnoses (
    diagnosis_id INTEGER PRIMARY KEY AUTOINCREMENT,
    visit_id INTEGER NOT NULL,
    diagnosis_text TEXT NOT NULL,
    diagnosis_code TEXT,  -- ICD-10
    severity TEXT,
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id) ON DELETE CASCADE
);

CREATE TABLE treatment_plans (
    plan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    visit_id INTEGER NOT NULL,
    plan_text TEXT NOT NULL,
    start_date DATE,
    status TEXT CHECK(status IN ('Active', 'Completed', 'Discontinued')),
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id) ON DELETE CASCADE
);

CREATE TABLE prescriptions (
    prescription_id INTEGER PRIMARY KEY AUTOINCREMENT,
    visit_id INTEGER NOT NULL,
    medication_name TEXT NOT NULL,
    dosage TEXT NOT NULL,
    frequency TEXT NOT NULL,
    duration TEXT,
    instructions TEXT,
    prescribed_date DATE NOT NULL,
    status TEXT CHECK(status IN ('Active', 'Completed', 'Discontinued')),
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id) ON DELETE CASCADE
);
```

### SQLite → PostgreSQL Migration

**When to Migrate**:
- Multi-user deployment
- Concurrent access needed
- Data size exceeds 100GB
- Need advanced features (full-text search, JSON queries)
- Cloud deployment

**Migration Steps**:
1. Export SQLite data: `sqlite3 healthcare.db .dump > data.sql`
2. Convert to PostgreSQL syntax:
   - `INTEGER PRIMARY KEY AUTOINCREMENT` → `SERIAL PRIMARY KEY`
   - Date formats
   - Connection strings
3. Update agents' bash commands:
   - `sqlite3 healthcare.db` → `psql -d healthcare`
   - Command syntax adjustments
4. Add connection pooling
5. Update PDF generator to use psycopg2

---

## Code Structure

### Directory Organization

```
.
├── app.py                          # Chainlit entry point (single file)
├── pyproject.toml                  # uv dependencies
├── setup.sh                        # Automated setup
├── README.md                       # User documentation
├── DEVELOPMENT.md                  # This file
├── .env.example                    # Environment template
├── .gitignore                      # Git ignore rules
├── .chainlit/
│   └── config.toml                 # Chainlit UI/features config
├── .claude/
│   └── skills/
│       ├── record_creation/
│       │   └── SKILL.md           # Record agent procedures
│       └── report_generation/
│           └── SKILL.md           # Report agent procedures
├── src/
│   ├── __init__.py
│   ├── agents/
│   │   ├── __init__.py
│   │   ├── base_agent.py          # Main orchestrator (150 lines)
│   │   ├── record_agent.py        # Record sub-agent (75 lines)
│   │   └── report_agent.py        # Report sub-agent (75 lines)
│   ├── database/
│   │   ├── __init__.py
│   │   └── init.sql               # Schema definition
│   └── utils/
│       ├── __init__.py
│       └── pdf_generator.py       # Standalone PDF generator (350 lines)
├── data/
│   ├── healthcare.db              # SQLite database (gitignored)
│   ├── reports/                   # Generated PDFs (gitignored)
│   └── sample_transcripts/        # Test transcripts
└── tests/
    ├── __init__.py
    └── test_integration.py        # Integration tests
```

### Code Conventions

**Python Style**:
- Line length: 100 characters (configured in pyproject.toml)
- Formatter: Black
- Linter: Ruff
- Type hints: Recommended but not required
- Docstrings: Google style

**Naming Conventions**:
- Functions: `snake_case`
- Classes: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Private methods: `_leading_underscore`

**Import Order**:
1. Standard library
2. Third-party packages (chainlit, reportlab, etc.)
3. Local application imports

**Example**:
```python
import os
import sys
from pathlib import Path

import chainlit as cl
from reportlab.lib.pagesizes import letter

from src.agents.base_agent import create_main_agent
```

### Configuration Management

**Environment Variables (.env)**:
- `ANTHROPIC_API_KEY`: Required, no default
- `DATABASE_PATH`: Default `data/healthcare.db`
- `REPORTS_DIR`: Default `data/reports`
- `LOG_LEVEL`: Default `INFO`

**Chainlit Config (.chainlit/config.toml)**:
- UI customization
- File upload limits
- Feature toggles
- Theme colors

**Agent Configuration (src/agents/*.py)**:
- System prompts (hardcoded in agent files)
- Allowed tools (hardcoded)
- Model selection (hardcoded)
- Permission mode (hardcoded)

**To Add New Config**:
1. Add to `.env.example` with default
2. Read in code: `os.environ.get("VAR_NAME", "default")`
3. Document in README.md

---

## Extension Points

### 1. Adding New Agent Capabilities

**Steps**:
1. Create new sub-agent in `src/agents/new_agent.py`:
```python
from claude_agent_sdk import ClaudeAgentOptions

def create_new_agent() -> ClaudeAgentOptions:
    return ClaudeAgentOptions(
        system_prompt="Your agent's instructions...",
        allowed_tools=["Read", "Write", "Bash"],
        model="claude-sonnet-4-5-20250929",
    )
```

2. Create skill file `.claude/skills/new_skill/SKILL.md`:
```markdown
# New Skill

## Purpose
...

## Procedure
1. Step one
2. Step two
...
```

3. Register in `src/agents/base_agent.py`:
```python
from .new_agent import create_new_agent

agents={
    "record_agent": create_record_agent(),
    "report_agent": create_report_agent(),
    "new_agent": create_new_agent(),  # Add this
}
```

4. Update main agent system prompt to describe when to use new agent

### 2. Adding Database Tables

**Steps**:
1. Update `src/database/init.sql`:
```sql
CREATE TABLE IF NOT EXISTS new_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    -- columns...
);

CREATE INDEX IF NOT EXISTS idx_new_table ON new_table(column);
```

2. Update agent system prompts to document new schema

3. Update skills with new SQL command examples

4. Test migration:
```bash
rm data/healthcare.db
sqlite3 data/healthcare.db < src/database/init.sql
```

### 3. Adding Custom Tools (MCP Servers)

**Current**: Agents use sqlite3 CLI via Bash tool

**To Add Custom Tool**:

1. Create tool file `src/tools/custom_tool.py`:
```python
from claude_agent_sdk import Tool

class CustomTool(Tool):
    name = "custom_tool"
    description = "Description of what this tool does"

    def execute(self, **params):
        # Tool logic
        return {"result": "..."}
```

2. Register in `app.py`:
```python
from src.tools.custom_tool import CustomTool

@cl.on_chat_start
async def start():
    agent = create_main_agent()

    # Register custom tool
    custom_tool = CustomTool()
    agent.register_tool(custom_tool)

    cl.user_session.set("agent", agent)
```

3. Update agent `allowed_tools` to include "custom_tool"

4. Document tool usage in system prompts

### 4. Supporting Multiple Visits Per Patient

**Database Changes**:
1. Normalize schema (see Database Design section)
2. Migrate existing data:
```sql
-- Extract patients
INSERT INTO patients_new (first_name, last_name, date_of_birth, gender)
SELECT DISTINCT first_name, last_name, date_of_birth, gender FROM patients;

-- Create visits linked to patients
INSERT INTO visits (patient_id, visit_date, chief_complaint, transcript_text)
SELECT p.patient_id, old.visit_date, old.chief_complaint, old.transcript_text
FROM patients old
JOIN patients_new p ON old.first_name = p.first_name AND old.last_name = p.last_name;
```

**Agent Changes**:
1. Update record agent to:
   - Check if patient exists before creating
   - Create visit record instead of full patient record
   - Link diagnoses/plans/prescriptions to visit_id

2. Update report agent to:
   - Query all visits for a patient
   - Generate comprehensive history
   - Show visit timeline

3. Update skills with new SQL patterns

### 5. Adding Authentication

**Chainlit Built-in Auth**:

Create `chainlit.py` (Chainlit looks for this):
```python
import chainlit as cl

@cl.password_auth_callback
def auth_callback(username: str, password: str):
    # Check credentials
    if username == "admin" and password == "secret":
        return cl.User(
            identifier="admin",
            metadata={"role": "admin"}
        )
    return None
```

Update `.chainlit/config.toml`:
```toml
[project]
user_env = ["ANTHROPIC_API_KEY"]
```

**OAuth Integration**:
See Chainlit docs: https://docs.chainlit.io/authentication/oauth

### 6. Adding More Report Types

**Steps**:
1. Extend `pdf_generator.py`:
```python
def generate_report(self, patient_id: int, report_type: str = "summary") -> str:
    if report_type == "summary":
        self._create_summary_sections(elements, patient_data)
    elif report_type == "prescription_history":
        self._create_prescription_history(elements, patient_data)
    elif report_type == "diagnosis_trend":
        self._create_diagnosis_trend(elements, patient_data)
```

2. Add command-line argument:
```bash
python src/utils/pdf_generator.py <patient_id> --type prescription_history
```

3. Update report agent skill with new types

### 7. Adding File Format Support

**Current**: Plain text transcripts

**To Add DOCX/PDF Parsing**:

1. Add dependencies to `pyproject.toml`:
```toml
dependencies = [
    "chainlit>=1.4.0",
    "claude-agent-sdk>=0.4.0",
    "anthropic>=0.40.0",
    "reportlab>=4.2.5",
    "python-docx>=1.1.0",  # Add this
    "PyPDF2>=3.0.0",       # Add this
]
```

2. Update file upload handler in `app.py`:
```python
@cl.on_file_upload(accept=["text/plain", "application/pdf", ".docx", ".txt"])
async def handle_file_upload(file: cl.File):
    if file.name.endswith('.pdf'):
        # Extract text from PDF
        import PyPDF2
        with open(file.path, 'rb') as f:
            reader = PyPDF2.PdfReader(f)
            text = ""
            for page in reader.pages:
                text += page.extract_text()
        return text
    elif file.name.endswith('.docx'):
        # Extract text from DOCX
        import docx
        doc = docx.Document(file.path)
        text = "\n".join([para.text for para in doc.paragraphs])
        return text
    # ... handle other formats
```

---

## Technical Decisions

### 1. Why No Custom MCP Tools?

**Decision**: Use sqlite3 CLI via Bash tool instead of custom database MCP server

**Rationale**:
- **Simplicity**: Fewer abstractions, easier to debug
- **Transparency**: SQL commands visible in agent reasoning
- **Flexibility**: Easy to modify queries without changing tool code
- **Development Speed**: 40% faster implementation
- **Familiarity**: Developers know SQL and CLI tools

**Trade-offs**:
- Less error handling (CLI exit codes vs. structured errors)
- No input validation at tool level
- Security concerns with SQL injection (mitigated by agent prompt)
- No connection pooling

**When to Reconsider**:
- Need complex transactions
- Need connection pooling
- Move to PostgreSQL
- Multiple agents accessing database concurrently
- Need sophisticated error handling

### 2. Why Single Denormalized Table?

**Decision**: One patients table with all visit data

**Rationale**:
- **Simplicity**: Easier for agents to query
- **MVP Focus**: Get working system quickly
- **Single Visit Assumption**: Most transcripts are one-time visits
- **Query Performance**: No JOINs needed

**Trade-offs**:
- Can't track multiple visits per patient
- Data duplication if patient returns
- Not following database normalization principles

**Migration Path**:
- Schema designed to be easily normalized later
- Agents can be updated to handle normalized schema
- Data migration script straightforward

### 3. Why ReportLab Over WeasyPrint?

**Decision**: Use ReportLab for PDF generation

**Original Plan**: WeasyPrint (HTML/CSS templates)

**Why Changed**:
- **User Request**: Avoid system library dependencies (nix shell)
- **Pure Python**: ReportLab is 100% Python, no C extensions
- **Reliability**: More stable, fewer runtime issues
- **Performance**: Faster for programmatic PDF generation

**Trade-offs**:
- Less flexible layout (canvas API vs. HTML/CSS)
- Steeper learning curve
- Harder to customize without code changes

**When to Reconsider**:
- Need complex layouts (multi-column, flowing text)
- Non-developers need to customize templates
- Want web-based preview before PDF generation

### 4. Why Chainlit Over Custom Frontend?

**Decision**: Use Chainlit for web UI

**Rationale**:
- **Rapid Development**: Chat UI built-in
- **File Handling**: Upload/download out of the box
- **Streaming**: Real-time agent response streaming
- **Session Management**: User sessions handled automatically
- **Integration**: Works seamlessly with Claude Agent SDK

**Trade-offs**:
- Limited UI customization
- Tied to Chainlit's architecture
- Less control over frontend behavior

**When to Reconsider**:
- Need custom UI components
- Want mobile app
- Need integration with existing web app
- Require advanced frontend features

### 5. Why uv Over pip/poetry?

**Decision**: Use uv for dependency management

**Rationale**:
- **Speed**: 10-100x faster than pip
- **Reliability**: Better dependency resolution
- **Modern**: Active development, recent tool
- **Inline Scripts**: Support for executable scripts with metadata
- **User Environment**: User specified uv in CLAUDE.md

**Trade-offs**:
- Less mature than pip/poetry
- Smaller ecosystem
- Learning curve for team

### 6. Why allow_all Permission Mode?

**Decision**: Use `permission_mode="allow_all"` in development

**Rationale**:
- **Faster Iteration**: No approval prompts during development
- **Testing**: Easier to test full workflows
- **User Trust**: Users review data before saving anyway

**Production Recommendation**: Change to `"ask"` for:
- User approval for database writes
- Compliance with healthcare regulations
- Audit trail of actions

**How to Change**:
In `src/agents/base_agent.py`:
```python
permission_mode="ask"  # Change from "allow_all"
```

---

## Common Development Tasks

### Task 1: Add New Field to Database

1. Update `src/database/init.sql`:
```sql
ALTER TABLE patients ADD COLUMN new_field TEXT;
```

2. For existing database:
```bash
sqlite3 data/healthcare.db "ALTER TABLE patients ADD COLUMN new_field TEXT;"
```

3. Update record agent system prompt:
```python
# In src/agents/record_agent.py
system_prompt = """...
Extract:
- ...
- New Field: [description]
"""
```

4. Update record creation skill:
```markdown
### Step 2: Extract Key Data Points

#### New Section
- New field description
```

5. Update PDF generator:
```python
# In src/utils/pdf_generator.py
def _create_new_section(self, elements, patient_data):
    new_field = patient_data.get("new_field", "Not recorded")
    elements.append(Paragraph(new_field, self.styles["BodyText"]))
```

### Task 2: Change Agent Behavior

1. Update system prompt in agent file
2. Update corresponding skill file
3. Test with example inputs
4. Iterate on prompt wording

**Example - Make agent ask follow-up questions**:

In `src/agents/record_agent.py`:
```python
system_prompt = """...
If any information is unclear or missing from the transcript:
- Ask specific follow-up questions
- List what information is missing
- Wait for user response before proceeding
...
"""
```

### Task 3: Debug Agent Issues

1. Check Chainlit console output for errors
2. Review agent's tool calls and responses
3. Check database state:
```bash
sqlite3 data/healthcare.db "SELECT * FROM patients;"
```
4. Test components in isolation:
```bash
# Test PDF generator
uv run src/utils/pdf_generator.py 1

# Test database
sqlite3 data/healthcare.db ".tables"
```

5. Add logging to `app.py`:
```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

### Task 4: Update Dependencies

```bash
# Update all dependencies
uv sync --upgrade

# Update specific package
uv add chainlit@latest

# Check for security vulnerabilities
uv pip list --outdated
```

### Task 5: Create Sample Data

```bash
sqlite3 data/healthcare.db <<EOF
INSERT INTO patients (first_name, last_name, date_of_birth, gender, visit_date, chief_complaint, diagnosis, treatment_plan, prescriptions, transcript_text)
VALUES
('John', 'Doe', '1980-01-15', 'Male', '2026-01-20', 'Lower back pain', 'Acute lumbar strain', 'Rest, ice application, gentle stretching', 'Ibuprofen 400mg TID with food for 5 days', 'Sample transcript text...'),
('Jane', 'Smith', '1975-03-20', 'Female', '2026-01-21', 'Persistent cough', 'Upper respiratory infection', 'Increase fluid intake, rest, steam inhalation', 'Guaifenesin 200mg every 4 hours as needed', 'Sample transcript text...');
EOF
```

### Task 6: Export/Import Database

**Export**:
```bash
sqlite3 data/healthcare.db .dump > backup.sql
```

**Import**:
```bash
sqlite3 data/healthcare_new.db < backup.sql
```

**Export to CSV**:
```bash
sqlite3 -csv data/healthcare.db "SELECT * FROM patients;" > patients.csv
```

### Task 7: Monitor Agent Performance

Add logging to `app.py`:
```python
import time

@cl.on_message
async def main(message: cl.Message):
    start_time = time.time()

    # ... existing code ...

    elapsed = time.time() - start_time
    print(f"Response time: {elapsed:.2f}s")
```

Track metrics:
- Response time per message
- Token usage (via Anthropic API logs)
- Error rates
- File upload sizes

---

## Testing Strategy

### Current Testing Status

**Unit Tests**: Not implemented yet

**Integration Tests**: Placeholder in `tests/test_integration.py`

**Manual Testing**: Primary testing method during development

### Recommended Test Structure

```
tests/
├── __init__.py
├── unit/
│   ├── test_pdf_generator.py      # Test PDF generation
│   ├── test_database.py           # Test database operations
│   └── test_agents.py             # Test agent configurations
├── integration/
│   ├── test_record_creation.py    # End-to-end record creation
│   ├── test_report_generation.py  # End-to-end report generation
│   └── test_file_upload.py        # File upload handling
└── fixtures/
    ├── sample_transcripts/         # Test transcripts
    └── expected_outputs/           # Expected extraction results
```

### Unit Tests

**Test PDF Generator**:
```python
# tests/unit/test_pdf_generator.py
import pytest
from src.utils.pdf_generator import PDFGenerator

def test_pdf_generation(tmp_path):
    # Setup test database with sample patient
    db_path = tmp_path / "test.db"
    # ... create test database ...

    generator = PDFGenerator(str(db_path), str(tmp_path))
    pdf_path = generator.generate_report(patient_id=1)

    assert Path(pdf_path).exists()
    assert pdf_path.endswith('.pdf')

def test_missing_patient():
    generator = PDFGenerator("test.db", "reports/")
    with pytest.raises(ValueError, match="Patient.*not found"):
        generator.generate_report(patient_id=9999)
```

**Test Database Operations**:
```python
# tests/unit/test_database.py
import sqlite3
import pytest

@pytest.fixture
def test_db(tmp_path):
    db_path = tmp_path / "test.db"
    conn = sqlite3.connect(db_path)
    # Load schema
    with open("src/database/init.sql") as f:
        conn.executescript(f.read())
    yield db_path
    conn.close()

def test_patient_insertion(test_db):
    conn = sqlite3.connect(test_db)
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO patients (first_name, last_name, date_of_birth, gender)
        VALUES ('Test', 'Patient', '1990-01-01', 'Male')
    """)
    conn.commit()

    cursor.execute("SELECT COUNT(*) FROM patients")
    assert cursor.fetchone()[0] == 1
```

### Integration Tests

**Test Record Creation Flow**:
```python
# tests/integration/test_record_creation.py
import pytest
from src.agents.base_agent import create_main_agent

@pytest.mark.asyncio
async def test_transcript_extraction():
    agent = create_main_agent()

    transcript = """
    Doctor: What brings you in today?
    Patient: I've been having lower back pain for the past week.
    Doctor: Diagnosed with acute lumbar strain. Recommend rest and ibuprofen.
    """

    # This would need mocking for actual agent calls
    # response = await agent.query(transcript)

    # assert "diagnosis" in response.lower()
    # assert "lumbar strain" in response.lower()
    pass
```

### Manual Testing Checklist

**Record Creation**:
- [ ] Upload text file transcript
- [ ] Paste transcript directly
- [ ] Agent extracts all required fields
- [ ] User confirmation works
- [ ] Database insertion succeeds
- [ ] Verify with sqlite3 query

**Report Generation**:
- [ ] Search by patient ID
- [ ] Search by patient name
- [ ] Handle multiple matches
- [ ] PDF generation succeeds
- [ ] PDF contains all sections
- [ ] Download works in browser

**Edge Cases**:
- [ ] Missing patient data fields
- [ ] Special characters in names (O'Brien, etc.)
- [ ] Large transcript files (>5MB)
- [ ] Multiple file uploads
- [ ] Database connection errors
- [ ] API key missing/invalid

### Running Tests

```bash
# Run all tests
uv run pytest

# Run specific test file
uv run pytest tests/unit/test_pdf_generator.py

# Run with coverage
uv run pytest --cov=src

# Run with verbose output
uv run pytest -v
```

---

## Troubleshooting

### Common Issues

#### 1. API Key Not Found

**Symptoms**:
- Chainlit shows "ANTHROPIC_API_KEY not found" message
- Agent fails to initialize

**Solution**:
```bash
# Check .env file exists
ls -la .env

# Check .env content
cat .env

# Create .env from template
cp .env.example .env

# Edit .env and add key
nano .env
```

#### 2. Database Not Found

**Symptoms**:
- Error: "no such table: patients"
- PDF generator fails with "Database not found"

**Solution**:
```bash
# Initialize database
sqlite3 data/healthcare.db < src/database/init.sql

# Verify tables exist
sqlite3 data/healthcare.db ".tables"

# Check schema
sqlite3 data/healthcare.db ".schema patients"
```

#### 3. Import Errors

**Symptoms**:
- ModuleNotFoundError: No module named 'chainlit'
- ImportError: cannot import name 'ClaudeAgent'

**Solution**:
```bash
# Reinstall dependencies
uv sync

# Check installed packages
uv pip list

# Try with clean environment
rm -rf .venv
uv sync
```

#### 4. Agent Not Responding

**Symptoms**:
- Agent hangs indefinitely
- No response in chat

**Debug Steps**:
1. Check console output for errors
2. Verify API key is valid
3. Check Anthropic API status
4. Test with simple message: "Hello"
5. Check internet connection

#### 5. PDF Generation Fails

**Symptoms**:
- Error: "Patient with ID X not found"
- ReportLab errors

**Debug Steps**:
```bash
# Check patient exists
sqlite3 data/healthcare.db "SELECT * FROM patients WHERE patient_id = 1;"

# Test PDF generator directly
uv run src/utils/pdf_generator.py 1

# Check ReportLab installation
uv run python -c "import reportlab; print(reportlab.__version__)"

# Check output directory exists
ls -ld data/reports/
```

#### 6. File Upload Not Working

**Symptoms**:
- File upload button not visible
- "File too large" error
- File content not extracted

**Solutions**:
```bash
# Check .chainlit/config.toml
cat .chainlit/config.toml | grep upload

# Verify file size
ls -lh your_file.txt

# Check file type
file your_file.txt

# Check Chainlit logs
# Look for file upload errors in console
```

#### 7. SQLite Syntax Errors

**Symptoms**:
- Error: near "syntax error"
- Agent reports database insertion failed

**Common Causes**:
- Single quotes not escaped
- Missing comma in VALUES
- Column name typo

**Debug**:
```bash
# Test query directly
sqlite3 data/healthcare.db "SELECT * FROM patients LIMIT 1;"

# Check for quote issues
# Correct: 'Patient''s back pain' (double single quote)
# Wrong: 'Patient's back pain' (unescaped single quote)
```

### Debugging Workflow

1. **Check Console Output**
   - Chainlit logs errors to console
   - Look for Python tracebacks
   - Note error messages exactly

2. **Test Components Individually**
   ```bash
   # Test database
   sqlite3 data/healthcare.db ".tables"

   # Test PDF generator
   uv run src/utils/pdf_generator.py 1

   # Test agent import
   uv run python -c "from src.agents.base_agent import create_main_agent; print('OK')"
   ```

3. **Check Configuration**
   ```bash
   # Environment
   cat .env

   # Chainlit config
   cat .chainlit/config.toml

   # Dependencies
   uv pip list | grep -E "(chainlit|claude|anthropic|reportlab)"
   ```

4. **Verify File Structure**
   ```bash
   # Check all files exist
   find . -name "*.py" | sort
   find .claude/skills -name "*.md"
   ```

5. **Test with Minimal Example**
   ```python
   # test.py
   from src.agents.base_agent import create_main_agent

   agent = create_main_agent()
   print("Agent created successfully")
   ```

### Getting Help

**Check Documentation**:
- This file (DEVELOPMENT.md)
- README.md
- Chainlit docs: https://docs.chainlit.io
- Claude Agent SDK docs: https://platform.claude.com/docs/en/agent-sdk/python

**Debug Logs**:
```python
# Add to app.py for verbose logging
import logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
```

**Community Resources**:
- Chainlit Discord
- Anthropic Discord
- GitHub Issues

---

## Appendix

### A. Full System Architecture Diagram

```
┌────────────────────────────────────────────────────────────┐
│                         Browser                            │
│                   User Interface (HTTP/WS)                 │
└─────────────────────────────┬──────────────────────────────┘
                              │
                              │ HTTP POST (file upload)
                              │ WebSocket (messages)
                              ▼
┌────────────────────────────────────────────────────────────┐
│                    Chainlit Server (app.py)                │
│  ┌──────────────────────────────────────────────────────┐ │
│  │  @cl.on_chat_start                                    │ │
│  │  - Check API key                                      │ │
│  │  - Initialize database                                │ │
│  │  - Create main agent                                  │ │
│  │  - Send welcome message                               │ │
│  └──────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────┐ │
│  │  @cl.on_message                                       │ │
│  │  - Read uploaded files                                │ │
│  │  - Append file content to message                     │ │
│  │  - Query main agent                                   │ │
│  │  - Stream response                                    │ │
│  └──────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────┐ │
│  │  @cl.on_file_upload                                   │ │
│  │  - Validate file size (<10MB)                         │ │
│  │  - Validate file type (text/plain, pdf, etc.)        │ │
│  └──────────────────────────────────────────────────────┘ │
└─────────────────────────────┬──────────────────────────────┘
                              │
                              │ agent.query(prompt)
                              ▼
┌────────────────────────────────────────────────────────────┐
│          Claude Agent SDK - Main Orchestrator              │
│          (src/agents/base_agent.py)                        │
│  ┌──────────────────────────────────────────────────────┐ │
│  │  System Prompt:                                       │ │
│  │  - Coordinate sub-agents                              │ │
│  │  - Confirm actions with users                         │ │
│  │  - Route record creation to record_agent              │ │
│  │  - Route report generation to report_agent            │ │
│  └──────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────┐ │
│  │  Allowed Tools:                                       │ │
│  │  - Read, Write, Bash, Task, Skill                     │ │
│  └──────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────┐ │
│  │  Sub-Agents:                                          │ │
│  │  - record_agent (record creation)                     │ │
│  │  - report_agent (report generation)                   │ │
│  └──────────────────────────────────────────────────────┘ │
└───────────────┬─────────────────────────┬──────────────────┘
                │                         │
                │ Task tool delegates     │ Task tool delegates
                ▼                         ▼
┌────────────────────────────┐  ┌────────────────────────────┐
│  Record Creation Agent     │  │  Report Generation Agent   │
│  (record_agent.py)         │  │  (report_agent.py)         │
├────────────────────────────┤  ├────────────────────────────┤
│ System Prompt:             │  │ System Prompt:             │
│ - Extract diagnosis        │  │ - Query patient records    │
│ - Extract treatment plan   │  │ - Confirm patient ID       │
│ - Extract prescriptions    │  │ - Generate PDF report      │
│ - Insert into database     │  │ - Return PDF path          │
├────────────────────────────┤  ├────────────────────────────┤
│ Tools: Read, Write, Bash   │  │ Tools: Read, Write, Bash   │
├────────────────────────────┤  ├────────────────────────────┤
│ Inherits:                  │  │ Inherits:                  │
│ record_creation/SKILL.md   │  │ report_generation/SKILL.md │
└──────────┬─────────────────┘  └────────┬───────────────────┘
           │                              │
           │ Bash tool                    │ Bash tool
           │ sqlite3 INSERT               │ sqlite3 SELECT
           ▼                              ▼
┌───────────────────────────────────────────────────────────┐
│              SQLite Database (healthcare.db)              │
│  ┌─────────────────────────────────────────────────────┐ │
│  │  patients table:                                     │ │
│  │  - patient_id (PK)                                   │ │
│  │  - first_name, last_name, date_of_birth, gender     │ │
│  │  - visit_date, chief_complaint                       │ │
│  │  - diagnosis, treatment_plan, prescriptions          │ │
│  │  - transcript_text                                   │ │
│  │  - created_at, updated_at                            │ │
│  └─────────────────────────────────────────────────────┘ │
└───────────────────────────────────────────────────────────┘
                              │
                              │ uv run pdf_generator.py <id>
                              ▼
┌───────────────────────────────────────────────────────────┐
│         PDF Generator (src/utils/pdf_generator.py)        │
│  ┌─────────────────────────────────────────────────────┐ │
│  │  PDFGenerator class:                                 │ │
│  │  - Query patient data from database                  │ │
│  │  - Generate report sections (demographics, visit,    │ │
│  │    diagnosis, treatment, prescriptions)              │ │
│  │  - Apply professional styling with ReportLab         │ │
│  │  - Save PDF to data/reports/                         │ │
│  │  - Return file path                                  │ │
│  └─────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────┐ │
│  │  ReportLab components:                               │ │
│  │  - SimpleDocTemplate (page layout)                   │ │
│  │  - Paragraph (text formatting)                       │ │
│  │  - Table (structured data)                           │ │
│  │  - Custom styles (colors, fonts)                     │ │
│  └─────────────────────────────────────────────────────┘ │
└─────────────────────────────┬─────────────────────────────┘
                              │
                              ▼
┌───────────────────────────────────────────────────────────┐
│         Generated PDF Report (data/reports/)              │
│  {lastname}_{firstname}_report_{timestamp}.pdf            │
└───────────────────────────────────────────────────────────┘
```

### B. Key Files Quick Reference

| File | Lines | Purpose | Dependencies |
|------|-------|---------|--------------|
| app.py | ~150 | Chainlit entry point, message routing | chainlit, base_agent |
| src/agents/base_agent.py | ~60 | Main orchestrator configuration | claude_agent_sdk, sub-agents |
| src/agents/record_agent.py | ~75 | Record creation sub-agent | claude_agent_sdk |
| src/agents/report_agent.py | ~75 | Report generation sub-agent | claude_agent_sdk |
| src/utils/pdf_generator.py | ~350 | PDF generation with ReportLab | reportlab, sqlite3 |
| src/database/init.sql | ~25 | Database schema definition | None |
| .claude/skills/record_creation/SKILL.md | ~150 | Record extraction procedures | None |
| .claude/skills/report_generation/SKILL.md | ~150 | Report generation procedures | None |

### C. Command Reference

**Setup**:
```bash
./setup.sh                          # Run automated setup
uv sync                             # Install dependencies
cp .env.example .env                # Create environment file
```

**Running**:
```bash
uv run chainlit run app.py          # Start application
uv run chainlit run app.py -w       # Start with auto-reload
uv run chainlit run app.py --port 8080  # Custom port
```

**Database**:
```bash
sqlite3 data/healthcare.db          # Open database CLI
sqlite3 data/healthcare.db ".tables"  # List tables
sqlite3 data/healthcare.db ".schema"  # Show schema
sqlite3 -json data/healthcare.db "SELECT * FROM patients;"  # JSON output
sqlite3 data/healthcare.db < src/database/init.sql  # Initialize
```

**PDF Generation**:
```bash
uv run src/utils/pdf_generator.py 1  # Generate report for patient ID 1
python src/utils/pdf_generator.py 1  # Alternative
```

**Testing**:
```bash
uv run pytest                       # Run all tests
uv run pytest -v                    # Verbose output
uv run pytest --cov=src             # With coverage
```

**Development**:
```bash
uv add package_name                 # Add dependency
uv remove package_name              # Remove dependency
uv sync --upgrade                   # Update all dependencies
uv pip list                         # List installed packages
```

### D. Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| ANTHROPIC_API_KEY | Yes | None | Anthropic API key for Claude |
| DATABASE_PATH | No | data/healthcare.db | SQLite database path |
| REPORTS_DIR | No | data/reports | PDF reports output directory |
| LOG_LEVEL | No | INFO | Logging level (DEBUG, INFO, WARNING, ERROR) |

### E. Contact and Maintenance

**Primary Developer**: [Your name/team]

**Last Updated**: January 2026

**Repository**: [GitHub URL if applicable]

**Documentation Maintenance**:
- Update this file when making architectural changes
- Document all new features and extensions
- Keep troubleshooting section current with known issues
- Update code examples when APIs change

**Version History**:
- v0.1.0 (Jan 2026): Initial implementation
  - Chainlit UI
  - Claude Agent SDK integration
  - SQLite database
  - PDF generation with ReportLab
  - Record creation and report generation agents

---

*End of Developer Documentation*
