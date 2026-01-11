# Evaluation: [Test case name]

Date: YYYY-MM-DD
Evaluation mode: [Ground truth comparison / Self-evaluation]

---

## Section 1: Completeness checks

These checks apply regardless of ground truth availability:

- [ ] Analysis scope matches input data (channels, brands, levels)
- [ ] All channels have dedicated analysis
- [ ] All brands have insights (CSF, elasticity, MSP, positioning)
- [ ] Recommendations present with rationale
- [ ] Market context acknowledged
- [ ] Critical comparisons performed

**Details:**
- Channels in CSV: [list]
- Channels in outline: [list]
- Brands in CSV: [list]
- Brands in outline: [list]
- Missing sections: [list or "none"]

## Section 2: Internal consistency

- [ ] Numbers align with input CSV
- [ ] CSF categories match thresholds
- [ ] Price elasticity interpretations correct
- [ ] Market share trends logically explained
- [ ] Recommendations align with metrics

**Validation results:**
- Data accuracy: [Pass / Issues found]
- Category logic: [Pass / Issues found]
- Recommendation coherence: [Pass / Issues found]

**Issues found (if any):**
| Issue | Location | Expected | Actual | Severity |
|-------|----------|----------|--------|----------|
| [Description] | [Slide/section] | [...] | [...] | [High/Medium/Low] |

---

## Section 3: Ground truth comparison

*This section only appears when ground truth is available*

### Requirements coverage

Comparing against requirements.md:

- [ ] Overall market health insight captured
- [ ] Per-brand insights complete
- [ ] Competitive dynamics addressed
- [ ] PPG/Variant insights included (if applicable)
- [ ] Key recommendations present
- [ ] Business context matches

### Semantic alignment

**What matches ground truth:**
- [Specific insights correctly captured]
- [Narratives align with authoritative presentation]

**What differs from ground truth:**

| Priority | Issue | Ground truth says | Generated says | Impact |
|----------|-------|-------------------|----------------|--------|
| High | [Missing critical insight] | [...] | [...] | [Blocker] |
| Medium | [Weaker narrative] | [...] | [...] | [Enhancement needed] |
| Low | [Minor difference] | [...] | [...] | [Acceptable variation] |

---

## Overall assessment

- Quality score: [X/10]
- Ready for production: [Yes / No / Almost]
- Key blocker (if any): [Main gap]
- Next steps: [What needs fixing]

## Notes

[Additional context or observations]
