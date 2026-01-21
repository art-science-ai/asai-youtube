"""
Healthcare AI Assistant - Main Orchestrator Agent

This is the main agent that coordinates record creation and report generation sub-agents.
"""

from claude_agent_sdk import ClaudeSDKClient, ClaudeAgentOptions
from .record_agent import create_record_agent
from .report_agent import create_report_agent


def create_main_agent() -> ClaudeSDKClient:
    """
    Create the main orchestrator agent with two specialized sub-agents.

    Returns:
        Configured ClaudeSDKClient instance
    """

    system_prompt = """You are a healthcare AI assistant helping doctors manage patient medical records.

Your primary responsibilities:
1. Help users create patient records from clinical visit transcripts
2. Generate professional PDF reports for existing patient records
3. Coordinate with specialized sub-agents for each task

You have access to two specialized sub-agents:
- Record Creation Agent: Extracts diagnosis, treatment plan, and prescriptions from transcripts
- Report Generation Agent: Creates PDF summaries from patient records in the database

Guidelines:
- Always confirm actions with users before modifying the database
- Present extracted data for review before saving
- Be professional and maintain patient data confidentiality
- Provide clear feedback about what you're doing

Database location: data/healthcare.db
Reports saved to: data/reports/"""

    options = ClaudeAgentOptions(
        system_prompt=system_prompt,
        allowed_tools=[
            "Read",  # Read uploaded transcript files
            "Write",  # Write temporary files if needed
            "Bash",  # Execute sqlite3 commands
            "Task",  # Required for delegating to sub-agents
            "Skill",  # Enable custom skills
        ],
        agents={
            "record_agent": create_record_agent(),
            "report_agent": create_report_agent(),
        },
        model="claude-sonnet-4-5-20250929",  # Latest Claude model
        permission_mode="allow_all",  # For development; use "ask" in production
    )

    return ClaudeSDKClient(options=options)
