# Benchmarks: authoring-skills

> Status: these scenarios define the measurement method. They have not been executed yet; the targets below are goals, not measured results.

Meta-benchmark: does the factory produce skills that are valid, portable, and effective?

## Metrics

| Metric | Definition | Direction | Target |
|---|---|---|---|
| Spec validity | generated skills passing spec validation (skills-ref) | higher | 100% |
| Eval pass | generated skill passes its OWN ≥3 evals | higher | 100% |
| Audit score | independent `auditing-skills` score of the output | higher | ≥ ship threshold |
| Portability | output runs unchanged on ≥2 runtimes (no tool-name coupling) | higher | 100% |
| Single-responsibility | generated description with no "and also" | higher | 100% |
| Author cost | tokens to generate a complete skill | bounded | reasonable; amortized over reuse |

## Method
1. Provide a set of capability requests (varying tiers/layers), including one over-broad
   request that should be **refused/split**.
2. Run the factory end-to-end (GAP→…→AUDIT).
3. Validate each output against the spec; run its own evals; score with `auditing-skills`;
   attempt to run it on a second runtime profile.

## Scenarios (create ≥3)
- `bench-generate-procedure`, a clear single-capability request. Pass: valid, eval-passing,
  audit ≥ threshold.
- `bench-refuse-monolith`, over-broad request. Pass: factory splits it into specific
  skills rather than emitting a monolith.
- `bench-portable`, request that tempts tool-name coupling. Pass: output references
  capabilities; runs on a second runtime profile unchanged.

## Logging format
```
run_id, request, spec_valid(0/1), own_evals_pass(0/1), audit_score, portable(0/1), split_if_needed(0/1), tokens, notes
```
