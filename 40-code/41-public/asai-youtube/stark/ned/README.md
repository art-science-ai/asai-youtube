# Healthcare AI Assistant

A healthcare AI assistant that helps doctors populate medical records from conversation transcripts and generate patient summary reports using natural language.

## Features

- Web chat interface for text, images, and file uploads
- Extract diagnosis, treatment plans, and prescriptions from visit transcripts
- Patient records database (SQLite)
- Generate professional PDF reports
- AI agents powered by Claude Agent SDK

## Architecture

### Tech Stack

- **Chainlit**: Python-based chat UI framework
- **Claude Agent SDK**: AI agent orchestration with sub-agents
- **SQLite**: Patient records database
- **ReportLab**: PDF generation
- **uv**: Python dependency management

### Agent Architecture

```
Main Agent (Orchestrator)
├── Record Creation Sub-agent
│   ├── Skill: record_creation
│   └── Tools: Read, Write, Bash (sqlite3)
└── Report Generation Sub-agent
    ├── Skill: report_generation
    └── Tools: Read, Write, Bash (sqlite3, PDF generator)
```

## Setup

### Prerequisites

- Python 3.10 or higher
- [uv](https://docs.astral.sh/uv/getting-started/installation/) package manager
- [Anthropic API key](https://console.anthropic.com/)

### Installation

1. Clone or download this repository

2. Run the setup script:
```bash
./setup.sh
```

This will:
- Install dependencies with uv
- Initialize the SQLite database
- Create .env file from template

3. Add your Anthropic API key to `.env`:
```bash
ANTHROPIC_API_KEY=your_api_key_here
```

### Manual Setup

If you prefer manual setup:

```bash
# Install dependencies
uv sync

# Create .env file
cp .env.example .env
# Edit .env and add your ANTHROPIC_API_KEY

# Initialize database
sqlite3 data/healthcare.db < src/database/init.sql
```

## Usage

### Starting the Application

```bash
uv run chainlit run app.py
```

The application will open in your browser at `http://localhost:8000`

### Creating Patient Records

1. Upload a clinical visit transcript (text file) or paste it directly in chat
2. The AI agent will extract:
   - Patient demographics (name, DOB, gender)
   - Visit information (date, chief complaint)
   - Diagnosis
   - Treatment plan
   - Prescriptions
3. Review the extracted information
4. Confirm to save to database

### Generating Reports

1. Request a report by patient name or ID
   - Example: "Generate a report for patient ID 1"
   - Example: "Create a report for John Doe"
2. The AI agent will:
   - Query the patient from the database
   - Confirm patient identity
   - Generate a professional PDF report
3. Download the PDF report

## Project Structure

```
.
├── app.py                          # Main Chainlit application
├── pyproject.toml                  # Dependencies
├── setup.sh                        # Setup script
├── .env.example                    # Environment variables template
├── .chainlit/
│   └── config.toml                 # Chainlit configuration
├── .claude/
│   └── skills/
│       ├── record_creation/        # Record extraction procedures
│       └── report_generation/      # Report generation procedures
├── src/
│   ├── agents/
│   │   ├── base_agent.py          # Main orchestrator
│   │   ├── record_agent.py        # Record creation sub-agent
│   │   └── report_agent.py        # Report generation sub-agent
│   ├── database/
│   │   └── init.sql               # Database schema
│   └── utils/
│       └── pdf_generator.py       # PDF generation
├── data/
│   ├── healthcare.db              # SQLite database
│   ├── reports/                   # Generated PDF reports
│   └── sample_transcripts/        # Sample data
└── tests/
    └── test_integration.py        # Integration tests
```

## Database Schema

Single table: `patients`

- patient_id (PRIMARY KEY)
- first_name, last_name
- date_of_birth, gender
- visit_date, chief_complaint
- diagnosis, treatment_plan, prescriptions
- transcript_text (full transcript for reference)
- created_at, updated_at

## Key Implementation Details

### Agent-Tool Integration

- Agents use sqlite3 CLI directly via Bash tool
- No custom MCP servers - keeps architecture simple
- PDF generator callable as standalone Python script
- Skills provide procedural knowledge for agents

### Database Operations

Agents execute sqlite3 commands directly:

```bash
# Insert patient
sqlite3 data/healthcare.db "INSERT INTO patients (...) VALUES (...);"

# Query patient
sqlite3 -json data/healthcare.db "SELECT * FROM patients WHERE patient_id = 1;"
```

### PDF Generation

Agents call the PDF generator script:

```bash
uv run src/utils/pdf_generator.py <patient_id>
```

## Development

### Running Tests

```bash
uv run pytest tests/
```

### Manual Database Operations

```bash
# View schema
sqlite3 data/healthcare.db ".schema"

# List all patients
sqlite3 -json data/healthcare.db "SELECT * FROM patients;"

# Query specific patient
sqlite3 -json data/healthcare.db "SELECT * FROM patients WHERE patient_id = 1;"
```

### Manual PDF Generation

```bash
# Generate report for patient ID 1
uv run src/utils/pdf_generator.py 1
```

## Configuration

### Environment Variables

Edit `.env` file:

- `ANTHROPIC_API_KEY`: Your Anthropic API key (required)
- `DATABASE_PATH`: Path to SQLite database (default: data/healthcare.db)
- `REPORTS_DIR`: Directory for PDF reports (default: data/reports)
- `LOG_LEVEL`: Logging level (default: INFO)

### Chainlit Configuration

Edit `.chainlit/config.toml` to customize:

- UI name and appearance
- File upload limits
- Multi-modal features
- Telemetry settings

## Troubleshooting

### API Key Not Found

Make sure `.env` file exists with your `ANTHROPIC_API_KEY`:

```bash
cp .env.example .env
# Edit .env and add your key
```

### Database Not Found

Initialize the database:

```bash
sqlite3 data/healthcare.db < src/database/init.sql
```

### Import Errors

Install dependencies:

```bash
uv sync
```

### PDF Generation Errors

Check that ReportLab is installed:

```bash
uv run python -c "import reportlab; print('OK')"
```

## Sample Data

Download sample transcripts from the Microsoft Clinical Visit Note Summarization Corpus:

https://github.com/microsoft/clinical_visit_note_summarization_corpus

Place them in `data/sample_transcripts/` for testing.

## Production Considerations

For production deployment:

- Change agent `permission_mode` from "allow_all" to "ask"
- Switch to PostgreSQL for multi-user support
- Add authentication (Chainlit supports custom auth)
- Enable HTTPS/TLS
- Implement audit logging
- Encrypt database at rest
- Comply with HIPAA/healthcare regulations
- Use managed secrets for API keys
- Deploy with Docker or cloud platform

## References

- [Chainlit Documentation](https://docs.chainlit.io)
- [Claude Agent SDK](https://platform.claude.com/docs/en/agent-sdk/python)
- [ReportLab User Guide](https://docs.reportlab.com)
- [Microsoft Clinical Dataset](https://github.com/microsoft/clinical_visit_note_summarization_corpus)

## License

MIT License - see LICENSE file for details
