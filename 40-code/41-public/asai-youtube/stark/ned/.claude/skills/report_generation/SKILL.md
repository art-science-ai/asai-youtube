# Report Generation Skill

## Purpose

Generate comprehensive PDF patient summary reports from database records.

## Procedure

### Step 1: Gather Patient Identifier

Ask user to provide one of:
- Patient ID (most precise)
- Full name (first and last)
- Last name and date of birth

### Step 2: Query Database for Patient

Use sqlite3 to search for matching patient(s):

#### Search by Patient ID
```bash
sqlite3 -json data/healthcare.db "SELECT * FROM patients WHERE patient_id = [id];"
```

#### Search by Name
```bash
sqlite3 -json data/healthcare.db "SELECT patient_id, first_name, last_name, date_of_birth FROM patients WHERE last_name = '[lastname]';"
```

#### Search by Name and DOB
```bash
sqlite3 -json data/healthcare.db "SELECT patient_id, first_name, last_name, date_of_birth FROM patients WHERE last_name = '[lastname]' AND date_of_birth = '[dob]';"
```

### Step 3: Handle Multiple or No Matches

#### If No Patient Found:
- Inform user that no matching patient was found
- Suggest alternative search criteria
- Offer to list recent patients

#### If Multiple Patients Found:
- Display list of matching patients with patient_id, name, and date of birth
- Ask user to specify which patient by patient_id
- Wait for user response before proceeding

### Step 4: Confirm Patient Identity

Once a unique patient is identified:
- Display patient name and date of birth
- Ask user to confirm this is the correct patient
- Wait for explicit confirmation

### Step 5: Generate PDF Report

Call the PDF generator script with the patient_id:

```bash
python src/utils/pdf_generator.py [patient_id]
```

Or with uv:
```bash
uv run src/utils/pdf_generator.py [patient_id]
```

The script will:
- Query patient data from the database
- Generate a professionally formatted PDF
- Save to data/reports/
- Print the output path

### Step 6: Deliver Report

- Capture the output path from the PDF generator
- Inform user that the report was generated successfully
- Return the full path to the PDF file
- The Chainlit application will automatically present it as a downloadable file

## Error Handling

### Database Query Errors
- Verify database exists at data/healthcare.db
- Check for SQL syntax errors
- Provide clear error messages to user

### PDF Generation Errors
- Check if PDF generator script exists
- Verify reportlab dependency is installed
- Check file system permissions for data/reports/
- Provide troubleshooting guidance

### Patient Not Found
- Double-check search criteria
- Suggest alternative searches
- Offer to create a new patient record if appropriate

## Examples

### Example Search Flow

1. User: "Generate a report for John Doe"
2. Agent: Searches database
```bash
sqlite3 -json data/healthcare.db "SELECT patient_id, first_name, last_name, date_of_birth FROM patients WHERE first_name = 'John' AND last_name = 'Doe';"
```
3. If one match: Confirm identity
4. If multiple: List options and ask user to specify patient_id

### Example PDF Generation

```bash
uv run src/utils/pdf_generator.py 1
```

Expected output:
```
✅ PDF report generated successfully: data/reports/Doe_John_report_20260120_143022.pdf
```

### Example Complete Interaction

```
User: I need a report for patient ID 5

Agent: Let me query the patient information first.

[Runs: sqlite3 -json data/healthcare.db "SELECT * FROM patients WHERE patient_id = 5;"]

Agent: Found patient: Jane Smith, DOB: 1975-03-20
Is this the correct patient?

User: Yes

Agent: Generating PDF report...

[Runs: uv run src/utils/pdf_generator.py 5]

Agent: ✅ Report generated successfully!
Path: data/reports/Smith_Jane_report_20260120_143500.pdf
```

## Report Contents

The generated PDF includes:
- Title page with report generation timestamp
- Patient Demographics section
- Visit Information section
- Diagnosis section
- Treatment Plan section
- Prescriptions section

All formatted professionally with tables and proper styling.

## Notes

- Always confirm patient identity before generating reports
- Protect patient confidentiality
- Handle missing data gracefully in reports
- Provide full file paths for easy access
- Check that output directory (data/reports/) exists
