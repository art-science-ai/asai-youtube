#!/usr/bin/env python3
"""
Claude-powered medical data extraction agent.

Uses Anthropic's tool use API with Pydantic validation to extract
structured medical data from visit transcripts.
"""

from anthropic import AsyncAnthropic, beta_tool
from pydantic import BaseModel

from src.models.medical_record import MedicalExtraction


@beta_tool
def extract_medical_data(transcript: str) -> MedicalExtraction:
    """
    Extract structured medical data from a visit transcript.

    This tool is called by Claude to extract diagnosis, treatment plan,
    and prescriptions from doctor-patient conversation transcripts.

    Args:
        transcript: Full text of doctor-patient conversation

    Returns:
        MedicalExtraction with diagnosis, plan, and prescriptions
    """
    # Claude calls this, we validate the result
    # The function body is a pass - the actual extraction happens
    # when Claude calls this tool and we validate its output
    pass


async def run_extraction(transcript: str, api_key: str) -> MedicalExtraction:
    """
    Run medical data extraction using Claude tool use.

    This function orchestrates the extraction process by:
    1. Creating an async Anthropic client
    2. Sending the transcript to Claude with the extract_medical_data tool
    3. Extracting the tool_use response from Claude
    4. Validating the extracted data with Pydantic

    Args:
        transcript: Full text of visit transcript
        api_key: Anthropic API key

    Returns:
        MedicalExtraction with extracted data

    Raises:
        Exception: If extraction fails or Claude doesn't call tool
    """
    client = AsyncAnthropic(api_key=api_key)

    system_prompt = """You are a medical documentation assistant. Extract structured medical data from visit transcripts.
Focus on accurate diagnosis, clear treatment plans, and complete prescription information."""

    user_message = f"""Extract the following information from this transcript:

{transcript}

Use the extract_medical_data tool to provide the extracted information."""

    # Call Claude with tool
    response = await client.messages.create(
        model="claude-sonnet-4-5-20250929",
        max_tokens=4096,
        system=system_prompt,
        messages=[{"role": "user", "content": user_message}],
        tools=[extract_medical_data],
    )

    # Verify Claude called the tool
    if response.stop_reason != "tool_use":
        raise Exception(
            f"Claude did not call the extraction tool. Stop reason: {response.stop_reason}"
        )

    # Extract tool use from response
    tool_use = next(
        (block for block in response.content if block.type == "tool_use"),
        None
    )

    if not tool_use:
        raise Exception("No tool_use block found in Claude response")

    # Validate and return MedicalExtraction
    try:
        extraction = MedicalExtraction(**tool_use.input)
        return extraction
    except Exception as e:
        raise Exception(f"Failed to validate extracted data: {e}")


if __name__ == "__main__":
    # Test with sample transcript
    import asyncio

    async def test():
        sample_transcript = """
        Doctor: Good morning! How are you feeling today?
        Patient: I've been having headaches and my blood pressure has been high.
        Doctor: I see. Let me check your blood pressure. Yes, it's elevated at 150/95.
        Based on your symptoms and measurements, I'm diagnosing you with essential hypertension.
        Patient: What should I do?
        Doctor: I recommend a low-sodium diet, regular exercise like walking 30 minutes daily,
        and monitoring your blood pressure at home. I'm also prescribing Lisinopril 10mg
        to be taken once daily in the morning. Follow up with me in 2 weeks.
        """

        import os
        api_key = os.environ.get("ANTHROPIC_API_KEY")

        if not api_key:
            print("Skipping test - ANTHROPIC_API_KEY not set")
            return

        result = await run_extraction(sample_transcript, api_key)
        print(f"Diagnosis: {result.diagnosis}")
        print(f"Plan: {result.plan}")
        print(f"Prescriptions: {result.prescriptions}")

    asyncio.run(test())
