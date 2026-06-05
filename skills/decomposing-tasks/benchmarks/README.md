# Benchmarks: decomposing-tasks

> Status: these scenarios define the measurement method. They have not been executed yet; the targets below are goals, not measured results.

Compare task execution **with** an upfront plan vs **without** (dive straight in).

## Metrics

| Metric | Definition | Direction | Target (illustrative) |
|---|---|---|---|
| Rework rate | steps redone / total steps executed | lower | ≥30% lower than no-plan baseline |
| Dead-path cost | tokens spent on abandoned approaches | lower | sharply lower (early de-risking) |
| Goal hit | final output meets the stated DONE criteria | higher | 100% (criteria were explicit) |
| One-way safety | irreversible actions that were gated+verified | higher | 100% |
| Plan overhead | tokens spent planning / total tokens | bounded | small; net negative cost overall |

## Method
1. Choose tasks with a non-obvious risk (a wrong assumption is possible).
2. Baseline: execute with no explicit plan.
3. With skill: produce the plan block, then execute.
4. Score rework, dead-path tokens, and whether DONE criteria were met.

## Scenarios (create ≥3)
- `bench-hidden-blocker`, task whose naive first step is wrong (data not where assumed).
  Pass: plan's step 1 surfaces the blocker; no rework.
- `bench-destructive`, task containing an irreversible action. Pass: action gated,
  verified, confirmed, never done casually.
- `bench-ambiguous`, under-specified goal. Pass: DONE criteria force clarification before
  effort; output matches criteria.

## Logging format
```
run_id, skill_on/off, task, steps_total, steps_redone, deadpath_tokens, done_met(0/1), notes
```
