# Skill Validation Framework

## Overview

This document describes the framework for testing, validating, and tracking the development of Claude Code skills in the Cogitaas AI POC project. The framework captures what was tested, what worked, what didn't, and how skills improve over time.

## Design Philosophy

**Centralized validation outputs**: Just as `parsed_data/` contains outputs from the doc-parsing skill, `skill-validation/` contains outputs from the validation process - test results, feedback, and improvement tracking.

**Hybrid workflow**: Scripts capture quantitative metrics automatically; humans provide qualitative assessment and strategic direction.

**Iterative progression**: Track skills from initial tests through multiple refinement rounds to maturity.

## Directory Structure

```
skill-validation/
├── README.md                          # This file + quick reference guide
├── templates/                         # Reusable test documentation templates
│   ├── test-session.md               # Template for documenting a test session
│   ├── test-result.md                # Template for individual test results
│   └── feedback-summary.md           # Template for summarizing feedback across tests
│
├── doc-parsing/                      # Validation outputs for doc-parsing skill
│   ├── README.md                     # Skill validation overview & status
│   ├── sessions/                     # Test session groups (temporal grouping)
│   │   ├── 2025-01-15_pptx-initial/  # Session: Initial PPTX parsing tests
│   │   │   ├── session.md            # Session overview (what, why, goals)
│   │   │   ├── test-01/              # Individual test result
│   │   │   │   ├── result.md         # Test execution details
│   │   │   │   ├── output/           # Actual outputs (symlinks or copies)
│   │   │   │   └── feedback.md       # Qualitative assessment + change requests
│   │   │   ├── test-02/
│   │   │   └── session-summary.md    # Aggregate findings + next steps
│   │   │
│   │   └── 2025-01-20_docx-initial/  # Session: DOCX parsing tests
│   │
│   ├── metrics/                      # Quantitative metrics across sessions
│   │   ├── performance.csv           # Execution time, memory, file sizes
│   │   ├── success-rate.csv          # Pass/fail rates by file type
│   │   └── quality-scores.csv        # Manual quality ratings over time
│   │
│   └── roadmap.md                    # Skill development roadmap based on testing
│
├── presentation-generation/          # Validation outputs for presentation generation
│   ├── README.md
│   ├── sessions/
│   ├── metrics/
│   └── roadmap.md
│
└── summary/                          # Cross-skill validation insights
    ├── overall-status.md             # Status across all skills
    ├── lessons-learned.md            # Patterns from multiple skills
    └── best-practices.md             # What works, what doesn't
```

## Testing Granularity

**Recommended: Session-based with individual test tracking**

### Why Test Sessions?

