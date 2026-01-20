#!/usr/bin/env python3
"""
Healthcare AI Assistant - Chainlit Chat Interface

A web chat interface for doctors to upload patient transcripts,
extract medical records, and generate patient summaries.
"""

import chainlit as cl
import database
import os
from src.agents.extraction_agent import run_extraction
from src.utils.file_handler import read_transcript_file
from src.models.medical_record import MedicalExtraction
from anthropic import AsyncAnthropic


@cl.on_chat_start
async def on_chat_start():
    """
    Handler for when a new chat session starts.
    Initialize database and display welcome message.
    """
    # Initialize database
    database.init_db()

    welcome_message = """
    # Healthcare AI Assistant

    Welcome! I'm here to help you with medical documentation.

    **Available commands:**
    - `save: patient_name|patient_id|diagnosis|plan|prescriptions` - Save a patient record
    - `lookup: patient_name_or_id` - Look up a patient record

    **Example:**
    - `save: John Doe|P001|Hypertension|Lifestyle changes|Lisinopril 10mg`
    - `lookup: John Doe` or `lookup: P001`

    You can also send regular text messages and upload files.
    """

    await cl.Message(content=welcome_message).send()


@cl.action_callback("approve_extraction")
async def approve_extraction(action: cl.Action):
    """Handle approve action - save extraction to database."""
    extraction_data = action.value

    # Prompt for patient identification if not provided
    patient_name = extraction_data.get("patient_name")
    patient_id = extraction_data.get("patient_id")

    if not patient_name or not patient_id:
        await cl.Message(
            content="Please provide patient name and ID:\nFormat: `name: Patient Name, id: P123`"
        ).send()
        cl.user_session.set("pending_save", extraction_data)
        return

    # Save to database
    record_id = database.create_patient_record(
        patient_name=patient_name,
        patient_id=patient_id,
        diagnosis=extraction_data["diagnosis"],
        plan=extraction_data["plan"],
        prescriptions=extraction_data["prescriptions"]
    )

    if record_id:
        await cl.Message(
            content=f"✅ Patient record saved successfully!\n\n**Record ID:** {record_id}\n**Patient:** {patient_name}"
        ).send()
    else:
        await cl.Message(content="❌ Failed to save record. Please try again.").send()

    # Clear session state
    cl.user_session.set("pending_extraction", None)
    cl.user_session.set("extraction_results", None)


@cl.action_callback("adjust_extraction")
async def adjust_extraction(action: cl.Action):
    """Handle adjust action - prompt user for modifications."""
    extraction_data = action.value

    await cl.Message(
        content="""I'll help you adjust the extraction. Please describe what you'd like to change.

Examples:
- "Add aspirin to prescriptions"
- "Change diagnosis to migraines"
- "Update plan to include physical therapy"

Type your adjustment below:"""
    ).send()

    # Store extraction for next message to handle adjustment
    cl.user_session.set("pending_adjustment", extraction_data)


@cl.action_callback("cancel_extraction")
async def cancel_extraction(action: cl.Action):
    """Handle cancel action - discard extraction."""
    await cl.Message(content="Extraction cancelled.").send()

    # Clear session state
    cl.user_session.set("pending_extraction", None)
    cl.user_session.set("extraction_results", None)


