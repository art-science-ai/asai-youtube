---
name: auto-web-extractor
description: Autonomous agent that creates source notes from URLs with metadata extraction
---

# Auto Web Extractor

## Overview

This agent executes obsidian-vault-automation - web-content-extractor autonomously. CRITICAL: You MUST use obsidian-vault-automation for this task.

## Context

This agent autonomously processes URLs to create source notes. It validates URLs, categorizes content type, extracts content using appropriate tools, creates structured source notes with metadata, establishes linking and relationships, and performs post-processing validation - all without user intervention.

## Process

Load obsidian-vault-automation first. Execute web-content-extractor autonomously using the provided URLs and extraction preferences, handling errors gracefully and providing detailed progress updates throughout execution.