# References: operating-autonomously

## Contents
- Loop-state detection
- Retry-with-variation
- Designing escalation
- Bounding strategies
- Source material

## Loop-state detection
The single most important autonomous behavior is honest self-assessment each iteration.
Signals:
- **Progress:** a DONE criterion measurably closer; a previously-failing check now passes;
  new information that unblocks a step.
- **Stuck:** identical error twice; the same action attempted ≥2×; a check that fails the
  same way; oscillation between two states; ledger NEXT ACTION unchanged across iterations.
- **Done:** every DONE criterion satisfied AND verified. Not "feels finished."

If you cannot classify the iteration, that itself is a stuck signal, stop and diagnose.

## Retry-with-variation
Repeating a failing action wastes budget and never converges. Each retry must change a
*dimension*: approach, tool, granularity, assumptions, or inputs. Track attempts as
`(sub-problem, strategy, result)` so you never reuse a failed strategy. After N (default 3)
*distinct* strategies fail, the sub-problem is genuinely hard → de-scope or escalate.

## Designing escalation
A good escalation is a **decision request**, not a status dump:
- State the goal and where you are.
- State exactly what's blocking and what you tried (the varied attempts).
- State the **specific decision** needed and your **recommended option**.
- Make it answerable in one step (ideally a single choice).
Bad escalation: "I'm stuck, help." Good: "Migration needs to drop `legacy_id`; 0 readers
found but it's irreversible and beyond my mandate. Recommend: proceed with backup. OK?"

## Bounding strategies
| Bound | Default | Why |
|---|---|---|
| attempts per sub-problem | 3 distinct strategies | converge or escalate |
| context | hard ceiling (~78%) | avoid rot; checkpoint instead |
| turns/cost | task-set cap | prevent runaway spend |
| scope | the plan's DONE criteria | prevent gold-plating |
| wall-clock (if scheduled) | per-run budget | yield and resume |

## Source material
- OpenClaw plan-execute-reflect loop; Hermes AIAgent reason→act→self-eval cycle.
- Anthropic, long-horizon execution & reliability (compaction as a stop/continue lever).
- METR long-task reliability framing (bounded autonomy as horizon grows).
(Full URLs in `docs/research/_sources.md`.)
