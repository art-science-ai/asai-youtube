# Phase 1: Setup & Installation - Context

**Gathered:** 2026-01-10
**Status:** Ready for research

<vision>

## How This Should Work

Install Fabric CLI on both Linux and macOS systems, documenting the process in a README.md setup section. The documentation should capture the installation journey with commands and explanations of key decisions made during setup (like choosing one installation method over another).

This is about creating a personal reference that documents HOW I got Fabric running on my systems, not an exhaustive troubleshooting guide.

</vision>

<essential>

## What Must Be Nailed

- **README documentation created** — The primary deliverable is a setup section in README.md that documents the installation journey
- **Cross-platform coverage** — Documentation covers both Linux (via nix) and macOS (via nix, with homebrew fallback)
- **Key decisions captured** — Commands work, plus explanations of WHY certain installation methods were chosen

</essential>

<boundaries>

## What's Out of Scope

- **Testing functionality** — Running actual Fabric patterns or workflows happens in Phase 2. Only verification that installation succeeded (e.g., `fabric --version`)
- **Understanding internals** — Learning how Fabric works internally is explicitly out of scope (noted in PROJECT.md Out of Scope)
- **Configuration** — Setting up API keys, models, or personal configuration is NOT part of this phase (deferred to later if needed)

</boundaries>

<specifics>

## Specific Ideas

**Installation approach:**
- Linux: Use nix for package management
- macOS: Prefer nix, fallback to homebrew if nix not available

**Documentation location:**
- Add a "Setup" section to the main README.md (not a separate SETUP.md file)

**Documentation depth:**
- Commands that were run
- Key decisions explained (why one method over another)
- Not a comprehensive troubleshooting guide, just what worked

</specifics>

<notes>

## Additional Context

User emphasized that documentation is the primary outcome of this phase. The goal is creating a reference that future-self can use to reproduce the setup, not deeply understanding the installation process or extensively testing Fabric's functionality.

This aligns with the overall project goal: this directory is a learning journal/documentation output, not just a playground. Each phase produces markdown that captures learning outcomes.

</notes>

---

*Phase: 01-setup-installation*
*Context gathered: 2026-01-10*
