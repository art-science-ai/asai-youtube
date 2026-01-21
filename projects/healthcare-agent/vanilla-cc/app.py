"""
Healthcare AI Assistant - Main Chainlit Application

Entry point for the healthcare AI assistant with Claude agents.
"""

import os
import logging
import chainlit as cl
from pathlib import Path
from src.agents.base_agent import create_main_agent

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


# Database initialization
def initialize_database():
    """Initialize database if it doesn't exist."""
    db_path = Path("data/healthcare.db")

    if not db_path.exists():
        print("📊 Initializing database...")
        import sqlite3

        # Create database directory if needed
        db_path.parent.mkdir(parents=True, exist_ok=True)

        # Read and execute schema
        with open("src/database/init.sql", "r") as f:
            schema = f.read()

        conn = sqlite3.connect(str(db_path))
        conn.executescript(schema)
        conn.close()

        print("✅ Database initialized successfully")
    else:
        print("✅ Database already exists")


# Initialize on startup
initialize_database()


@cl.on_chat_start
async def start():
    """Initialize chat session."""

    logger.info("Starting new chat session")

    # Mark session as initialized
    cl.user_session.set("initialized", True)

    # Welcome message
    await cl.Message(
        content="""# Welcome to the Healthcare AI Assistant! 🏥

I can help you with two main tasks:

## 1. Create Patient Records 📝
Upload or paste clinical visit transcripts, and I'll extract:
- Patient demographics
- Diagnosis
- Treatment plan
- Prescriptions

Then save it all to the database.

## 2. Generate PDF Reports 📄
Request a patient summary report, and I'll:
- Query the patient record from the database
- Generate a professional PDF report
- Make it available for download

---

**What would you like to do?**

You can:
- Upload a transcript file (use the attachment button)
- Paste a transcript directly in the chat
- Request a report by patient name or ID

*Using Claude Pro credentials from ~/.claude*"""
    ).send()


@cl.on_message
async def main(message: cl.Message):
    """Handle incoming messages and route to appropriate agent."""

    if not cl.user_session.get("initialized"):
        await cl.Message(
            content="⚠️ Session not initialized. Please refresh the page and try again."
        ).send()
        return

    # Handle file uploads (transcripts)
    user_message = message.content
    logger.info(f"Received message: {user_message[:100]}...")

    if message.elements:
        for element in message.elements:
            if isinstance(element, cl.File):
                # Read uploaded file
                try:
                    with open(element.path, 'r', encoding='utf-8') as f:
                        transcript_text = f.read()

                    # Augment message with file content
                    user_message += f"\n\n[Uploaded transcript file: {element.name}]\n\n{transcript_text}"

                    await cl.Message(
                        content=f"📎 Received transcript file: **{element.name}** ({len(transcript_text)} characters)"
                    ).send()
                    logger.info(f"Processed file upload: {element.name}")

                except Exception as e:
                    logger.error(f"Error reading file: {str(e)}", exc_info=True)
                    await cl.Message(
                        content=f"❌ Error reading file: {str(e)}"
                    ).send()
                    return

    # Create response message
    response_message = cl.Message(content="")
    await response_message.send()

    # Query agent and stream response
    try:
        logger.info("Creating agent for this query")
        # Create agent on-demand for each message (avoids pickle issues)
        agent = create_main_agent()

        logger.info("Querying agent with async context manager")
        # Use ClaudeSDKClient with async context manager
        async with agent as client:
            # Send query
            logger.info("Sending query to agent")
            await client.query(user_message)

            # Receive and stream response
            logger.info("Receiving response from agent")
            async for msg in client.receive_response():
                await response_message.stream_token(str(msg))

        await response_message.update()
        logger.info("Response complete")

        # Check if response mentions a PDF file path
        if "data/reports/" in response_message.content:
            # Extract PDF path (simple regex might be needed here)
            # For now, we'll let the agent handle file delivery via its own tools
            pass

    except Exception as e:
        logger.error(f"Error processing message: {str(e)}", exc_info=True)
        await response_message.stream_token(f"\n\n❌ Error: {str(e)}")
        await response_message.update()


if __name__ == "__main__":
    # This won't be called when using `chainlit run app.py`
    # but useful for documentation
    print("Run with: uv run chainlit run app.py")
