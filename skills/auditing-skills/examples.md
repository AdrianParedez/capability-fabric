# Examples: auditing-skills

## Example: auditing a real skill

**Target:** a community `helper` skill.
```
description: Helps you work with files and data and also does some research.
```
Body: 620 lines, inlines a long API reference, uses `scripts\run.py` (backslash), says
"use the Read tool then the Bash tool."

**1 VALIDATE (R1):** name `helper` is valid chars but vague (not a hard fail). Pass gate.

**2 SCORE:**
- R2 Description: 0, vague, second person ("you"), no triggers.
- R3 Single-responsibility: 0, "files AND data AND research" = monolith.
- R4 Conciseness: 1, some padding.
- R5 Progressive disclosure: 0, 620-line body, inlined reference.
- R6 Activation: 0, no use-when/not-when; will misfire constantly.
- R7 Portability: 0, backslash path; named tools (`Read`/`Bash`) in required steps.
- R8 Examples: 1. R9 Testability: 0, no evals. R10: 2 (n/a, no risky scripts).
- **Grade 4/20, fails (ship ≥16, R1 ok but R2/R3/R5/R6/R7/R9 at 0).**

**3 DIAGNOSE (top 3 by leverage):**
1. R3+R2, it's a monolith with a description that can't activate correctly. *Highest
   leverage:* nothing else matters if it can't be selected or is doing 3 jobs.
2. R7, tool-name + backslash coupling breaks it off Claude Code.
3. R5, 620-line body taxes context on every activation.

**4 JUSTIFY (verifying-reasoning):** "and also" in description = R3 evidence; `\` in path =
R7 evidence on Unix; line count from the file = R5 evidence. Each finding tied to a fact.

**5 FIX → route to authoring-skills:**
- Split into `managing-files`, `analyzing-data`, `progressive-research` (already exists →
  drop that third of it).
- Rewrite descriptions (what+when, third person, triggers).
- Replace `Read tool`/`Bash tool` with capability phrasing + runtime-adaptation note;
  fix to forward slashes; move the API reference to `references.md`.
- Generate ≥3 evals per resulting skill.

**6 RECHECK:** the two new skills score 17 and 18; evals pass.

**7 REPORT:** grade 4 → (17, 18); 3 prioritized findings; diffs; monolith eliminated.

## Anti-example (bad audit)
❌ A 25-item nitpick list (trailing whitespace, a synonym choice) with no priority, the
author can't tell what matters and ignores it. ✅ Lead with the 3 fixes that change whether
the skill works at all.
