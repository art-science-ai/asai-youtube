# Product Requirements

## Overview

A healthcare AI assistant that helps doctors populate medical records from conversation transcripts and interact with patient records using natural language. Key features:

- Web chat interface where you can exchange text, images, and files
- Patient records database which is updated and queried by AI agents
- AI agents specializing in two different tasks: (1) populating a new patient record from a conversation transcript, (2) generating a patient summary report from an existing record


## How it works

### Record creation agent

- Upload or paste raw visit transcripts
- AI extracts the Big Three data points:
  - Diagnosis (e.g., "Acute Lower Back Strain")
  - Plan (e.g., "Daily stretching, ice pack 20 mins")
  - Prescriptions (e.g., "Naproxen 500mg")
- Review extracted findings and save to patient record
- Ask questions about extraction results and request adjustments

### Report generation agent

- Chat to specify patient details
- AI analyzes patient history and recent session data
- Generate and download a professional PDF report


## Tech details

- UI: Simple web chat interface (text, images, file uploads/downloads)
- AI Agent: Claude Agent SDK with specialized sub-agents / skills for Records and Referrals
- Knowledge base: SQLite database with patient records


## References

[microsoft/clinical_visit_note_summarization_corpus: A corpus of textual data corresponding to synthetic clinical encounters, including each encounters' dialogue transcript and clinical notes.](https://github.com/microsoft/clinical_visit_note_summarization_corpus)