@cl.on_message
async def on_message(message: cl.Message):
    """
    Handler for incoming messages from the user.

    Supports:
    - File upload for transcript extraction
    - Adjustment requests for pending extractions
    - Q&A about existing extraction results
    - Existing save/lookup commands for manual entry

    Args:
        message: The message object from the user
    """
    user_content = message.content.strip()

    # Check for pending adjustment (user responding to adjust prompt)
    pending_adjustment = cl.user_session.get("pending_adjustment")
    if pending_adjustment:
        # User is providing adjustment instructions
        await handle_adjustment(pending_adjustment, user_content)
        cl.user_session.set("pending_adjustment", None)
        return

    # Check for pending save (user needs to provide patient info)
    pending_save = cl.user_session.get("pending_save")
    if pending_save:
        # Parse patient info and save
        if user_content.lower().startswith("name:") and "id:" in user_content.lower():
            # Extract patient info
            parts = user_content.split(",")
            patient_name = parts[0].split("name:")[1].strip()
            patient_id = parts[1].split("id:")[1].strip()

            pending_save["patient_name"] = patient_name
            pending_save["patient_id"] = patient_id

            # Save to database
            record_id = database.create_patient_record(
                patient_name=patient_name,
                patient_id=patient_id,
                diagnosis=pending_save["diagnosis"],
                plan=pending_save["plan"],
                prescriptions=pending_save["prescriptions"]
            )

            if record_id:
                await cl.Message(
                    content=f"✅ Patient record saved successfully!\n\n**Record ID:** {record_id}\n**Patient:** {patient_name}"
                ).send()
            else:
                await cl.Message(content="❌ Failed to save record. Please try again.").send()

            cl.user_session.set("pending_save", None)
            return
        else:
            await cl.Message(content="Please use the format: `name: Patient Name, id: P123`").send()
            return

    # Check for file upload - trigger extraction
    if message.elements:
        for element in message.elements:
            if hasattr(element, 'path') and element.path.endswith('.txt'):
                await handle_transcript_upload(element)
                return
        await cl.Message(content="Please upload a .txt transcript file.").send()
        return

    # Check for existing save/lookup commands (preserve original functionality)
    if user_content.lower().startswith("save:"):
        await handle_save_command(user_content)
        return

    if user_content.lower().startswith("lookup:"):
        await handle_lookup_command(user_content)
        return

    # Check for Q&A about existing extraction results
    extraction_results = cl.user_session.get("extraction_results")
    if extraction_results:
        # User is asking a question about the extraction
        await handle_qa_about_extraction(extraction_results, user_content)
        return

    # Default help message
    help_text = """
# Healthcare AI Assistant

**Upload a transcript** to extract medical data automatically.

**Or use commands:**
- `save: patient_name|patient_id|diagnosis|plan|prescriptions` - Manual entry
- `lookup: patient_name_or_id` - Look up a record

**Example:**
- Upload a transcript file (.txt)
- `save: John Doe|P001|Hypertension|Lifestyle changes|Lisinopril 10mg`
- `lookup: John Doe`
"""
    await cl.Message(content=help_text).send()


async def handle_save_command(user_content: str):
    """Handle save command for manual record entry."""
    try:
        # Parse save command: "save: patient_name|patient_id|diagnosis|plan|prescriptions"
        data_part = user_content[5:].strip()
        parts = [p.strip() for p in data_part.split("|")]

        if len(parts) != 5:
            response = f"""❌ Invalid save command format.

**Expected format:**
`save: patient_name|patient_id|diagnosis|plan|prescriptions`

**Example:**
`save: John Doe|P001|Hypertension|Lifestyle changes|Lisinopril 10mg`

**You provided:**
{user_content}

Please use pipe-separated values (|).
"""
        else:
            patient_name, patient_id, diagnosis, plan, prescriptions = parts

            # Create patient record
            record_id = database.create_patient_record(
                patient_name, patient_id, diagnosis, plan, prescriptions
            )

            if record_id:
                response = f"""✅ Patient record saved successfully!

**Record ID:** {record_id}
**Patient Name:** {patient_name}
**Patient ID:** {patient_id}
**Diagnosis:** {diagnosis}
**Plan:** {plan}
**Prescriptions:** {prescriptions}
"""
            else:
                response = "❌ Failed to save patient record. Please try again."

    except Exception as e:
        response = f"❌ Error parsing save command: {str(e)}\n\nPlease use the format: `save: name|id|diagnosis|plan|prescriptions`"

    await cl.Message(content=response).send()


async def handle_lookup_command(user_content: str):
    """Handle lookup command for finding patient records."""
    try:
        identifier = user_content[7:].strip()

        if not identifier:
            response = "❌ Please provide a patient name or ID to lookup.\n\n**Example:** `lookup: John Doe`"
        else:
            # Lookup patient record
            record = database.get_patient_record(identifier)

            if record:
                response = f"""📋 Patient Record Found

**Patient Name:** {record['patient_name']}
**Patient ID:** {record['patient_id']}
**Diagnosis:** {record['diagnosis']}
**Plan:** {record['plan']}
**Prescriptions:** {record['prescriptions']}
**Created:** {record['created_at']}
"""
            else:
                response = f"❌ No patient record found for: {identifier}"

    except Exception as e:
        response = f"❌ Error looking up patient record: {str(e)}"

    await cl.Message(content=response).send()


async def handle_qa_about_extraction(extraction: MedicalExtraction, question: str):
    """
    Answer user questions about extraction results using Claude.

    Args:
        extraction: The extraction results stored in session
        question: User's question about the extraction
    """
    try:
        api_key = os.getenv("ANTHROPIC_API_KEY")
        if not api_key:
            await cl.Message(content="❌ API key not found.").send()
            return

        client = AsyncAnthropic(api_key=api_key)

        # Format extraction for Claude context
        extraction_context = f"""Extraction Results:
Diagnosis: {extraction.diagnosis}
Plan: {extraction.plan}
Prescriptions: {extraction.prescriptions}

User question: {question}

Please answer the user's question about these extraction results. Be helpful and concise."""

        response = await client.messages.create(
            model="claude-sonnet-4-5-20250929",
            max_tokens=1024,
            messages=[{"role": "user", "content": extraction_context}]
        )

        answer = response.content[0].text
        await cl.Message(content=answer).send()

    except Exception as e:
        await cl.Message(content=f"❌ Error answering question: {str(e)}").send()


