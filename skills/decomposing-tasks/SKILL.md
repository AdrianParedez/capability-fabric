---
name: decomposing-tasks
description: Turns a goal into a verifiable, risk-ordered plan with explicit success criteria before any work starts. Use at the start of any multi-step, ambiguous, or long-horizon task. Hands off to sustained-execution for long runs and verifying-reasoning to validate the plan.
license: Apache-2.0
metadata:
  author: Adrian Paredez
  version: "1.0"
  tier: "2"
  layer: meta/procedure
compatibility: Any agent runtime. No special tools required; a scratch file helps for large plans.
---

# Decomposing tasks

A plan is not a list of steps, it is a set of **success criteria**, an ordering that
**reduces risk early**, and a marker of what is **reversible vs one-way**. Plan before you
act; a bad plan compounds over a long run.

## Use this when
- The task has ≥3 non-trivial steps, is ambiguous, or will run long.
- The cost of going down the wrong path is high.
- **Skip** for genuinely trivial single-step tasks, planning them wastes tokens.

## The method

```
- [ ] 1 RESTATE   the goal in one sentence + define DONE (success criteria, testable)
- [ ] 2 UNKNOWNS  list what you don't know; resolve blocking unknowns FIRST
- [ ] 3 DECOMPOSE break into steps, each with a checkable outcome
- [ ] 4 ORDER     sequence to surface risk/uncertainty early (de-risk before invest)
- [ ] 5 CLASSIFY  mark each step reversible (safe to try) or one-way (verify before doing)
- [ ] 6 VALIDATE  sanity-check the plan (verifying-reasoning) before executing
- [ ] 7 HANDOFF   short task -> execute now; long task -> sustained-execution ledger
```

## Principles

1. **Define DONE first.** If you can't state how you'll know the task succeeded, you're
   not ready to start. Success criteria are testable, not aspirational.
2. **Unknowns before effort.** The biggest risk is a wrong assumption. Front-load the
   steps that resolve unknowns (a quick spike, a doc check) before steps that build on
   them. Cheap experiments that kill bad plans early are the highest-value steps.
3. **Each step has an outcome you can check.** "Work on auth" is not a step. "Auth: login
   endpoint returns a valid JWT for a known user" is.
4. **Order to de-risk, not to feel productive.** Do the scary/uncertain part early while
   it's cheap to change course, not last when you're invested.
5. **Reversible vs one-way doors.** Reversible steps: just try them. One-way steps (delete
   data, publish, send, migrate, overwrite): plan, verify, and confirm before doing.
6. **Right altitude.** 3-9 steps for most tasks. If you have 30, group into phases. If you
   have 1, you didn't need this skill.
7. **Plans are living.** Re-plan when an unknown resolves differently than assumed; don't
   march a dead plan to completion.

## Output: the plan block

```
GOAL: <one sentence>
DONE WHEN:
  - <testable criterion 1>
  - <testable criterion 2>
UNKNOWNS (resolve blocking ones first):
  - <unknown> -> resolve by <step #>
PLAN:
  1. <step>, outcome: <checkable>, [reversible|one-way], de-risks: <unknown?>
  2. ...
RISKS: <top 1-2 things that could go wrong> -> <mitigation/early check>
```

## Anti-patterns
- Starting to code/act before DONE is defined.
- Ordering by "easiest first" instead of "riskiest-cheap-to-test first."
- Steps with no checkable outcome (can't tell if they're done).
- Treating a one-way door as reversible (irreversible action without verification).
- A 20-step flat plan with no phases (un-trackable; group it).

## Runtime adaptation
- **Minimum:** none, this is pure method. For large plans, write the plan block to a file
  so it survives compaction (see `sustained-execution`).
- If the runtime has a "plan mode," use this method to *fill* it, not replace it.

## Files
- `references.md`, risk-ordering, reversible/one-way doctrine, estimation.
- `examples.md`, worked plans, good vs bad.
- `templates/plan.md`, the plan block to fill.
- `checklists/plan-quality.md`, gate before executing.
- `benchmarks/`, rework-rate and plan-validity method.
