# Skill Activation Strategy

> How the right skills get selected at the right time when hundreds are installed -
> without paying for the ones you don't use. This is the discipline that makes the
> Fabric *scale*.

## 1. The selection problem

At rest, every installed skill contributes ~100 tokens (`name`+`description`) to the
system prompt. With 100 skills that's ~10k tokens of always-on "menu," and the agent must
pick correctly from it. Two failure modes:

- **Menu bloat**, too many resting descriptions crowd the window.
- **Misfire**, agent activates the wrong skill, or fails to activate the right one,
  because descriptions overlap or are vague.

The strategy below attacks both.

## 2. Description engineering (the primary lever)

The `description` is the *only* signal at discovery time. Rules every Fabric skill obeys:

1. **What + When, third person.** `"Decomposes a goal into a verifiable, risk-ordered
   plan. Use before starting any multi-step or long-horizon task."`
2. **Front-load trigger keywords.** The first clause carries the matchable nouns/verbs.
3. **Name the negative space when overlap is likely.** e.g. progressive-research says
   "for *external* information; for breaking a task into steps use task decomposition."
   This disambiguates neighbors and prevents misfire.
4. **One capability per description.** No "and also." Forces single responsibility (§4
   of the taxonomy) and keeps the menu legible.
5. **≤ ~200 chars where possible.** Resting cost is per-character; tight descriptions let
   you install *more* skills under the same menu budget.

## 3. Three-stage activation pipeline

```
Stage 0  REST      name+description only (~100 tok/skill)            [always]
Stage 1  ROUTE     match task → candidate skill(s) by description    [composing-skills]
Stage 2  ACTIVATE  load one SKILL.md body                            [<5k tok]
Stage 3  DEEPEN    load referenced files / run scripts on demand     [as needed]
```

- **Stage 1 routing** is owned by `composing-skills`: given a task, identify the smallest
  set of skills that covers it (usually 1-3), prefer the most specific, and sequence them
  per the dependency graph. Routing happens *in reasoning*, not by loading bodies.
- **Stage 2** loads exactly one body at a time when possible; multi-skill tasks load
  sequentially as each phase begins, not all upfront.
- **Stage 3** is progressive disclosure within a skill.

## 4. Portability contract (model-agnostic activation)

Activation differs per runtime; skills must not assume one. The contract:

| Runtime reality | Skill must… |
|---|---|
| Claude Code auto-selects by description | Write strong descriptions (above) |
| Codex needs `$name`/`/skills` for explicit + caps menu at ~2% ctx | Keep descriptions short; never rely on auto-only |
| OpenClaw/Hermes have no skill selector UI | Make SKILL.md self-contained & invokable as a plain instruction file |
| Tool vocabularies differ | Reference *capabilities* ("read a file", "run a shell command"), never specific tool names in required steps |
| Mechanism may be absent (no hooks, no subagents) | Degrade: describe the manual fallback |

Concretely, each Fabric SKILL.md includes a short **"Runtime adaptation"** note stating
its hard requirements (usually: filesystem read + shell) and what to do when richer
mechanisms (subagents, hooks) are unavailable.

## 5. Scaling to hundreds: the index pattern

Beyond ~50 skills, add a thin **router skill / index** rather than more resting menu:

- Group skills into *families* (the taxonomy tiers/clusters). Maintain
  `skills/REGISTRY.md` as a one-line-per-skill index.
- A single high-tier router (`composing-skills` plays this role here) reads the registry
  on demand to discover specialist skills, instead of every specialist sitting in the
  resting menu at full description weight.
- For very large libraries, demote rarely-used skills to "registry-only" (discoverable by
  the router via file read) and keep only frequently-used skills in the auto-loaded menu.
  This caps resting cost at O(hot set) instead of O(all skills).

## 6. Anti-misfire checklist (applied to every Fabric skill)

- [ ] Description states a *distinct* trigger from its graph neighbors.
- [ ] No two installed skills share leading keywords without a disambiguating clause.
- [ ] Skill name predicts the description (agent can guess one from the other).
- [ ] Body opens with a 1-line "Use this when / do NOT use when."
- [ ] Overlapping skills cross-link ("for X instead, see Y").

## 7. Measuring activation health

Tracked in each skill's `benchmarks/`:
- **Activation precision**, fired when it should / total firings.
- **Activation recall**, fired when it should / times it should have.
- **Menu cost**, total resting tokens of installed set vs budget.
Targets and method live in `benchmarks/` per skill and are aggregated by `auditing-skills`.
