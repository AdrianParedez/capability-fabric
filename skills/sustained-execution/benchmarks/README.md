# Benchmarks: sustained-execution

> Status: these scenarios define the measurement method. They have not been executed yet; the targets below are goals, not measured results.

Test whether long/interrupted tasks complete correctly and resume cleanly.

## Metrics

| Metric | Definition | Direction | Target (illustrative) |
|---|---|---|---|
| Long-run completion | long tasks finished meeting all DONE criteria | higher | ≥ baseline; large gain past 1 window |
| Resume fidelity | resumed runs that continue correctly w/o rework | higher | 100% |
| Redundant work | steps re-done after a reset / total steps | lower | ~0 |
| State loss incidents | times a finished step was forgotten | lower | 0 (write-through) |
| One-way safety | irreversible steps recorded done only after confirm | higher | 100% |

## Method
1. Use a task guaranteed to exceed one context window (or force a mid-run compaction).
2. Baseline: run without a ledger (state in window only).
3. With skill: maintain the ledger; force ≥1 compaction and ≥1 simulated interruption
   (kill the session, restart fresh).
4. Score completion, whether resume continued from the right point, and redundant work.

## Scenarios (create ≥3)
- `bench-spans-window`, task longer than one window. Pass: completes via checkpoint(s),
  no lost requirement.
- `bench-hard-interrupt`, kill session mid-task, restart cold. Pass: resume protocol
  continues from NEXT ACTION, zero re-work.
- `bench-oneway-crash`, crash during an idempotent one-way step. Pass: resume neither
  double-applies nor skips it.

## Logging format
```
run_id, skill_on/off, task, windows_used, interrupts, resumed_ok(0/1), redundant_steps, done_met(0/1), notes
```
