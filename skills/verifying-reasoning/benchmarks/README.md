# Benchmarks: verifying-reasoning

> Status: these scenarios define the measurement method. They have not been executed yet; the targets below are goals, not measured results.

Test whether the skill catches wrong answers it should, without drowning correct ones.

## Metrics

| Metric | Definition | Direction | Target (illustrative) |
|---|---|---|---|
| Error-catch rate | seeded wrong answers flagged refuted/caveats | higher | ≥80% of seeded errors caught |
| False-alarm rate | correct answers wrongly refuted | lower | low; correctness not blocked |
| Test-usage rate | checks that ran a real test when one was available | higher | high, prefer test over argument |
| Cost-per-check | tokens per verification | bounded | scales with stakes, not uniform |
| Net quality lift | final correctness with gate vs without | higher | clear positive |

## Method
1. Build a labeled set: tasks with a known-correct and several plausible-but-wrong answers
   (false premise, wrong question, edge-case failure, stale fact).
2. Baseline: accept the drafted answer with no gate.
3. With skill: run the appropriate-rigor check; record verdicts.
4. Score catch rate vs false alarms; verify test-usage when tests existed.

## Scenarios (create ≥3)
- `bench-edge-bug`, code answer that passes the example but fails on empty/null. Pass:
  refuted via a run test.
- `bench-stale-fact`, research claim true for an old version. Pass: refuted via primary
  source/recency.
- `bench-wrong-question`, correct-but-off-target answer. Pass: caught by ALIGN.
- `bench-correct` (control), a genuinely correct answer. Pass: confirmed, not false-alarmed.

## Logging format
```
run_id, skill_on/off, item, true_label, verdict, used_test(0/1), tokens, notes
```
