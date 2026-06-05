# Benchmarks: progressive-research

> Status: these scenarios define the measurement method. They have not been executed yet; the targets below are goals, not measured results.

Measure against a baseline that researches the same questions without the skill.

## Metrics

| Metric | Definition | Direction | Target (illustrative) |
|---|---|---|---|
| Tokens-per-answer | total tokens consumed to reach the answer | lower | ≥40% below naive "open everything" |
| Accuracy | answer correct & sourced vs ground truth | higher | ≥ baseline (never trade accuracy for cost) |
| Sources opened | # full pages fetched into context | lower | typically 1-2 for lookups |
| Corroboration coverage | load-bearing claims with ≥2 sources / total | higher | 100% of load-bearing claims |
| Hallucination rate | unsourced/incorrect asserted facts | lower | ~0 |

## Method
1. Build a question set with known ground truth: mix of cheap lookups, version-specific
   facts, and one wide-survey question.
2. Baseline: answer with no method (model free-styles search/reads).
3. With skill: run the loop.
4. Score accuracy against ground truth; record token + sources-opened deltas.

## Scenarios (create ≥3)
- `bench-lookup`, single stable fact from a primary source. Pass: 1 source, correct.
- `bench-version-claim`, a version-specific contract that has stale answers online.
  Pass: corroborated, correct version cited.
- `bench-survey`, wide multi-source comparison. Pass: correct table, main-window tokens
  bounded (sub-agent isolation if available).

## Logging format
```
run_id, skill_on/off, question, tokens, sources_opened, correct(0/1), corroborated(0/1), notes
```
