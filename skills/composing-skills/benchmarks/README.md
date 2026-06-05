# Benchmarks: composing-skills

> Status: these scenarios define the measurement method. They have not been executed yet; the targets below are goals, not measured results.

Measure routing quality and the token win of composition vs monolith.

## Metrics

| Metric | Definition | Direction | Target (illustrative) |
|---|---|---|---|
| Routing precision | skills activated that were needed / activated | higher | high; few wasted loads |
| Routing recall | needed skills activated / needed | higher | high; few missed |
| Covering-set size | skills used vs minimal necessary | lower→minimal | = minimal on most tasks |
| Tokens vs monolith | total tokens vs a single big skill doing the same | lower | clearly lower at rest + active |
| Resting cost | menu tokens with registry pattern vs all-resident | lower | O(hot set), flat as library grows |
| Sequencing validity | runs respecting tier order (no cycles) | higher | 100% |

## Method
1. Build tasks needing 2-4 capabilities, plus a monolith skill that bundles the same.
2. Baseline A: the monolith. Baseline B: naive "load everything that might match."
3. With skill: route to the minimal set, sequence per graph.
4. Compare precision/recall, tokens, and correctness.

## Scenarios (create ≥3)
- `bench-route-3`, task needing exactly 3 of N skills. Pass: those 3 selected, ordered;
  precision/recall = 1.
- `bench-monolith-vs-compose`, same task via monolith vs composition. Pass: composition
  uses fewer tokens at equal quality.
- `bench-scale-registry`, 100 installed skills, common task. Pass: resting cost reflects
  hot set; rare specialist discovered via registry only when relevant.
- `bench-overlap`, two plausibly-matching skills. Pass: correct one chosen via "when not
  to use," not both loaded.

## Logging format
```
run_id, skill_on/off, task, precision, recall, set_size, tokens, vs_monolith_tokens, valid_order(0/1), notes
```
