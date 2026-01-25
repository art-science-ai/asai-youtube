# Record Creation Skill

## Purpose

Extract structured medical data from clinical visit transcripts and save to the patient database.

## Procedure

### Step 1: Receive Transcript

- Accept uploaded file or pasted text from user
- Validate that content is readable
- Acknowledge receipt and begin analysis

### Step 2: Extract Key Data Points

Carefully analyze the transcript to extract:

#### Patient Demographics
- First name
- Last name
- Date of birth (format: YYYY-MM-DD)
- Gender (Male/Female/Other)

#### Visit Information
- Visit date (format: YYYY-MM-DD)
- Chief complaint (primary reason for visit)

#### Diagnosis
- Primary diagnosis with medical terminology
- Secondary diagnoses if mentioned
- Severity indicators if present
- ICD codes if mentioned

#### Treatment Plan
- Specific interventions (medications, procedures)
- Lifestyle modifications (exercise, diet, rest)
- Follow-up schedule (when to return)
- Referrals to specialists if any

#### Prescriptions
- Medication name
- Dosage (e.g., 500mg, 10ml)
- Frequency (e.g., twice daily, every 8 hours, as needed)
- Duration (e.g., 7 days, 2 weeks)
- Special instructions (e.g., with food, before bedtime)

### Step 3: Structure and Present Data

Format extracted data clearly for user review:

```
Patient Information:
- Name: [First] [Last]
- Date of Birth: [YYYY-MM-DD]
- Gender: [Gender]

Visit Details:
- Date: [YYYY-MM-DD]
- Chief Complaint: [Complaint]

Diagnosis:
[Detailed diagnosis text]

Treatment Plan:
[Detailed plan text]

Prescriptions:
[Detailed prescriptions text]
```

Ask user to confirm or request modifications.

### Step 4: Handle User Feedback

- If user requests changes, update the extraction
- If user asks questions, clarify from the transcript
- Once confirmed, proceed to save

### Step 5: Save to Database

Use sqlite3 CLI to insert the record:

```bash
sqlite3 data/healthcare.db "INSERT INTO patients (first_name, last_name, date_of_birth, gender, visit_date, chief_complaint, diagnosis, treatment_plan, prescriptions, transcript_text) VALUES ('[first_name]', '[last_name]', '[dob]', '[gender]', '[visit_date]', '[chief_complaint]', '[diagnosis]', '[treatment_plan]', '[prescriptions]', '[transcript]');"
```

Important:
- Escape single quotes in text by doubling them ('')
- Example: "Patient's back" becomes "Patient''s back"
- Keep newlines as spaces in SQL strings

### Step 6: Verify and Confirm

After insertion, verify with:

```bash
sqlite3 data/healthcare.db "SELECT patient_id, first_name, last_name, visit_date FROM patients ORDER BY patient_id DESC LIMIT 1;"
```

Report success to user with the new patient_id.

## Error Handling

If database insertion fails:
- Check for constraint violations (missing required fields)
- Verify database file exists at data/healthcare.db
- Ensure proper quote escaping
- Provide clear error message to user
- Offer to retry with corrections

If transcript is unclear:
- Ask user for clarification
- Make reasonable assumptions and state them clearly
- Mark uncertain information explicitly

## Examples

### Example SQL Insert

```bash
sqlite3 data/healthcare.db "INSERT INTO patients (first_name, last_name, date_of_birth, gender, visit_date, chief_complaint, diagnosis, treatment_plan, prescriptions, transcript_text) VALUES ('John', 'Doe', '1980-01-15', 'Male', '2026-01-20', 'Lower back pain', 'Acute lumbar strain', 'Rest, ice application 20 min twice daily, gentle stretching exercises, follow-up in 2 weeks if not improved', 'Ibuprofen 400mg three times daily with food for 5 days', 'Doctor: Good morning, what brings you in today? Patient: I have been having lower back pain...');"
```

### Example Verification

```bash
sqlite3 data/healthcare.db "SELECT * FROM patients WHERE patient_id = 1;"
```

## Notes

- Always maintain patient confidentiality
- Use precise medical terminology when available
- Store complete transcript for future reference
- Be thorough but concise in extraction
- Confirm before any database modifications