- Groups related tests temporally (e.g., "Testing PPTX parsing v0.3.0 on UK examples")
- Provides context for individual tests (what changed, why we're testing)
- Enables session-level summaries and insights
- Matches natural workflow: plan → test multiple files → review → iterate

### Individual Test Results

Each test within a session gets its own directory containing:
- What was tested (file path, skill version, environment)
- What happened (quantitative metrics, outputs)
- How it went (qualitative assessment, issues found)
- What's next (change requests, follow-up tests)

### Skill Version Tracking

Roadmap.md tracks skill versions (v0.1.0, v0.2.0, etc.) and links to test sessions that validated each version.

## File Templates

### 1. Test Session Template (`templates/test-session.md`)

```markdown
# Test Session: [Descriptive Name]

**Date**: YYYY-MM-DD
**Skill**: [skill-name]
**Skill Version**: [version]
**Tester**: [who]

## Overview

[Why this session exists - what changed, what we're validating, specific goals]

## Test Plan

| Test ID | File/Scenario | Expected Outcome | Priority |
|---------|---------------|------------------|----------|
| test-01 | [path to file] | [what should happen] | High/Medium/Low |
| test-02 | [path to file] | [what should happen] | High/Medium/Low |

## Environment

- **System**: [OS, environment details]
- **Dependencies**: [relevant versions]
- **Configuration**: [any special settings]

## Success Criteria

- [ ] [Specific success criteria for this session]
- [ ] [Another criterion]
- [ ] [Another criterion]

## Session Summary

[Completed after testing - aggregate findings, overall assessment]

**Overall Status**: ✅ Passed / ⚠️ Partial / ❌ Failed

**Key Findings**:
- [Finding 1]
- [Finding 2]

**Next Steps**:
- [Step 1]
- [Step 2]

## Related Tests

- Links to previous sessions on this skill
- Links to related skills being tested
```

### 2. Test Result Template (`templates/test-result.md`)

```markdown
# Test Result: [test-ID]

**Session**: [session-name]
**Date**: YYYY-MM-DD
**Time**: HH:MM:SS

## Test Input

**File**: [path to test file]
**File Type**: [pptx/docx/xlsx/etc]
**File Size**: [size]
**Source**: [masked_examples/full_examples/etc]

**Test Scenario**: [what we're testing - feature, edge case, etc.]

## Execution

**Command**: [exact command/script used]
**Skill Version**: [version]
**Exit Code**: [0 = success, non-zero = failure]

## Quantitative Metrics

| Metric | Value | Notes |
|--------|-------|-------|
| Execution Time | [X.XX seconds] | |
| Memory Used | [XXX MB] | |
| Output Size | [XXX files/XXX MB] | |
| Errors Thrown | [0 or count] | |
| Warnings | [0 or count] | |

## Output Description

[What was produced - files created, data extracted, etc.]

**Output Location**: [path to outputs]

**Output Contents**:
- [List of key outputs]
- [Any notable observations]

## Qualitative Assessment

### Functional Correctness

**Status**: ✅ Works / ⚠️ Partial / ❌ Failed

**Assessment**: [Did it do what it was supposed to do?]

### Output Quality

**Accuracy**: [1-10] - [How accurate is the output?]

**Completeness**: [1-10] - [Did it capture everything needed?]

**Formatting**: [1-10] - [Is the output well-formatted?]

**Overall Quality**: [1-10] - [Total assessment]

**Notes**:
- [Specific quality observations]
- [What's good, what needs improvement]

### Usability

**Ease of Use**: [1-10] - [How easy was it to run/use?]

**Documentation Quality**: [1-10] - [Were instructions clear?]

**Error Messages**: [Helpful / Confusing / Missing]

**Notes**:
- [Usability observations]

## Issues Found

### Critical (Blocking)

- [Issue that prevents use - must fix before proceeding]

### Major (Significant Impact)

- [Issue that significantly impacts quality or usability]

### Minor (Nice to Have)

- [Small issues, inconveniences, or improvements]

## Change Requests

### Must Fix

1. [ ] [Description of required fix]
   - **Priority**: High
   - **Complexity**: [Low/Medium/High]
   - **Assigned To**: [who]

### Should Fix

1. [ ] [Description of improvement]
   - **Priority**: Medium
   - **Complexity**: [Low/Medium/High]

### Could Fix

1. [ ] [Description of nice-to-have]
   - **Priority**: Low
   - **Complexity**: [Low/Medium/High]

## Follow-Up Tests

- [ ] [Test that should be run after fixes applied]
- [ ] [Related test that should be run]
- [ ] [Edge case to explore]

## Verdict

**Recommendation**: [Merge to main / Needs fixes / Deprecate / Other]

**Comments**: [Any additional context or recommendations]
```

### 3. Feedback Summary Template (`templates/feedback-summary.md`)

```markdown
# Feedback Summary: [Session Name]

**Date Range**: [start date] - [end date]
**Skill**: [skill-name]
**Tests Covered**: [number of tests]

## Aggregate Ratings

### Quality Over Time

| Version | Avg Quality | Avg Accuracy | Avg Completeness |
|---------|-------------|--------------|------------------|
| v0.1.0  | 6.5/10      | 7.0/10       | 6.0/10           |
| v0.2.0  | 8.0/10      | 8.5/10       | 7.5/10           |

### Performance Metrics

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Avg Time | X.XXs | Y.YYs | Z% faster |
| Success Rate | XX% | YY% | +Z% |

## Common Issues

### Recurring Problems

1. **[Issue Title]**
   - **Frequency**: [occurred in X of Y tests]
   - **Impact**: [High/Medium/Low]
   - **Recommended Fix**: [proposed solution]

### Pattern Observations

- [Pattern noticed across multiple tests]
- [Another pattern]
- [Insights about what works well]

## Prioritized Improvements

### Top 3 Next Improvements

1. **[Improvement 1]**
   - **Rationale**: [why this matters most]
   - **Estimated Effort**: [Low/Medium/High]
   - **Expected Impact**: [High/Medium/Low]

2. **[Improvement 2]**
   - **Rationale**: [why this matters]
   - **Estimated Effort**: [Low/Medium/High]
   - **Expected Impact**: [High/Medium/Low]

3. **[Improvement 3]**
   - **Rationale**: [why this matters]
   - **Estimated Effort**: [Low/Medium/High]
   - **Expected Impact**: [High/Medium/Low]

## Expert Feedback Integration

### Business Context Validation

- [Expert assessment on whether outputs meet business needs]
- [Strategic considerations]
- [Alignment with CSF workflow requirements]

### Quality Gates

- [ ] [Quality gate 1 - e.g., "All quality ratings > 8/10"]
- [ ] [Quality gate 2 - e.g., "Zero critical issues"]
- [ ] [Quality gate 3 - e.g., "Expert approval obtained"]

## Recommendations

### For Next Version

- [Specific recommendation for v0.X.0]
- [Another recommendation]

### Process Improvements

- [Ways to improve testing process itself]
- [Tools or automation that would help]

### Skill Status

**Current Maturity**: [Prototype / Alpha / Beta / Production-Ready]

**Ready for**: [Limited testing / Internal use / Expert review / Production use]

**Confidence Level**: [Low / Medium / High]
```

## Workflow

### Phase 1: Pre-Test Planning

1. **Create session directory**: `skill-validation/[skill]/sessions/YYYY-MM-DD_[descriptive-name]/`
2. **Initialize session.md**: Use template to document goals, test plan, environment
3. **Prepare test files**: Identify and organize test files from masked_examples/
4. **Define success criteria**: What does "pass" look like for this session?

### Phase 2: Test Execution

For each test:

1. **Create test directory**: `test-[NN]/` within session
2. **Run the skill**: Execute command/script with test file
3. **Capture outputs automatically**:
   - Scripts should log metrics to `metrics/` or capture in structured format
   - Save outputs to `output/` subdirectory
   - Record execution details (time, exit code, etc.)
4. **Document result.md**: Fill in quantitative metrics section
5. **Create feedback.md**: Fill in qualitative assessment

**Automation Opportunities**:
- Scripts can auto-generate result.md with metrics pre-populated
- Output directories can be auto-created and populated
- Timestamps and execution details auto-captured

**Manual Steps**:
- Qualitative assessment (quality ratings, usability)
- Issue identification and categorization
- Change requests and priorities
- Follow-up test identification

### Phase 3: Post-Test Review

1. **Complete session.md**: Fill in session summary with aggregate findings
2. **Create session-summary.md**: Cross-test analysis, patterns, key insights
3. **Update metrics**: Append session results to CSV files in `metrics/`
4. **Review with expert**: Present findings, get business context validation
5. **Update roadmap.md**: Document next version priorities based on findings

### Phase 4: Iteration

1. **Prioritize changes**: Use feedback summaries to rank improvements
2. **Implement fixes**: Update skill in `.claude/skills/[skill]/`
3. **Create new test session**: Test the updated version
4. **Track progress**: Compare metrics across sessions to show improvement

## Integration Points

### With Skill Development

- `.claude/skills/[skill]/SKILL.md` links to `skill-validation/[skill]/README.md`
- Roadmap.md in validation drives next version development
- Change requests become skill development tasks

### With Output Directories

- Test outputs can reference actual outputs (symlinks to `parsed_data/`, etc.)
- Avoid duplication - link to artifacts rather than copying
- `skill-validation/` contains metadata about outputs, not the outputs themselves

### With Project Documentation

- Root `README.md` links to `skill-validation/summary/overall-status.md`
- Each skill's README includes validation status link
- Workflow docs reference validation findings

## Best Practices

### DO

- Test on masked examples before full examples
- Keep test sessions focused (1-2 hours max, specific goals)
- Document both what works AND what doesn't
- Link to outputs rather than copying (avoid duplication)
- Update metrics after every session (build the data habit)
- Get expert review before considering a skill "ready"

### DON'T

- Don't skip documenting "boring" successful tests (track what works!)
- Don't mix unrelated tests in the same session
- Don't over-engineer templates (keep them practical)
- Don't forget to update roadmaps (connect tests to next steps)
- Don't test on unmasked client data (security!)

## Status Tracking Legend

- ✅ **Passed**: Works as expected, no significant issues
- ⚠️ **Partial**: Works with limitations or minor issues
- ❌ **Failed**: Does not work or has critical issues
- 🔄 **In Progress**: Currently being tested
- ⏳ **Planned**: Scheduled for testing
- 💭 **Proposed**: Candidate for testing

## Quick Start Checklist

- [ ] Create `skill-validation/` directory structure
- [ ] Set up templates in `templates/`
- [ ] Initialize first skill directory (e.g., `doc-parsing/`)
- [ ] Create first test session for doc-parsing
- [ ] Run tests and document results
- [ ] Review and iterate

## Example: First Test Session

```
skill-validation/
└── doc-parsing/
    ├── README.md                     # "Testing PPTX parsing (v0.3.0) - Initial validation"
    └── sessions/
        └── 2025-01-15_pptx-initial/
            ├── session.md            # Goals: Test PPTX parsing on UK_BBQ presentation
            ├── test-01/
            │   ├── result.md         # Parsed 20 slides, extracted 20 images
            │   ├── output/           # → symlink to parsed_data/CSF Project workflow.pptx/
            │   └── feedback.md       # Quality: 9/10, issue: image numbering unclear
            ├── test-02/
            │   ├── result.md         # Parsed 15 slides, extracted 12 images
            │   ├── output/           # → symlink to parsed_data/UK_BBQ Stakeholder Presentation.pptx/
            │   └── feedback.md       # Quality: 8/10, issue: some text in charts not captured
            └── session-summary.md    # Overall: PPTX parsing works well (avg 8.5/10)
                                       # Next: Add chart text extraction, improve image naming
```

---

**Last Updated**: 2025-01-15
**Maintained By**: [Skill Development Team]
**Questions**: See [project README.md] or [team contact]
