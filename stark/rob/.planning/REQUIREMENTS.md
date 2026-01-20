# Requirements: Healthcare AI Assistant

**Defined:** 2025-01-20
**Core Value:** Doctors can save time on documentation by uploading plain text visit transcripts and automatically extracting structured patient records with diagnosis, treatment plan, and prescriptions.

## v1 Requirements

### User Interface

- [ ] **UI-01**: User can send text messages through web chat interface
- [ ] **UI-02**: User can upload plain text transcript files
- [ ] **UI-03**: User can paste raw visit transcript text directly
- [ ] **UI-04**: User can download generated PDF reports

### Database

- [ ] **DB-01**: System stores patient records in SQLite database
- [ ] **DB-02**: Each record includes Diagnosis, Plan, Prescriptions, and timestamp
- [ ] **DB-03**: System can retrieve patient records by simple lookup (name/ID)

### Record Creation Agent

- [ ] **REC-01**: Agent extracts Diagnosis from conversation transcript
- [ ] **REC-02**: Agent extracts Plan (treatment recommendations) from conversation transcript
- [ ] **REC-03**: Agent extracts Prescriptions from conversation transcript
- [ ] **REC-04**: Agent displays extracted findings for review before saving
- [ ] **REC-05**: User can ask questions about extraction results
- [ ] **REC-06**: User can request adjustments to extracted findings
- [ ] **REC-07**: User can save reviewed findings to patient record

### Report Generation Agent

- [ ] **RPT-01**: User can specify patient details through chat
- [ ] **RPT-02**: Agent analyzes patient history and recent session data
- [ ] **RPT-03**: Agent generates condensed summary (diagnosis, treatment, current status)
- [ ] **RPT-04**: System generates professional PDF report
- [ ] **RPT-05**: User can download generated PDF report

## v2 Requirements

### Advanced Features

- **UI-05**: Image upload support (photos of conditions, documents)
- **RPT-06**: Multiple report formats (DOCX, HTML)
- **REC-08**: Confidence scores for each extracted field
- **DB-04**: Edit and delete existing records
- **DB-05**: Patient history timeline view

### Referrals

- **REF-01**: Agent generates referral letters based on patient data
- **REF-02**: Customizable referral templates for different specialties

## Out of Scope

| Feature | Reason |
|---------|--------|
| Real-time audio transcription | Not required — works with existing plain text transcripts |
| HIPAA compliance infrastructure | Personal tool, not handling regulated PHI |
| Multi-user authentication | Single-user personal tool |
| Multi-patient management system | Simple lookup sufficient for personal use |
| EHR system integration | Standalone tool for prototype |
| OAuth/login system | Personal deployment, no need for authentication |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| UI-01 | Phase 1 | Complete |
| UI-02 | Phase 1 | Complete |
| UI-03 | Phase 1 | Complete |
| UI-04 | Phase 3 | Pending |
| DB-01 | Phase 1 | Complete |
| DB-02 | Phase 1 | Complete |
| DB-03 | Phase 1 | Complete |
| REC-01 | Phase 2 | Pending |
| REC-02 | Phase 2 | Pending |
| REC-03 | Phase 2 | Pending |
| REC-04 | Phase 2 | Pending |
| REC-05 | Phase 2 | Pending |
| REC-06 | Phase 2 | Pending |
| REC-07 | Phase 2 | Pending |
| RPT-01 | Phase 3 | Pending |
| RPT-02 | Phase 3 | Pending |
| RPT-03 | Phase 3 | Pending |
| RPT-04 | Phase 3 | Pending |
| RPT-05 | Phase 3 | Pending |

**Coverage:**
- v1 requirements: 19 total
- Mapped to phases: 19
- Unmapped: 0 ✓

---
*Requirements defined: 2025-01-20*
*Last updated: 2025-01-20 after Phase 1 completion*
