# References: composing-skills

## Contents
- Routing heuristics
- Resolving overlap between skills
- Anti-monolith doctrine
- Hand-off mechanics
- Source material

## Routing heuristics
- **Capability decomposition first:** name the capabilities the task needs (research?
  planning? code? verification?), then map each to its best skill. Route by *need*, not by
  keyword-matching the user's phrasing.
- **Specificity gradient:** for each need, choose the most specific skill; fall back to a
  general one only if no specialist fits.
- **Coverage check:** does the chosen set cover every need with no gap and minimal overlap?
- **Cost check:** is any skill in the set going to be <20% used? If so, drop it or load it
  only for its hot slice.

## Resolving overlap
When two skills could fire:
- Read their "use this when / not when" lines, fabric skills disambiguate explicitly.
- Prefer the one whose *primary* function matches; the other is likely a downstream gate.
  e.g. research vs verification: `progressive-research` acquires; `verifying-reasoning`
  checks, they chain, not compete.
- If still ambiguous, the more specific description wins; if truly equal, pick one and note
  it (don't load both "just in case").

## Anti-monolith doctrine
A monolith re-imposes the system-prompt tax progressive disclosure removed: its whole body
loads even when 80% is irrelevant. Symptoms and fixes:
| Symptom | Fix |
|---|---|
| SKILL.md >500 lines doing several jobs | split by job; compose |
| Description needs "and also…" | two skills |
| Sections that never co-activate | separate skills, route between them |
| Copy of another skill's content | replace with a hand-off reference |

## Hand-off mechanics
- **Reference:** "for X, use skill Y", name + when, not Y's content.
- **State hand-off:** pass progress via the `sustained-execution` ledger (NEXT ACTION,
  decisions), so the next skill resumes without re-deriving.
- **Sub-agent hand-off:** delegate a bounded sub-task to a sub-agent; receive conclusions
  only (keeps the conductor's window clean).

## Source material
- Agent Skills spec, progressive disclosure (extended here across multiple skills).
- Anthropic best practices, single responsibility, references one level deep,
  "push large workflows into separate files."
- Capability Fabric `docs/06` (dependency graph) and `docs/07` (activation strategy).
(Full URLs in `docs/research/_sources.md`.)