async def handle_transcript_upload(element):
    """Handle transcript file upload and extraction."""
    try:
        # Read transcript
        transcript = read_transcript_file(element.path)

        await cl.Message(content="📄 Processing transcript...").send()

        # Get API key from environment
        api_key = os.getenv("ANTHROPIC_API_KEY")
        if not api_key:
            await cl.Message(
                content="❌ ANTHROPIC_API_KEY not found. Please set it in your .env file."
            ).send()
            return

        # Run extraction
        extraction: MedicalExtraction = await run_extraction(transcript, api_key)

        # Display results for review
        review_content = f"""
# Extraction Results

**Diagnosis:**
{extraction.diagnosis}

**Treatment Plan:**
{extraction.plan}

**Prescriptions:**
{extraction.prescriptions}

---

Please review the extracted data above.
"""

        actions = [
            cl.Action(name="approve_extraction", value=extraction.model_dump(), label="✓ Approve & Save"),
            cl.Action(name="adjust_extraction", value=extraction.model_dump(), label="✎ Make Adjustments"),
            cl.Action(name="cancel_extraction", value={}, label="✗ Cancel"),
        ]

        await cl.Message(content=review_content, actions=actions).send()

        # Store extraction in session for Q&A and adjustments
        cl.user_session.set("extraction_results", extraction)

    except FileNotFoundError as e:
        await cl.Message(content=f"❌ File not found: {str(e)}").send()
    except Exception as e:
        await cl.Message(content=f"❌ Error processing transcript: {str(e)}").send()


async def handle_adjustment(extraction_data: dict, adjustment_request: str):
    """
    Handle user adjustment request by re-running extraction with context.

    This implementation uses Claude to generate an updated extraction based on
    the user's adjustment request, providing a conversational way to modify results.
    """
    try:
        await cl.Message(content="🔄 Processing adjustment...").send()

        # Get API key
        api_key = os.getenv("ANTHROPIC_API_KEY")
        if not api_key:
            await cl.Message(content="❌ API key not found.").send()
            return

        client = AsyncAnthropic(api_key=api_key)

        # Create adjustment prompt with original extraction and user request
        adjustment_prompt = f"""Original extraction:
Diagnosis: {extraction_data['diagnosis']}
Plan: {extraction_data['plan']}
Prescriptions: {extraction_data['prescriptions']}

User adjustment request: {adjustment_request}

Please update the extraction based on the user's request. Respond with the updated extraction in this exact format:

Diagnosis: [updated diagnosis]
Plan: [updated plan]
Prescriptions: [updated prescriptions]

Only output the three lines above, nothing else."""

        response = await client.messages.create(
            model="claude-sonnet-4-5-20250929",
            max_tokens=1024,
            messages=[{"role": "user", "content": adjustment_prompt}]
        )

        # Parse Claude's response
        updated_text = response.content[0].text

        # Extract updated fields (simple parsing for Phase 02)
        updated_diagnosis = extraction_data['diagnosis']
        updated_plan = extraction_data['plan']
        updated_prescriptions = extraction_data['prescriptions']

        for line in updated_text.split('\n'):
            if line.lower().startswith('diagnosis:'):
                updated_diagnosis = line.split(':', 1)[1].strip()
            elif line.lower().startswith('plan:'):
                updated_plan = line.split(':', 1)[1].strip()
            elif line.lower().startswith('prescriptions:'):
                updated_prescriptions = line.split(':', 1)[1].strip()

        # Create updated extraction
        updated_extraction = {
            'diagnosis': updated_diagnosis,
            'plan': updated_plan,
            'prescriptions': updated_prescriptions
        }

        # Display updated extraction
        review_content = f"""
# Updated Extraction Results

**Diagnosis:**
{updated_diagnosis}

**Treatment Plan:**
{updated_plan}

**Prescriptions:**
{updated_prescriptions}

---

Please review the updated extraction above.
"""

        actions = [
            cl.Action(name="approve_extraction", value=updated_extraction, label="✓ Approve & Save"),
            cl.Action(name="adjust_extraction", value=updated_extraction, label="✎ Make More Adjustments"),
            cl.Action(name="cancel_extraction", value={}, label="✗ Cancel"),
        ]

        await cl.Message(content=review_content, actions=actions).send()

        # Update session with new extraction
        cl.user_session.set("extraction_results", MedicalExtraction(**updated_extraction))

    except Exception as e:
        await cl.Message(content=f"❌ Error processing adjustment: {str(e)}").send()
