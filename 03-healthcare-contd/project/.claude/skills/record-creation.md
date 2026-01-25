# Record creation

Extract structured clinical data from a visit transcript and save it to the patient database using SOAP format.

## When to use

Use this skill when the user uploads or pastes a clinical visit transcript and wants to extract patient record data from it.

## Database

The SQLite database is at `data/patients.db`. Interact with it using the `sqlite3` CLI:

```bash
sqlite3 data/patients.db "SELECT * FROM patients;"
```

### Schema

```sql
CREATE TABLE patients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    date_of_birth TEXT,
    active_problems TEXT DEFAULT '[]',
    created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE visits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    visit_date TEXT DEFAULT (datetime('now')),
    transcript TEXT,
    subjective TEXT,
    objective TEXT,
    assessment TEXT,
    plan TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);
```

### Common operations

```bash
# List patients
sqlite3 data/patients.db "SELECT id, name, date_of_birth, active_problems FROM patients ORDER BY name;"

# Search by name
sqlite3 data/patients.db "SELECT * FROM patients WHERE name LIKE '%Smith%';"

# Create a patient
sqlite3 data/patients.db "INSERT INTO patients (name, date_of_birth, active_problems) VALUES ('Jane Doe', '1992-04-10', '[\"Hypertension\"]');"

# Save a visit
sqlite3 data/patients.db "INSERT INTO visits (patient_id, visit_date, transcript, subjective, objective, assessment, plan) VALUES (1, '2026-01-23T14:00:00', 'transcript text', 'Subjective notes', 'Objective findings', 'Assessment', 'Plan');"

# Update patient active problems
sqlite3 data/patients.db "UPDATE patients SET active_problems = '[\"Diabetes\", \"Hypertension\"]' WHERE id = 1;"
```

## SOAP format

Extract clinical documentation in SOAP format:

- Subjective: Patient's reported symptoms, history, and chief complaint in their own words
- Objective: Measurable findings from physical exam, vital signs, lab results
- Assessment: Clinical diagnosis or impression based on subjective and objective data
- Plan: Treatment plan including medications, referrals, follow-up instructions

## Process

- Read the transcript carefully
- Extract the Subjective section from patient statements and history
- Extract the Objective section from physical exam and test results
- Identify the Assessment (diagnosis) from the doctor's clinical impression
- Extract the Plan including medications, instructions, and follow-up
- Present the extracted SOAP data to the user for review
- Ask if this is for an existing patient (search by name) or a new patient
- If the user confirms, save the visit record using `sqlite3`
- Update the patient's active_problems if new conditions are identified
- If the user requests adjustments, modify the extracted data before saving

## Output format

Present extracted data in SOAP format:

```
S (Subjective): [patient-reported symptoms and history]
O (Objective): [exam findings, vital signs, test results]
A (Assessment): [diagnosis/clinical impression]
P (Plan): [treatment plan, medications, follow-up]
```

Ask the user to confirm or request changes before saving to the database.
