"""Healthcare AI Assistant — Chainlit app with Claude Agent SDK.

This app provides a chat interface for doctors to:
- Upload visit transcripts and extract clinical data (diagnosis, plan, prescriptions)
- Query patient records using natural language
- Generate patient summary reports
"""

import chainlit as cl
from claude_agent_sdk import ClaudeSDKClient, ClaudeAgentOptions, AssistantMessage, TextBlock

from database.models import init_db
from database.seed import seed_database

SYSTEM_PROMPT = """\
You are a healthcare AI assistant that helps doctors manage patient records.

You have access to a SQLite patient database at /app/data/patients.db.
Use the sqlite3 CLI tool via Bash to query and modify records.

You have two specialized skills:
1. Record Creation: Extract diagnosis, plan, and prescriptions from visit transcripts
2. Report Generation: Generate professional patient summary reports

When a user uploads or pastes a transcript, use the Record Creation skill to extract data.
When a user asks for a patient report, use the Report Generation skill.

Always confirm extracted data with the user before saving to the database.
Be concise and professional in your responses.
"""

AGENT_OPTIONS = ClaudeAgentOptions(
    system_prompt=SYSTEM_PROMPT,
    allowed_tools=["Bash"],
    permission_mode="bypassPermissions",
    setting_sources=["project"],
)


@cl.on_chat_start
async def on_chat_start():
    init_db()
    seed_database()

    client = ClaudeSDKClient(options=AGENT_OPTIONS)
    await client.connect()
    cl.user_session.set("client", client)

    await cl.Message(
        content=(
            "Hello! I'm your healthcare AI assistant. I can help you with:\n\n"
            "- **Extract records**: Paste or upload a visit transcript and I'll extract "
            "the diagnosis, plan, and prescriptions\n"
            "- **Patient lookup**: Ask about any patient's history\n"
            "- **Generate reports**: Request a summary report for any patient\n\n"
            "How can I help you today?"
        )
    ).send()


@cl.on_message
async def on_message(message: cl.Message):
    client: ClaudeSDKClient = cl.user_session.get("client")

    prompt = message.content

    if message.elements:
        for element in message.elements:
            if hasattr(element, "content"):
                prompt += f"\n\n[Uploaded file: {element.name}]\n{element.content}"

    await client.query(prompt)

    response_text = ""
    async for msg in client.receive_response():
        if isinstance(msg, AssistantMessage):
            for block in msg.content:
                if isinstance(block, TextBlock):
                    response_text += block.text

    if response_text:
        await cl.Message(content=response_text).send()


@cl.on_chat_end
async def on_chat_end():
    client: ClaudeSDKClient | None = cl.user_session.get("client")
    if client:
        await client.disconnect()
