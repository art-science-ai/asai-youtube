# Record creation

Extract structured clinical data from a visit transcript and save it to the patient database.

## When to use

Use this skill when the user uploads or pastes a clinical visit transcript and wants to extract patient record data from it.

## Database

The SQLite database is at `/app/data/patients.db`. Interact with it using the `sqlite3` CLI:

```bash
sqlite3 /app/data/patients.db "SELECT * FROM patients;"
```

### Schema

```sql
CREATE TABLE patients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    date_of_birth TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE visits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    visit_date TEXT DEFAULT (date('now')),
    transcript TEXT,
    diagnosis TEXT,
    plan TEXT,
    prescriptions TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);
```

### Common operations

```bash
# List patients
sqlite3 /app/data/patients.db "SELECT id, name, date_of_birth FROM patients ORDER BY name;"

# Search by name
sqlite3 /app/data/patients.db "SELECT * FROM patients WHERE name LIKE '%Smith%';"

# Create a patient
sqlite3 /app/data/patients.db "INSERT INTO patients (name, date_of_birth) VALUES ('Jane Doe', '1992-04-10');"

# Save a visit
sqlite3 /app/data/patients.db "INSERT INTO visits (patient_id, visit_date, transcript, diagnosis, plan, prescriptions) VALUES (1, '2026-01-23', 'transcript text', 'Diagnosis', 'Plan', 'Rx');"
```

## Instructions

Given a clinical visit transcript, extract:

- Diagnosis: The primary clinical diagnosis (e.g., "Acute Lower Back Strain")
- Plan: The treatment plan with specific actions (e.g., "Daily stretching, ice pack 20 mins twice daily")
- Prescriptions: Any medications prescribed with dosage and instructions (e.g., "Naproxen 500mg twice daily with food for 10 days")

## Process

- Read the transcript carefully
- Identify the diagnosis from the doctor's assessment
- Extract the treatment plan from the doctor's recommendations
- List all prescribed medications with dosage information
- Present the extracted data to the user for review
- Ask if this is for an existing patient (search by name) or a new patient
- If the user confirms, save the visit record using `sqlite3`
- If the user requests adjustments, modify the extracted data before saving

## Output format

Present extracted data clearly:

```
Diagnosis: [extracted diagnosis]
Plan: [extracted plan]
Prescriptions: [extracted prescriptions]
```

Ask the user to confirm or request changes before saving to the database.
