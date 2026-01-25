#!/usr/bin/env python3
"""
Pydantic models for medical data extraction.

Provides structured schemas for extracting diagnosis, treatment plan,
and prescriptions from visit transcripts.
"""

from pydantic import BaseModel, Field


class MedicalExtraction(BaseModel):
    """
    Structured medical data extraction from a visit transcript.

    This model defines the schema for extracting key medical information
    from doctor-patient conversation transcripts using Claude AI.

    Attributes:
        diagnosis: Primary diagnosis from the visit
        plan: Treatment plan and recommendations
        prescriptions: Prescribed medications with dosages

    Example:
        >>> extraction = MedicalExtraction(
        ...     diagnosis="Essential hypertension",
        ...     plan="Low-sodium diet, regular exercise, monitor BP at home",
        ...     prescriptions="Lisinopril 10mg once daily"
        ... )
        >>> extraction.diagnosis
        'Essential hypertension'
    """

    diagnosis: str = Field(
        description="Primary diagnosis from the visit"
    )

    plan: str = Field(
        description="Treatment plan and recommendations"
    )

    prescriptions: str = Field(
        description="Prescribed medications with dosages"
    )

    model_config = {
        "json_schema_mode": "validation"
    }


if __name__ == "__main__":
    # Test the model
    test = MedicalExtraction(
        diagnosis="Hypertension",
        plan="Lifestyle changes",
        prescriptions="Lisinopril 10mg"
    )

    assert test.diagnosis == "Hypertension"
    print("Model validation passed")
    print(test.model_json_schema())
