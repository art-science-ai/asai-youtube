# Report generation

Generate a professional patient summary report from existing records.

## When to use

Use this skill when the user wants to generate a summary report for a specific patient, including their visit history and clinical data.

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

### Common queries

```bash
# Get patient with all visits
sqlite3 -header -column /app/data/patients.db "
  SELECT p.name, p.date_of_birth, v.visit_date, v.diagnosis, v.plan, v.prescriptions
  FROM patients p
  JOIN visits v ON p.id = v.patient_id
  WHERE p.id = 1
  ORDER BY v.visit_date DESC;
"

# List all patients
sqlite3 /app/data/patients.db "SELECT id, name, date_of_birth FROM patients ORDER BY name;"

# Get most recent visit for a patient
sqlite3 /app/data/patients.db "SELECT * FROM visits WHERE patient_id = 1 ORDER BY visit_date DESC LIMIT 1;"
```

## Instructions

Generate a comprehensive patient summary report that includes:

- Patient demographics (name, date of birth)
- Visit history with dates
- Diagnoses across all visits
- Current treatment plans
- Active prescriptions
- Clinical timeline

## Process

- Ask the user which patient they want a report for (or use the patient they specified)
- Query the database to retrieve the patient's full record
- If the patient has no visits, inform the user
- Compile the data into a structured summary report
- Present the report to the user in a clear, professional format

## Output format

Structure the report as:

```
PATIENT SUMMARY REPORT
======================
Patient: [name]
Date of Birth: [dob]
Report Generated: [current date]

VISIT HISTORY
-------------
[For each visit:]
Date: [visit_date]
Diagnosis: [diagnosis]
Plan: [plan]
Prescriptions: [prescriptions]

ACTIVE CONDITIONS
-----------------
[List of most recent diagnoses]

CURRENT MEDICATIONS
-------------------
[List of most recent prescriptions]
```
