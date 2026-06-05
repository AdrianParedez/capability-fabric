# Checklist: audit pass

- [ ] **R1 spec** validated (name + description + fields). Fail = hard stop, fix first.
- [ ] Each rubric dimension **R2-R10 scored 0-2** with the reference anchors.
- [ ] Grade computed; verdict applied (**ship ≥16, R1 pass, no dimension at 0**).
- [ ] Findings **ranked by leverage**; reported the **top 1-3**, not an exhaustive nit list.
- [ ] Every finding has **evidence** (a line, a missing case), justified via `verifying-reasoning`.
- [ ] Fixes are **concrete**; large structural issues **routed to `authoring-skills`** (e.g. split monolith).
- [ ] Portability checked specifically: **no tool-name coupling, forward slashes, runtime-adaptation present**.
- [ ] If fixes **applied**: re-scored (RECHECK) and **evals re-run**; report is honest about
      what was verified.
- [ ] If **third-party / risky**: **proposed** diffs for review rather than applied silently.
