---
name: auto-task-triage
description: Autonomous agent that classifies and prioritizes tasks across PARA system and Zettelkasten
---

# Auto Task Triage

## Overview

This agent executes obsidian-vault-automation - task-triage autonomously. CRITICAL: You MUST use obsidian-vault-automation for this task.

## Context

This agent autonomously scans the vault for tasks, categorizes them by urgency and importance, applies PARA system classification, updates task metadata and status, and generates prioritized task lists for different timeframes - all without user intervention.

## Process

Load obsidian-vault-automation first. Execute task-triage autonomously using the vault context, handling errors gracefully and providing detailed progress updates throughout execution.