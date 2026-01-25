"""Seed the database with sample patient data for development."""

from database.models import get_connection, init_db


SAMPLE_PATIENTS = [
    {"name": "John Smith", "date_of_birth": "1985-03-15"},
    {"name": "Maria Garcia", "date_of_birth": "1990-07-22"},
    {"name": "Robert Johnson", "date_of_birth": "1978-11-08"},
]

SAMPLE_VISITS = [
    {
        "patient_id": 1,
        "visit_date": "2025-12-01",
        "transcript": (
            "Doctor: Good morning John, what brings you in today?\n"
            "Patient: I've been having lower back pain for about a week now. "
            "It started after I was moving some heavy boxes.\n"
            "Doctor: I see. On a scale of 1-10, how would you rate the pain?\n"
            "Patient: About a 6. It's worse in the morning.\n"
            "Doctor: Based on my examination, this appears to be an acute lower back strain. "
            "I'd recommend daily stretching exercises, applying an ice pack for 20 minutes "
            "twice a day, and I'll prescribe Naproxen 500mg to help with the inflammation."
        ),
        "diagnosis": "Acute Lower Back Strain",
        "plan": "Daily stretching exercises, ice pack 20 mins twice daily, follow-up in 2 weeks",
        "prescriptions": "Naproxen 500mg twice daily with food for 10 days",
    },
    {
        "patient_id": 2,
        "visit_date": "2025-12-10",
        "transcript": (
            "Doctor: Hello Maria, how are you feeling today?\n"
            "Patient: Not great. I've had this persistent cough for about two weeks "
            "and some congestion.\n"
            "Doctor: Any fever or body aches?\n"
            "Patient: Low-grade fever, around 99.5. No body aches though.\n"
            "Doctor: Your lungs sound clear. This looks like an upper respiratory infection. "
            "I'd recommend rest, plenty of fluids, and I'll prescribe a cough suppressant. "
            "If symptoms worsen or you develop a high fever, come back immediately."
        ),
        "diagnosis": "Upper Respiratory Infection",
        "plan": "Rest, increased fluid intake, monitor for worsening symptoms, return if fever exceeds 101F",
        "prescriptions": "Dextromethorphan 30mg every 6-8 hours as needed for cough",
    },
]


def seed_database() -> None:
    init_db()
    conn = get_connection()

    cursor = conn.execute("SELECT COUNT(*) FROM patients")
    if cursor.fetchone()[0] > 0:
        print("Database already seeded, skipping.")
        conn.close()
        return

    for patient in SAMPLE_PATIENTS:
        conn.execute(
            "INSERT INTO patients (name, date_of_birth) VALUES (?, ?)",
            (patient["name"], patient["date_of_birth"]),
        )

    for visit in SAMPLE_VISITS:
        conn.execute(
            "INSERT INTO visits (patient_id, visit_date, transcript, diagnosis, plan, prescriptions) "
            "VALUES (?, ?, ?, ?, ?, ?)",
            (
                visit["patient_id"],
                visit["visit_date"],
                visit["transcript"],
                visit["diagnosis"],
                visit["plan"],
                visit["prescriptions"],
            ),
        )

    conn.commit()
    conn.close()
    print("Database seeded with sample data.")


if __name__ == "__main__":
    seed_database()
