---
status: 🟨 In Progress
project: Get Shit Done (GSD) Framework Review
published_date:
video_url:
thumbnail_link:
tags:
  - youtube/video
  - technical-review
  - ai-tools
  - claude-code
  - spec-driven-development
---

# ═══════════════════════════════════════════════════════════════
# 💡 PHASE 1: PREP & BRAINSTORMING
# ═══════════════════════════════════════════════════════════════

## 🎯 Why This Video?

**Core Problem to Solve:**
AI coding assistants promise reliability but deliver inconsistent quality as conversations grow. Most developers don't understand that the issue isn't prompting - it's context.

**Unique Value I Bring:**
* Explaining the "context engineering vs. prompt engineering" distinction clearly
* Showing (not just telling) how GSD's fresh subagent pattern prevents degradation
* PM perspective on traceability and atomic commits

**What Makes This Different from Other Reviews:**
* Focus on the "why" (context engineering) not just the "how" (commands)
* Real demo showing the problem/solution, not just feature list
* Solo developer perspective (not enterprise cheerleading)

---

## 🎬 Key Points to Hit

**Must-cover concepts:**
* Context window problem - quality degrades as conversations grow
* GSD's 6 documents: PROJECT.md, ROADMAP.md, STATE.md, PLAN.md, SUMMARY.md, ISSUES.md
* Fresh subagent pattern - 200k tokens per task, zero degradation
* Atomic git commits - independently revertable
* XML task blocks with verification steps

**Differentiation vs. alternatives:**
* GitHub Spec Kit = enterprise complexity (Jira, sprints)
* LangChain = general-purpose framework
* GSD = solo developer focused, zero bloat

**PM perspective:**
* STATE.md as living memory across sessions
* Git history becomes clean narrative
* Traceability of decisions and trade-offs

---

## 📌 Hook Ideas

* "AI coding assistants are incredible... until they aren't"
* "I found the one plugin that made Claude Code actually reliable"
* "Stop 'vibe coding' - here's what you should do instead"
* "The problem with AI coding isn't the prompts, it's the context"

---

## 📦 Title Ideas

