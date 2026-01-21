#!/usr/bin/env python3
"""
SQLite database module for patient records.

Provides CRUD operations for storing and retrieving patient data
including diagnosis, treatment plan, and prescriptions.
"""

import sqlite3
import os
from typing import Optional, Dict, Any


# Database file path
DB_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "patient_records.db")


def init_db() -> bool:
    """
    Initialize the SQLite database by creating the patient_records table if it doesn't exist.

    Returns:
        bool: True if successful, False otherwise
    """
    try:
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()

        # Create patient_records table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS patient_records (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                patient_name TEXT NOT NULL,
                patient_id TEXT NOT NULL,
                diagnosis TEXT,
                plan TEXT,
                prescriptions TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        """)

        conn.commit()
        conn.close()
        return True

    except sqlite3.Error as e:
        print(f"Error initializing database: {e}", file=__import__("sys").stderr)
        return False


def create_patient_record(
    patient_name: str,
    patient_id: str,
    diagnosis: str,
    plan: str,
    prescriptions: str
) -> Optional[int]:
    """
    Create a new patient record in the database.

    Args:
        patient_name: Name of the patient
        patient_id: Unique identifier for the patient
        diagnosis: Medical diagnosis
        plan: Treatment plan
        prescriptions: Prescribed medications

    Returns:
        int: The ID of the created record, or None if failed
    """
    try:
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()

        cursor.execute("""
            INSERT INTO patient_records (patient_name, patient_id, diagnosis, plan, prescriptions)
            VALUES (?, ?, ?, ?, ?)
        """, (patient_name, patient_id, diagnosis, plan, prescriptions))

        conn.commit()
        record_id = cursor.lastrowid
        conn.close()

        return record_id

    except sqlite3.Error as e:
        print(f"Error creating patient record: {e}", file=__import__("sys").stderr)
        return None


def get_patient_record(identifier: str) -> Optional[Dict[str, Any]]:
    """
    Retrieve a patient record by patient name or patient ID.
    Returns the most recent match if multiple records exist.

    Args:
        identifier: Patient name or patient ID to search for

    Returns:
        dict: Patient record with keys: id, patient_name, patient_id, diagnosis, plan, prescriptions, created_at
              or None if not found
    """
    try:
        conn = sqlite3.connect(DB_PATH)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()

        # Search by either patient_name or patient_id
        cursor.execute("""
            SELECT id, patient_name, patient_id, diagnosis, plan, prescriptions, created_at
            FROM patient_records
            WHERE patient_name = ? OR patient_id = ?
            ORDER BY created_at DESC
            LIMIT 1
        """, (identifier, identifier))

        row = cursor.fetchone()
        conn.close()

        if row:
            return {
                "id": row["id"],
                "patient_name": row["patient_name"],
                "patient_id": row["patient_id"],
                "diagnosis": row["diagnosis"],
                "plan": row["plan"],
                "prescriptions": row["prescriptions"],
                "created_at": row["created_at"]
            }
        else:
            return None

    except sqlite3.Error as e:
        print(f"Error retrieving patient record: {e}", file=__import__("sys").stderr)
        return None


if __name__ == "__main__":
    # Test database initialization
    print("Initializing database...")
    if init_db():
        print(f"Database initialized successfully at: {DB_PATH}")
    else:
        print("Failed to initialize database")
