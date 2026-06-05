# Benchmarks: auditing-skills

> Status: these scenarios define the measurement method. They have not been executed yet; the targets below are goals, not measured results.

Meta-benchmark: does the audit reliably catch real problems and improve skills?

## Metrics

| Metric | Definition | Direction | Target |
|---|---|---|---|
| Defect-catch rate | seeded skill defects flagged | higher | ≥90% of seeded defects |
| False-finding rate | findings on actually-fine dimensions | lower | low; signal not noise |
| Score correlation | audit grade vs independent human/eval ranking | higher | strong positive |
| Leverage accuracy | top-3 findings are the actually-highest-impact | higher | high |
| Improvement delta | grade/eval-pass after applying prescribed fixes | higher | clear positive |
| Cost-per-audit | tokens to audit one skill | bounded | low; scales to libraries |

## Method
1. Build a corpus of skills with **known seeded defects**: a monolith, a vague description,
   a tool-name-coupled one, one with no evals, plus clean controls.
2. Run the audit on each; compare flagged defects to the seeded ground truth.
3. Apply prescribed fixes; re-audit; measure improvement delta.
4. Check false findings on the clean controls.

## Scenarios (create ≥3)
- `bench-seeded-monolith`, bundled-capability skill. Pass: R3=0 flagged, split prescribed.
- `bench-vague-desc`, un-activatable description. Pass: R2=0 flagged as top finding.
- `bench-coupled`, tool-name/backslash coupling. Pass: R7=0 flagged with capability fix.
- `bench-clean-control`, a good skill. Pass: high grade, no false 0s.

## Logging format
```
run_id, target_skill, seeded_defects, caught, false_findings, grade, post_fix_grade, top3_accurate(0/1), tokens, notes
```
