# References: decomposing-tasks

## Contents
- Risk-first ordering
- Reversible vs one-way doors
- Writing testable success criteria
- Estimation & re-planning
- Source material

## Risk-first ordering
The value of a step is not its size but how much *uncertainty it removes per token spent*.
Order steps so that cheap experiments which could invalidate the plan run first. A 10-minute
spike that proves the API can't do what you assumed saves the entire build. Formalize:

```
priority(step) ≈ (uncertainty it resolves) × (cost of being wrong later) / (cost to run now)
```
Do high-priority steps first even if they're not the "natural" first step.

## Reversible vs one-way doors
- **Reversible** (two-way): edits to a working copy, adding code, local experiments. Bias
  to action, trying is cheaper than deliberating.
- **One-way** (irreversible/expensive to undo): deleting/overwriting data, DB migrations,
  publishing/sending, force-pushes, external API writes. Bias to caution, verify and
  confirm first. These steps should be explicitly marked and gated.
When unsure, treat as one-way.

## Writing testable success criteria
Bad: "improve performance." Good: "p95 latency of `/search` < 200ms on the seed dataset."
A criterion is testable if a script or a clear observation can return pass/fail. If you
can't write the test, the criterion is too vague to plan against.

## Estimation & re-planning
- Estimate in *uncertainty*, not hours: tag steps high/med/low confidence.
- High-uncertainty steps get an early de-risking check.
- Re-plan triggers: an unknown resolved differently than assumed; a step's outcome
  failed its check twice; scope changed. Re-planning early is cheap; a dead plan is not.

## Source material
- Reversible/irreversible "one-way door" decision framing (widely used in eng planning).
- Anthropic context-engineering: plan-validate-execute, verifiable intermediate outputs.
(Full URLs in `docs/research/_sources.md`.)
