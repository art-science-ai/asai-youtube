# Report generation

Generate a professional patient summary report from existing records using SOAP format.

## When to use

Use this skill when the user wants to generate a summary report for a specific patient, including their visit history and clinical data.

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

### Common queries

```bash
# Get patient with all visits (SOAP format)
sqlite3 -header -column data/patients.db "
  SELECT p.name, p.date_of_birth, p.active_problems,
         v.visit_date, v.subjective, v.objective, v.assessment, v.plan
  FROM patients p
  JOIN visits v ON p.id = v.patient_id
  WHERE p.id = 1
  ORDER BY v.visit_date DESC;
"

# List all patients with active problems
sqlite3 data/patients.db "SELECT id, name, date_of_birth, active_problems FROM patients ORDER BY name;"

# Get most recent visit for a patient
sqlite3 data/patients.db "SELECT * FROM visits WHERE patient_id = 1 ORDER BY visit_date DESC LIMIT 1;"

# Get all assessments (diagnoses) for a patient
sqlite3 data/patients.db "SELECT visit_date, assessment FROM visits WHERE patient_id = 1 ORDER BY visit_date DESC;"
```

## Instructions

Generate a comprehensive patient summary report that includes:

- Patient demographics (name, date of birth)
- Active problems list
- Visit history with dates
- SOAP documentation for each visit
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

ACTIVE PROBLEMS
---------------
[List from active_problems JSON field]

VISIT HISTORY
-------------
[For each visit:]

Visit Date: [visit_date]

S (Subjective):
[subjective notes]

O (Objective):
[objective findings]

A (Assessment):
[assessment/diagnosis]

P (Plan):
[plan details]

---

CLINICAL SUMMARY
----------------
[Brief narrative summary of patient's condition and care trajectory]
```