* This Plugin Made Claude Code Actually Reliable
* Stop "Vibe Coding" - Use Context Engineering Instead
* The Solo Developer's Secret Weapon for AI Development
* I Fixed My AI Code Quality Problem (Here's How)
* Context Engineering > Prompt Engineering

---

## 🎨 Thumbnail Concept Ideas

* **Split screen:** Messy terminal with errors (left) vs. clean GSD execution (right) with checkmarks
* **Before/after:** "Context Engineering > Prompt Engineering" text over terminal comparison
* **Bold statement:** "Stop Vibe Coding" with red X over messy code
* **Tool focus:** GSD logo + 3 key benefits + rating badge

---

# ═══════════════════════════════════════════════════════════════
# 📋 PHASE 2: VIDEO OUTLINE (Brief)
# ═══════════════════════════════════════════════════════════════

## Timeline Overview

| Section | Duration | Key Content |
|---------|----------|-------------|
| Hook | 0:00-0:45 | Problem statement → GSD reveal |
| Context | 0:45-2:30 | Why AI fails → Context engineering solution |
| Demo | 2:30-7:00 | Setup → Roadmap → Plan → Execute |
| Verdict | 7:00-9:00 | Pros/cons → PM perspective → When to use |
| Outro | 9:00+ | Recap → Alternatives → CTA |

---

## Section-by-Section Notes

**Hook (0:00-0:45)**
* Show the pain: Claude saying "I'll be more concise now"
* Introduce GSD as the fix
* Tease: No enterprise complexity

**Context Explained (0:45-2:30)**
* Context window problem
* 6 documents overview
* Creator: TÂCHES (solo dev philosophy)

**Demo (2:30-7:00)**
1. Setup: `/gsd:new-project` interactive questions
2. Roadmap: `/gsd:create-roadmap` → STATE.md living memory
3. Plan: `/gsd:plan-phase 1` → XML tasks with verification
4. Execute: `/gsd:execute-plan` → subagent + atomic commits

**Verdict (7:00-9:00)**
* ✅ Fresh context, atomic commits, XML structure
* ⚠️ Setup time, learning curve, overkill for tiny scripts
* 💼 PM view: traceability, decision documentation

**Outro (9:00+)**
* "If you know clearly what you want, this WILL build it"
* Mention: Spec Kit (enterprise), LangChain (general)
* CTA: Try GSD, subscribe for more

---

# ═══════════════════════════════════════════════════════════════
# ✅ PHASE 3: PRE-RECORDING CHECKLIST
# ═══════════════════════════════════════════════════════════════

## Environment Setup
* [ ] NixOS environment ready with clean terminal
* [ ] Font size: 16-18pt for readability
* [ ] GSD installed and tested in demo environment
* [ ] Test project ready for demo

## Audio/Video
* [ ] Mic audio test (gain levels recorded)
* [ ] OBS configured for 4K/1080p
* [ ] Test footage recorded and verified

## B-Roll Prep
* [ ] STATE.md close-up (living memory example)
* [ ] Git log with atomic commits
* [ ] XML task block from PLAN.md
* [ ] Messy "vibe coding" contrast footage

## Dry Run
* [ ] Full demo workflow test
* [ ] Timing check (target: 9-10 min)
* [ ] Command verification

## Common Viewer Questions to Address
* [ ] "Can I use this with ChatGPT?" → No, Claude Code only
* [ ] "Do I need to pay for Claude?" → Yes, Claude Code subscription
* [ ] "Overkill for small scripts?" → Yes, for real projects
* [ ] "What's the `--dangerously-skip-permissions` flag?" → Frictionless automation

---

# ═══════════════════════════════════════════════════════════════
# 🎙️ PHASE 4: RECORDING TRANSCRIPT
# ═══════════════════════════════════════════════════════════════
*Paste your recorded transcript here - will be used to generate YouTube assets*

## Transcript
*(Transcript will be pasted here after recording)*



## Notes from Recording
*What worked well, what to change, timing notes:*



---

# ═══════════════════════════════════════════════════════════════
# 🎬 PHASE 5: YOUTUBE ASSETS (Generated from transcript)
# ═══════════════════════════════════════════════════════════════

## 📌 Final Title

*(Select from Phase 1 ideas or create new based on recording)*



---

## 📝 Video Description

```
*(Generate based on actual content covered)*

Get Shit Done (GSD) is a meta-prompting and spec-driven development system for Claude Code.

In this review:
- [Key point 1 from recording]
- [Key point 2 from recording]
- [Key point 3 from recording]

Get GSD: https://github.com/glittercowboy/get-shit-done

Chapters ▼

#ClaudeCode #SpecDrivenDevelopment #AIAssistedDevelopment
```

---

## 📑 Video Chapters

```
*(Update with actual timestamps from edit)*

0:00 - [Hook section]
0:45 - [Context section]
2:30 - [Demo section]
7:00 - [Verdict section]
9:00 - [Outro section]
```

---

## 📌 Pinned Comment

```
🔗 Resources:
• GSD Framework: https://github.com/glittercowboy/get-shit-done
• [Additional resource from video]

💡 Key insight: [Extract main insight from recording]

[Question to engage comments]

Drop a comment below 👇
```

---

## 🏷️ Tags/Keywords

```
Claude Code, Get Shit Done, GSD, spec-driven development, context engineering, AI coding assistant, meta-prompting, solo developer, vibe coding, atomic commits, subagent orchestration, AI development tools, Claude plugin
```

---

## 🔄 Post-Production Checklist

* [ ] Thumbnail created and uploaded
* [ ] Description finalized with correct links
* [ ] Chapters/timestamps verified accurate
* [ ] Pinned comment prepared and scheduled
* [ ] Tags added for SEO
* [ ] End screen elements added
* [ ] Cards added to related content
* [ ] Closed captions generated/reviewed
* [ ] Final quality check (audio/video)

---

## 📓 Post-Upload Notes

*Performance, comments, ideas for follow-up:*



