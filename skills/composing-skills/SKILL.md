---
name: composing-skills
description: Routes a task to the smallest set of skills that covers it and sequences them without context bloat, instead of one monolithic instruction. Use when a task spans multiple capabilities, when many skills are installed, or when deciding which skills to apply. Reads the skill registry to discover specialists and respects the tier/dependency ordering.
license: Apache-2.0
metadata:
  author: Adrian Paredez
  version: "1.0"
  tier: "3"
  layer: meta/control
compatibility: Any runtime that can load multiple skills. Uses filesystem read for the registry; degrades to description-only routing without one.
---

# Composing skills

A library of small, sharp skills beats one giant skill, but only if the right ones are
**selected and sequenced** per task. This skill is the router and conductor: it turns "I
have 100 skills" into "I'm using these 3, in this order, right now."

## Use this when
- A task needs more than one capability (research + plan + code).
- Many skills are installed and you must pick.
- You're tempted to write/use a monolithic "do everything" skill, compose instead.
- **Skip** for a task one specific skill already covers, just use that skill.

## Routing (which skills)

```
- [ ] 1 CLASSIFY the task: what capabilities does it actually need?
- [ ] 2 MATCH    candidate skills by description (+ registry for non-resident specialists)
- [ ] 3 MINIMIZE pick the SMALLEST covering set; prefer the most specific skill per need
- [ ] 4 ORDER    sequence by the dependency graph (tier N may use tier <=N)
- [ ] 5 LOAD     activate one body at a time, as each phase begins (not all upfront)
```

## Sequencing (what order)

Follow the tier/dependency rules (see `docs/06`):
- **Plan → Execute → Verify** is the default backbone:
  `decomposing-tasks` → (`sustained-execution` if long) → domain work → `verifying-reasoning`.
- **Research feeds planning:** `progressive-research` before/within planning when facts are
  missing.
- **Budget runs underneath everything:** `context-budgeting` is ambient, not a phase.
- **Autonomy wraps the backbone:** `operating-autonomously` is the outer loop for
  unattended runs.
- A skill may invoke skills at its own tier or **below**, never above (keeps it acyclic).

## Composition principles

1. **Smallest covering set.** Use the fewest skills that fully cover the task. Each extra
   loaded body is active-context cost. Two well-chosen skills beat five.
2. **Most specific wins.** Prefer the skill whose description most tightly matches the
   need; general skills are fallbacks. Disambiguate overlapping skills via their "use this
   when / not when" lines.
3. **Sequential activation, not bulk.** Load a skill's body when its phase starts; let it
   fall out when the phase ends (progressive disclosure across skills). Don't preload the
   whole chain.
4. **Reference, don't inline.** When skill A needs B's capability, hand off to B (name +
   when), don't copy B's content into A. Copies rot and bloat.
5. **Hand off via durable state.** Multi-skill tasks pass context through the
   `sustained-execution` ledger, not by stuffing everything in the window.
6. **Detect the monolith smell.** If you're writing a skill that needs "and also research,
   and also plan, and also verify," you're rebuilding the fabric inside one file, split it
   and compose instead.

## The registry pattern (scaling to hundreds)
Keep `skills/REGISTRY.md` as a one-line-per-skill index (name, when-to-use). Frequently
used skills sit in the resting menu; rare specialists live registry-only and are discovered
by reading the registry on demand. This caps resting token cost at O(hot set), not
O(all skills). See `docs/design/07-activation-strategy.md`.

## Worked routing
| Task | Covering set (ordered) |
|---|---|
| "Research X and write a report" | progressive-research → verifying-reasoning (+budget) |
| "Build feature over a long session" | decomposing-tasks → sustained-execution → guarding-code-quality → verifying-reasoning |
| "Run this goal unattended" | operating-autonomously ⟨ wraps the build chain ⟩ |
| "Make me a skill for Y" | authoring-skills → composing-skills(sizing) → auditing-skills |

## Runtime adaptation
- **Auto-selecting runtimes (Claude Code):** routing happens in reasoning; rely on strong
  descriptions, then this skill sequences them.
- **Explicit-invocation runtimes (Codex `$name`):** this skill names which skills to invoke
  and in what order.
- **No selector (OpenClaw/Hermes):** treat each SKILL.md as an instruction module; this
  skill is the plan for which modules to read when.

## Files
- `references.md`, routing heuristics, overlap resolution, anti-monolith.
- `examples.md`, routing traces for real tasks.
- `templates/composition-plan.md`, record the chosen set + order.
- `checklists/composition.md`, pre-execution routing gate.
- `benchmarks/`, routing precision/recall & token-vs-monolith method.
