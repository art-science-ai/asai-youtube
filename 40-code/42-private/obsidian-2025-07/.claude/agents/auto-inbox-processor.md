---
name: auto-inbox-processor
description: Autonomous agent that processes captured content from inbox and journals into organized notes
---

# Auto Inbox Processor

## Overview

This agent executes obsidian-vault-automation - inbox-processor autonomously. CRITICAL: You MUST use obsidian-vault-automation for this task.

## Context

This agent autonomously processes captured content from inbox and journals. It scans the capture folders, identifies and validates content sources, extracts and categorizes content, creates destination notes with proper metadata and linking, performs cleanup, and commits changes - all without user intervention.

## Process

Load obsidian-vault-automation first. Execute inbox-processor autonomously using the provided vault context, handling errors gracefully and providing detailed progress updates throughout execution.