"""Seed the database with sample patient data for development.

Uses corpus data from Omi-Health medical-dialogue-to-soap-summary dataset.
Run `./scripts/download-transcripts.py` to regenerate corpus data.
"""

from database.models import get_connection, init_db


def seed_database() -> None:
    init_db()
    conn = get_connection()

    cursor = conn.execute("SELECT COUNT(*) FROM patients")
    if cursor.fetchone()[0] > 0:
        print("Database already seeded, skipping.")
        conn.close()
        return

    try:
        from database.seed_corpus import CORPUS_PATIENTS, CORPUS_VISITS

        for patient in CORPUS_PATIENTS:
            conn.execute(
                "INSERT INTO patients (name, date_of_birth, active_problems) VALUES (?, ?, ?)",
                (patient["name"], patient["date_of_birth"], patient.get("active_problems", "[]")),
            )

        for visit in CORPUS_VISITS:
            conn.execute(
                "INSERT INTO visits (patient_id, visit_date, transcript, subjective, objective, assessment, plan) "
                "VALUES (?, ?, ?, ?, ?, ?, ?)",
                (
                    visit["patient_id"],
                    visit["visit_date"],
                    visit["transcript"],
                    visit["subjective"],
                    visit["objective"],
                    visit["assessment"],
                    visit["plan"],
                ),
            )
        print(f"Database seeded with {len(CORPUS_PATIENTS)} patients and {len(CORPUS_VISITS)} visits.")
    except ImportError:
        print("No corpus data found. Run ./scripts/download-transcripts.py first.")

    conn.commit()
    conn.close()


if __name__ == "__main__":
    seed_database()
