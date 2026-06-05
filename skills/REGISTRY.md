# Skill Registry: Capability Fabric

One line per skill: `name, when to use, tier`. This is the discovery index used by
`composing-skills` to route tasks and to keep resting context cost flat as the library
grows (see `docs/design/07-activation-strategy.md`). Add new skills here.

## Resident (hot set: keep in the auto-loaded menu)

- **context-budgeting**, manage the context window; cut tokens; prevent decay on long runs, `t1`
- **progressive-research**, find external info cheaply (search→triage→extract→corroborate), `t2`
- **decomposing-tasks**, turn a goal into a verifiable, risk-ordered plan before acting, `t2`
- **sustained-execution**, survive long/multi-session runs via an external ledger + checkpoints, `t2`
- **verifying-reasoning**, catch wrong answers before they ship (quality gate, no deps), `t2`
- **operating-autonomously**, run unattended: progress/stuck/done, bounded recovery, stop/escalate, `t3`
- **guarding-code-quality**, keep generated code correct, fitting, verified-before-done, `t0`
- **composing-skills**, route a task to the smallest skill set and sequence it; anti-monolith, `t3`
- **authoring-skills**, generate a new spec-compliant, portable skill from a capability, `t4`
- **auditing-skills**, score & improve an existing skill against the rubric, `t4`

## Registry-only (cold: discovered on demand, not in resting menu)

*(none yet, add rare/specialist skills here so they don't tax the resting menu;
`composing-skills` finds them by reading this file when a matching task appears.)*

## Tiers
`t0` domain · `t1` resource · `t2` process · `t3` orchestration · `t4` meta.
Dependency rule: a skill may reference skills at its own tier or **below**, never above
(keeps the graph acyclic, see `docs/design/06-dependency-graph.md`).

## Default routes (quick reference)
| Task shape | Route |
|---|---|
| Answer needs external info | progressive-research → verifying-reasoning |
| Multi-step build | decomposing-tasks → sustained-execution → guarding-code-quality → verifying-reasoning |
| Unattended goal | operating-autonomously ⟨ wraps the build route ⟩ |
| Make/fix a skill | authoring-skills → composing-skills(sizing) → auditing-skills |
| (always, underneath) | context-budgeting |
