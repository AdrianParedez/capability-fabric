# Benchmarks: <skill name>

> Write these BEFORE the body (evaluation-driven). ≥3 scenarios capturing the gaps the
> skill exists to fix. Measure against a baseline run without the skill.

## Metrics
| Metric | Definition | Direction | Target |
|---|---|---|---|
| <primary> | <...> | <higher/lower> | <...> |

## Scenarios (≥3)
- `bench-<a>`, <setup>. Pass: <criterion>.
- `bench-<b>`, <setup>. Pass: <criterion>.
- `bench-<c>`, <setup>. Pass: <criterion>.

## Logging format
```
run_id, skill_on/off, scenario, <metric columns...>, notes
```
