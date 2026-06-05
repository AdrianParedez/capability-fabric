# Benchmarks: context-budgeting

> Status: these scenarios define the measurement method. They have not been executed yet; the targets below are goals, not measured results.

Measure the skill against a **baseline run without it**. Same task, same model, same seed
where possible.

## Metrics

| Metric | Definition | Direction | Target (illustrative) |
|---|---|---|---|
| Tokens-to-completion | total tokens consumed to finish the task | lower | ≥20% below baseline on long tasks |
| Peak active context | max active-window tokens during the run | lower | stays below hard ceiling for entire run |
| Re-read rate | (# times offloaded material re-fetched) / (# offloads) | low but >0 | <0.3 (too high = over-offload; 0 = never needed offload) |
| Quality delta | task-success / rubric score vs baseline | ≥ 0 | equal or better, efficiency must not cost quality |

## Method

1. Pick a representative **long** task (≥ ~30 steps or large files), short tasks don't
   exercise the skill.
2. Run baseline (skill absent). Record metrics.
3. Run with skill active. Record metrics.
4. Compute deltas. The skill passes if tokens-to-completion drops, peak context stays
   under the hard ceiling, and quality delta ≥ 0.

## Scenarios (create ≥3)

- `bench-large-file-search`, answer a question requiring facts from 3 files >1k lines
  each. Pass: never loads a full file; answer correct.
- `bench-long-build`, multi-step build that exceeds soft ceiling. Pass: completes via
  ≥1 compaction with no lost requirement.
- `bench-noisy-tools`, task with verbose tool output (test runs, JSON dumps). Pass: peak
  context flat across iterations; outcomes preserved as one-liners.

## Logging format (one row per run)

```
run_id, skill_on/off, task, tokens_total, peak_active, reread_rate, quality_score, notes
```
