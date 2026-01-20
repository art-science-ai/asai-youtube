#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.10"
# dependencies = [
#   "reportlab>=4.2.5",
# ]
# ///

"""
Healthcare AI Assistant - PDF Report Generator

Generates professional PDF reports for patient records.
Can be called as a standalone script: python src/utils/pdf_generator.py <patient_id>
"""

import sqlite3
import sys
import os
from datetime import datetime
from pathlib import Path
from reportlab.lib.pagesizes import letter
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.lib.enums import TA_CENTER, TA_LEFT
from reportlab.platypus import (
    SimpleDocTemplate,
    Paragraph,
    Spacer,
    Table,
    TableStyle,
    PageBreak,
)
from reportlab.lib import colors


class PDFGenerator:
    """Professional PDF report generator for patient records."""

    def __init__(self, database_path: str, output_dir: str):
        """
        Initialize PDF generator.

        Args:
            database_path: Path to SQLite database
            output_dir: Directory to save generated PDFs
        """
        self.database_path = database_path
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.styles = getSampleStyleSheet()
        self._setup_custom_styles()

    def _setup_custom_styles(self):
        """Define custom paragraph styles for the report."""
        # Title style
        self.styles.add(
            ParagraphStyle(
                name="CustomTitle",
                parent=self.styles["Heading1"],
                fontSize=24,
                textColor=colors.HexColor("#2c3e50"),
                spaceAfter=30,
                alignment=TA_CENTER,
            )
        )

        # Section header style
        self.styles.add(
            ParagraphStyle(
                name="SectionHeader",
                parent=self.styles["Heading2"],
                fontSize=14,
                textColor=colors.HexColor("#2c3e50"),
                spaceAfter=12,
                spaceBefore=20,
                borderWidth=0,
                borderColor=colors.HexColor("#3498db"),
                borderPadding=5,
            )
        )

        # Body text style
        self.styles.add(
            ParagraphStyle(
                name="BodyText",
                parent=self.styles["Normal"],
                fontSize=11,
                leading=14,
                spaceAfter=10,
            )
        )

    def _get_patient_data(self, patient_id: int) -> dict:
        """
        Retrieve patient data from database.

        Args:
            patient_id: Patient ID to query

        Returns:
            Dictionary with patient data

        Raises:
            ValueError: If patient not found
        """
        conn = sqlite3.connect(self.database_path)
        conn.row_factory = sqlite3.Row  # Access columns by name
        cursor = conn.cursor()

        cursor.execute(
            """
            SELECT * FROM patients WHERE patient_id = ?
        """,
            (patient_id,),
        )

        row = cursor.fetchone()
        conn.close()

        if not row:
            raise ValueError(f"Patient with ID {patient_id} not found")

        return dict(row)

    def _create_header(self, elements):
        """Create report header with title."""
        elements.append(Paragraph("Patient Medical Report", self.styles["CustomTitle"]))
        elements.append(
            Paragraph(
                f"Generated: {datetime.now().strftime('%B %d, %Y at %I:%M %p')}",
                self.styles["Normal"],
            )
        )
        elements.append(Spacer(1, 0.3 * inch))

    def _create_patient_demographics(self, elements, patient_data):
        """Create patient demographics section."""
        elements.append(
            Paragraph("Patient Demographics", self.styles["SectionHeader"])
        )

        demographics_data = [
            ["Patient ID:", str(patient_data.get("patient_id", "N/A"))],
            [
                "Name:",
                f"{patient_data.get('first_name', 'N/A')} {patient_data.get('last_name', 'N/A')}",
            ],
            ["Date of Birth:", patient_data.get("date_of_birth", "N/A")],
            ["Gender:", patient_data.get("gender", "N/A")],
        ]

        demographics_table = Table(demographics_data, colWidths=[2 * inch, 4.5 * inch])
        demographics_table.setStyle(
            TableStyle(
                [
                    ("BACKGROUND", (0, 0), (0, -1), colors.HexColor("#ecf0f1")),
                    ("TEXTCOLOR", (0, 0), (-1, -1), colors.black),
                    ("ALIGN", (0, 0), (-1, -1), "LEFT"),
                    ("FONTNAME", (0, 0), (0, -1), "Helvetica-Bold"),
                    ("FONTNAME", (1, 0), (1, -1), "Helvetica"),
                    ("FONTSIZE", (0, 0), (-1, -1), 11),
                    ("TOPPADDING", (0, 0), (-1, -1), 8),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 8),
                    ("GRID", (0, 0), (-1, -1), 0.5, colors.grey),
                ]
            )
        )

        elements.append(demographics_table)
        elements.append(Spacer(1, 0.3 * inch))

    def _create_visit_information(self, elements, patient_data):
        """Create visit information section."""
        elements.append(Paragraph("Visit Information", self.styles["SectionHeader"]))

        visit_date = patient_data.get("visit_date", "N/A")
        chief_complaint = patient_data.get("chief_complaint", "Not recorded")

        visit_data = [
            ["Visit Date:", visit_date],
            ["Chief Complaint:", chief_complaint],
        ]

        visit_table = Table(visit_data, colWidths=[2 * inch, 4.5 * inch])
        visit_table.setStyle(
            TableStyle(
                [
                    ("BACKGROUND", (0, 0), (0, -1), colors.HexColor("#ecf0f1")),
                    ("TEXTCOLOR", (0, 0), (-1, -1), colors.black),
                    ("ALIGN", (0, 0), (-1, -1), "LEFT"),
                    ("FONTNAME", (0, 0), (0, -1), "Helvetica-Bold"),
                    ("FONTNAME", (1, 0), (1, -1), "Helvetica"),
                    ("FONTSIZE", (0, 0), (-1, -1), 11),
                    ("TOPPADDING", (0, 0), (-1, -1), 8),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 8),
                    ("GRID", (0, 0), (-1, -1), 0.5, colors.grey),
                    ("VALIGN", (0, 0), (-1, -1), "TOP"),
                ]
            )
        )

        elements.append(visit_table)
        elements.append(Spacer(1, 0.3 * inch))

    def _create_diagnosis_section(self, elements, patient_data):
        """Create diagnosis section."""
        elements.append(Paragraph("Diagnosis", self.styles["SectionHeader"]))

        diagnosis = patient_data.get("diagnosis", "No diagnosis recorded")
        elements.append(Paragraph(diagnosis, self.styles["BodyText"]))
        elements.append(Spacer(1, 0.2 * inch))

    def _create_treatment_plan_section(self, elements, patient_data):
        """Create treatment plan section."""
        elements.append(Paragraph("Treatment Plan", self.styles["SectionHeader"]))

        treatment_plan = patient_data.get("treatment_plan", "No treatment plan recorded")
        elements.append(Paragraph(treatment_plan, self.styles["BodyText"]))
        elements.append(Spacer(1, 0.2 * inch))

    def _create_prescriptions_section(self, elements, patient_data):
        """Create prescriptions section."""
        elements.append(Paragraph("Prescriptions", self.styles["SectionHeader"]))

        prescriptions = patient_data.get("prescriptions", "No prescriptions recorded")
        elements.append(Paragraph(prescriptions, self.styles["BodyText"]))
        elements.append(Spacer(1, 0.2 * inch))

    def generate_report(self, patient_id: int) -> str:
        """
        Generate PDF report for a patient.

        Args:
            patient_id: Patient ID to generate report for

        Returns:
            Path to generated PDF file

        Raises:
            ValueError: If patient not found
        """
        # Get patient data
        patient_data = self._get_patient_data(patient_id)

        # Generate filename
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        last_name = patient_data.get("last_name", "Unknown").replace(" ", "_")
        first_name = patient_data.get("first_name", "Unknown").replace(" ", "_")
        filename = f"{last_name}_{first_name}_report_{timestamp}.pdf"
        output_path = self.output_dir / filename

        # Create PDF document
        doc = SimpleDocTemplate(
            str(output_path),
            pagesize=letter,
            rightMargin=inch,
            leftMargin=inch,
            topMargin=inch,
            bottomMargin=inch,
        )

        # Build document content
        elements = []

        self._create_header(elements)
        self._create_patient_demographics(elements, patient_data)
        self._create_visit_information(elements, patient_data)
        self._create_diagnosis_section(elements, patient_data)
        self._create_treatment_plan_section(elements, patient_data)
        self._create_prescriptions_section(elements, patient_data)

        # Generate PDF
        doc.build(elements)

        return str(output_path)


def main():
    """Main entry point for command-line usage."""
    if len(sys.argv) < 2:
        print("Usage: python src/utils/pdf_generator.py <patient_id>")
        print("   or: uv run src/utils/pdf_generator.py <patient_id>")
        sys.exit(1)

    try:
        patient_id = int(sys.argv[1])
    except ValueError:
        print(f"Error: Invalid patient_id '{sys.argv[1]}'. Must be an integer.")
        sys.exit(1)

    # Get database path from environment or use default
    database_path = os.environ.get("DATABASE_PATH", "data/healthcare.db")
    reports_dir = os.environ.get("REPORTS_DIR", "data/reports")

    # Check if database exists
    if not os.path.exists(database_path):
        print(f"Error: Database not found at {database_path}")
        print("Run ./setup.sh to initialize the database.")
        sys.exit(1)

    # Generate report
    generator = PDFGenerator(database_path, reports_dir)

    try:
        pdf_path = generator.generate_report(patient_id)
        print(f"✅ PDF report generated successfully: {pdf_path}")
        sys.exit(0)
    except ValueError as e:
        print(f"Error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"Error generating PDF: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
