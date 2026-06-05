---
name: auditing-skills
description: Scores and improves an existing Agent Skill against a spec + quality rubric, then proposes or applies concrete refactors (split monoliths, sharpen descriptions, fix portability). Use to review, grade, lint, or improve a skill, or to maintain a skill library at scale. Justifies each finding with verifying-reasoning and routes fixes back to authoring-skills.
license: Apache-2.0
metadata:
  author: Adrian Paredez
  version: "1.0"
  tier: "4"
  layer: meta/quality
compatibility: Requires filesystem read of the target skill; write only if applying fixes. Runtime-agnostic.
---

# Auditing skills

Authoring creates skills; auditing keeps them good as the library grows. This skill grades
a skill against an objective rubric, finds the highest-leverage problems, and turns them
into concrete fixes, so quality scales past what any single author tracks.

## Use this when
- Reviewing / grading / linting / improving a skill (yours or third-party).
- Maintaining a library of many skills (periodic audit, pre-merge gate).
- After `authoring-skills` produces a skill (the independent check).
- **Skip** for a quick personal note-to-self skill no one else uses.

## The audit

```
- [ ] 1 VALIDATE spec compliance (name/description/fields), pass/fail, hard gate
- [ ] 2 SCORE    rate each rubric dimension 0-2 (see references); sum to a grade
- [ ] 3 DIAGNOSE find the top 1-3 issues by leverage (what most hurts use/cost/portability)
- [ ] 4 JUSTIFY  for each finding, give evidence (a line, a missing case), verifying-reasoning
- [ ] 5 FIX      propose concrete edits; for big issues, route to authoring-skills (e.g. split)
- [ ] 6 RECHECK  re-score after fixes; confirm evals still/now pass
- [ ] 7 REPORT   grade + findings + diffs + before/after score
```

## The rubric (0-2 each; see references for anchors)

| # | Dimension | Asks |
|---|---|---|
| R1 | Spec validity | frontmatter rules met? (hard gate, fail = blocked) |
| R2 | Description quality | what+when, third person, distinct from neighbors, trigger words |
| R3 | Single responsibility | one capability? any "and also" smell? |
| R4 | Conciseness | every token justified? explains things the model knows? |
| R5 | Progressive disclosure | body <500 lines? detail split, one level deep? |
| R6 | Activation safety | "use when/not when"? overlaps disambiguated? |
| R7 | Portability | capabilities not tool names? fwd slashes? runtime-adaptation? |
| R8 | Evidence/examples | concrete examples + anti-example? consistent terms? |
| R9 | Testability | ≥3 evals present? benchmarks measurable? |
| R10 | Safety/scripts | solve-don't-punt, no magic constants, deps declared, one-way gated |

Grade = Σ/20. Ship ≥16 **and** R1 pass **and** no dimension at 0.

## Diagnose by leverage (don't list everything)
Rank issues by impact, not count. A vague description (R2) that prevents activation wastes
the whole skill, fix that before a cosmetic wording nit. The audit's value is *prioritized*
improvement, not an exhaustive lint dump.

## Common fixes the audit prescribes
| Finding | Fix |
|---|---|
| Monolith (R3 low) | split by capability; route via composing-skills |
| Vague description (R2 low) | rewrite what+when, add trigger keywords, disambiguate |
| Bloated body (R4/R5 low) | cut model-known content; move depth to references/ |
| Tool-name coupling (R7 low) | replace with capability phrasing + runtime-adaptation note |
| No evals (R9 low) | generate ≥3 from observed gaps (authoring-skills step 2) |
| Overlap misfire (R6 low) | add "for X use Y" cross-links to both skills |

## Apply vs propose
- **Propose** (default for third-party / high-risk): output the findings + diffs for review.
- **Apply** (when authorized & low-risk): make the edits, then RECHECK. Treat edits to a
  shared skill as a change requiring the `guarding-code-quality` honesty in the report.

## Runtime adaptation
- **Minimum:** filesystem read. Use `skills-ref validate` for R1 if available; else apply
  the name/description rules manually.
- Auditing is reasoning + file reads, portable across all runtimes.

## Files
- `references.md`, rubric anchors (what 0/1/2 looks like per dimension).
- `examples.md`, a real audit with score, findings, and fixes.
- `templates/audit-report.md`, the report format.
- `checklists/audit.md`, the audit pass as a checklist.
- `benchmarks/`, does the audit catch seeded defects and improve scores?
