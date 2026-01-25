# Healthcare AI Assistant

A personal healthcare AI assistant that helps doctors populate medical records from plain text conversation transcripts using Claude AI.

## Features

- **Web Chat Interface**: Chainlit-based UI for text, file uploads, and multi-turn conversations
- **AI-Powered Extraction**: Automatically extracts Diagnosis, Plan, and Prescriptions from visit transcripts
- **Interactive Review**: Approve, adjust, or cancel extraction results before saving
- **Q&A Support**: Ask questions about extraction results in natural language
- **Patient Records**: SQLite database for storing and retrieving patient records
- **Conversational Adjustments**: Type "Add aspirin" to update prescriptions naturally

## Tech Stack

- **UI**: Chainlit (Python web framework for AI chat interfaces)
- **AI**: Anthropic Claude API with AsyncAnthropic client
- **Database**: SQLite
- **Python**: 3.11+

## Setup

### 1. Install Dependencies

Using `uv` (recommended):
```bash
uv sync
```

Or using pip:
```bash
pip install -r requirements.txt
```

### 2. Configure Anthropic API Key

**Important:** This application uses the Anthropic API programmatically and requires an API key. Your Claude Code OAuth credentials in `~/.claude` are for the CLI tool and won't work for this application.

Get your API key from: https://console.anthropic.com/settings/keys

**Option A: Environment variable**
```bash
export ANTHROPIC_API_KEY=sk-ant-...
```

**Option B: .env file**
```bash
cp .env.example .env
# Edit .env and add your key:
# ANTHROPIC_API_KEY=sk-ant-...
```

## Running the Application

```bash
chainlit run app.py -w
```

The `-w` flag enables auto-reload during development.

**Access the interface at:** http://localhost:8000

### Alternative: Using Devbox

If you have `devbox` installed, the project includes `devbox.json` for consistent environments:

```bash
devbox shell
chainlit run app.py -w
```

## Usage

### Upload & Extract Workflow

1. **Upload a transcript**
   - Click the file upload button in the chat interface
   - Select a `.txt` file containing a visit transcript
   - AI will automatically extract Diagnosis, Plan, and Prescriptions

2. **Review the extraction**
   - Results display in a formatted review interface
   - Three action buttons available:
     - **Approve & Save**: Save to database with patient information
     - **Make Adjustments**: Request changes using natural language
     - **Cancel**: Discard the extraction

3. **Approve & Save**
   - Click "Approve & Save" button
   - Enter patient information when prompted:
     ```
     name: Patient Name, id: P001
     ```
   - System saves record and displays confirmation with record ID

4. **Make Adjustments**
   - Click "Make Adjustments" button
   - Type your request in natural language:
     ```
     Add aspirin 81mg daily to prescriptions
     ```
   - AI updates extraction and shows revised results
   - You can make multiple adjustments iteratively

5. **Ask Questions**
   - While extraction is displayed, ask questions:
     ```
     What is the diagnosis?
     What medications are prescribed?
     ```
   - AI answers questions about the extraction results

### Manual Commands

The system also supports direct text commands:

**Save a record:**
```
save: Patient Name|P001|Acute Back Strain|Physical therapy|Naproxen 500mg
```

**Lookup a record:**
```
lookup: Patient Name
lookup: P001
```

## Testing Guide

### Test Data

Create a test transcript at `/tmp/test_transcript_medical.txt`:

```text
Doctor: Good morning. What brings you in today?
Patient: I've been having lower back pain for about a week now. It hurts especially when I bend over.
Doctor: I see. Can you describe the pain? Is it sharp or dull?
Patient: It's a dull ache that gets sharper with movement. No shooting pain down my legs.
Doctor: Okay. Let me examine you. ... Based on your symptoms and examination, I believe you have an acute lower back strain. This is a muscle injury that should heal with rest and gentle stretching.

I recommend daily stretching exercises for 15 minutes. Apply ice packs to the affected area for 20 minutes, 3 times a day. Avoid heavy lifting for 2 weeks.

For pain management, I'm prescribing Naproxen 500mg, take twice daily with food. This will help reduce inflammation and pain. Follow up with me in 2 weeks if the pain persists.

Patient: Thank you, doctor. Is there anything else I should watch for?
Doctor: If you develop fever, bowel or bladder problems, or numbness in your legs, seek immediate care. Otherwise, rest and follow the treatment plan.
```

### Verification Steps

1. **Start the application** (see Running section above)

2. **Test file upload & extraction:**
   - Upload `/tmp/test_transcript_medical.txt`
   - ✓ Verify extraction displays with all three fields:
     - Diagnosis: Acute lower back strain
     - Plan: Daily stretching, ice packs 20 min 3x daily
     - Prescriptions: Naproxen 500mg twice daily with food

3. **Test Q&A:**
   - While extraction is displayed, type: `What is the diagnosis?`
   - ✓ Verify Claude answers based on extraction

4. **Test Approve & Save:**
   - Click "Approve & Save" button
   - Enter: `name: Test Patient, id: T001`
   - ✓ Verify success message with record ID

5. **Test lookup:**
   - Type: `lookup: Test Patient`
   - ✓ Verify saved record displays correctly

6. **Test Cancel:**
   - Upload file again
   - Click "Cancel" button
   - ✓ Verify extraction is discarded (no confirmation message)

7. **Test Adjustments:**
   - Upload file again
   - Click "Make Adjustments" button
   - Type: `Add aspirin 81mg daily to prescriptions`
   - ✓ Verify updated extraction shows new prescription

8. **Test backward compatibility:**
   - Type: `save: Manual|T999|Test Diagnosis|Test Plan|Test Rx`
   - ✓ Verify save works
   - Type: `lookup: Manual`
   - ✓ Verify lookup works

## Project Structure

```
├── app.py                          # Chainlit application
├── database.py                     # SQLite database module
├── requirements.txt                # Python dependencies
├── .env.example                    # API key template
├── src/
│   ├── agents/
│   │   └── extraction_agent.py     # Claude extraction agent
│   ├── models/
│   │   └── medical_record.py       # Pydantic models
│   └── utils/
│       └── file_handler.py         # File reading utilities
├── patient_records.db              # SQLite database (auto-created)
└── .planning/                      # Project planning artifacts
```

## Development

### Adding Features

The project uses GSD (Get Shit Done) for planning. Key commands:

- `/gsd:progress` — Check project status
- `/gsd:plan-phase X` — Plan next phase
- `/gsd:execute-phase X` — Execute phase plans

### Architecture

- **AsyncAnthropic Client**: Non-blocking AI operations
- **Tool Use Pattern**: Structured extraction with validation
- **Session State**: Multi-turn conversation management
- **Action Buttons**: Interactive workflow with approve/adjust/cancel

## Troubleshooting

**"Module not found" errors:**
```bash
uv sync  # Reinstall dependencies
```

**"API key not found":**
- Ensure ANTHROPIC_API_KEY is set in environment or .env file
- Check .env file is in project root directory

**"Runtime error with libstdc++" (Linux/containerized environments):**
- Chainlit requires C++ standard library
- Install via system package manager or use devbox for consistent environment
- Example: `sudo apt-get install libstdc++6` (Ubuntu/Debian)

**Extraction not working:**
- Verify API key is valid: https://console.anthropic.com/settings/keys
- Check transcript is plain text (.txt) format
- Ensure transcript has clear medical dialogue

## License

Personal project for individual use.
