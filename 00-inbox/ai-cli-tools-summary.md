# Top CLI Tools for AI Coding

*   **Gemini CLI:** [https://github.com/google-gemini/gemini-cli](https://github.com/google-gemini/gemini-cli)
*   **Claude Code CLI:** [https://www.anthropic.com/product/claude-code](https://www.anthropic.com/product/claude-code)
*   **Aider:** [https://aider.chat](https://aider.chat)
*   **OpenAI Codex CLI:** [https://github.com/openai/codex](https://github.com/openai/codex)
*   **GitHub Copilot CLI:** [https://docs.github.com/en/copilot/github-copilot-enterprise/copilot-cli](https://docs.com/en/copilot/github-copilot-enterprise/copilot-cli)
*   **Qodo CLI:** [https://qodo.ai](https://qodo.ai)
*   **OpenCode:** [https://opencode.ai](https://opencode.ai)
*   **AI Chat (aichat):** [https://github.com/sigoden/aichat](https://github.com/sigoden/aichat)
*   **Warp Terminal:** [https://www.warp.dev](https://www.warp.dev)

---

**My Usage:**
*   **Claude Code:** Primarily for coding projects.
*   **Gemini CLI:** For working with Obsidian.
*   **Others:** Haven't tried yet but will explore at some point.

---

## Unifying Context Files

*   **Gemini CLI Configuration:** Supports global (`~/.gemini/settings.json`) and project-level (`.gemini/settings.json`) JSON, plus `.env` files. Precedence: CLI flags > environment variables > project JSON > user JSON > built-in defaults.
*   **Unifying Instruction Context Files:** Both tools can use the same Markdown instruction file (e.g., `CLAUDE.md` or `AGENTS.md`).
    *   **Claude Code:** Place `CLAUDE.md` at repo root or `~/.claude/`; it auto-loads from parent/child directories.
    *   **Gemini CLI:** Set `contextFileName` in `.gemini/settings.json` to load the shared file (e.g., `"contextFileName": "CLAUDE.md"`). Supports array of filenames for multiple shared docs. 