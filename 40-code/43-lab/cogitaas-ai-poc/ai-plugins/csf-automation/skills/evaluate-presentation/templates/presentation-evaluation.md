# Evaluation: [Test case name]

Date: YYYY-MM-DD
CSV type: [Brand-level / Variant-level / PPG-level]
Ground truth: [Yes / No]

---

## Completeness

- [ ] All channels from CSV are represented
- [ ] All brands from CSV are analyzed
- [ ] Analysis depth matches CSV type (brand/variant/PPG)
- [ ] Required sections present (title, executive summary, findings, recommendations)

## Accuracy

- [ ] CSF values and categories are correct (High >= 2.0, Medium 1.7-2.0, Low < 1.7)
- [ ] Price elasticity categories are correct (Less elastic >= -4, Moderately -7 to -4, Highly < -7)
- [ ] MSP categories are correct (Positive > 0.001, Stable -0.001 to 0.001, Negative < -0.001)
- [ ] Market leader identification is accurate

## Consistency

- [ ] Recommendations align with metrics (e.g., high CSF → consider price increase)
- [ ] Narratives match data (e.g., low CSF described as "vulnerable," not "strong")
- [ ] Competitive insights match the data

---

## Ground truth comparison

*This section appears only when ground truth presentation is available*

### Scope

- CSV type: [Brand-level / Variant-level / PPG-level]
- Channels: [list]
- Granulation: [Brands / Variants / PPGs]
- Market: [market name]

### Key insights from ground truth

#### Overall market

- [Key observation about market health from ground truth]

#### Per [granularity level]

*Structure depends on CSV type:*

**If Brand-level:**
- [Brand 1]: CSF [value] ([High/Medium/Low]), [key finding from ground truth]
- [Brand 2]: CSF [value] ([High/Medium/Low]), [key finding from ground truth]

**If Variant-level:**
- [Brand 1 - Variant A]: CSF [value], [key finding from ground truth]
- [Brand 1 - Variant B]: CSF [value], [key finding from ground truth]

**If PPG-level:**
- [Brand - Variant - Pack Size]: CSF [value], [key finding from ground truth]
- [Brand - Variant - Pack Size]: CSF [value], [key finding from ground truth]

#### Competitive dynamics

- [Key insight about competition / private label from ground truth]

#### Recommendations

1. [Specific action with rationale from ground truth]
2. [Specific action with rationale from ground truth]
3. [Specific action with rationale from ground truth]

### Alignment assessment

- [ ] Market health insights match ground truth
- [ ] Per-brand insights are complete
- [ ] Recommendations match ground truth rationale

**Differences from ground truth:**
- [List any structural or content differences]

---

## Issues

| Severity | Category | Issue | Location |
|----------|----------|-------|----------|
| High/Med/Low | [Completeness/Accuracy/Consistency/Ground truth] | [Description] | [Slide/section] |

---

## Overall assessment

- Quality gate: [Pass / Fail]
- Ready for human review: [Yes / No]
- Critical issues: [count]
- High-severity issues: [count]
- Medium-severity issues: [count]
- Low-severity issues: [count]

### Quality score: [X/10]

**Strengths:**
1. [Key strength]
2. [Key strength]

**Areas for improvement:**
1. [Improvement area]
2. [Improvement area]

---

## Notes

[Any additional context about CSV data quality, business logic validation, or specific recommendations]
