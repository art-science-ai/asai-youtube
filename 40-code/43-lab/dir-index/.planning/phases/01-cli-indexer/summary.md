# Summary Template

After completing a plan, create `{plan-number}-SUMMARY.md` in this directory using the structure specified in the plan's `<output>` section.

## Summary Structure

```markdown
# Phase {X} Plan {Y}: {Name} Summary

**[Substantive one-liner - what shipped, not "phase complete"]**

## Accomplishments

- [Key outcome 1]
- [Key outcome 2]

## Files Created/Modified

- `path/to/file.ext` - Description
- `path/to/another.ext` - Description

## Decisions Made

[Key decisions and rationale, or "None"]

## Issues Encountered

[Problems and resolutions, or "None"]

## Deviations from Plan

[Any changes from the original PLAN.md, or "None"]

## Next Phase Readiness

[Concerns or notes for the next phase, or "Ready for next phase"]

## Next Step

[If more plans in this phase: "Ready for {phase}-{next-plan}-PLAN.md"]
[If phase complete: "Phase complete, ready for next phase"]
```

## Frontmatter for Dependency Graph

Add YAML frontmatter to each SUMMARY.md for automatic context loading in future phases:

```yaml
---
phase: XX-name
plan: YY
subsystem: [subsystem-name]
requires: [XX-name]
provides: [ZZ-name]
affects: [AA-name, BB-name]
tech-stack:
  added: []
  patterns: []
patterns-established: []
key-files: []
key-decisions:
  - [decision-summary]
tags: [feature, refactor, fix, etc]
completion-date: YYYY-MM-DD
---
```

**Purpose**: Enables `read_project_history` step in plan-phase.md to auto-select relevant summaries based on:
- `affects`: Which phases depend on this one
- `subsystem`: Which phases share the same system
- `requires`: Transitive dependencies
- `key-files`: Files future phases need to understand
