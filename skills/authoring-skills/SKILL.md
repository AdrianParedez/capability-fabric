---
name: authoring-skills
description: Generates a new, spec-compliant, portable Agent Skill from a capability description, frontmatter, focused body, and the supporting file set, following progressive-disclosure and single-responsibility rules. Use when asked to create, scaffold, or package a skill. Sizes/splits via composing-skills and self-checks the output with verifying-reasoning, then hands to auditing-skills.
license: Apache-2.0
metadata:
  author: Adrian Paredez
  version: "1.0"
  tier: "4"
  layer: meta/procedure
compatibility: Requires filesystem write to create the skill directory. Runtime-agnostic output.
---

# Authoring skills

This is the **skill factory**: it turns a capability description into a production-ready
skill directory that any runtime can use. It encodes the open spec and the authoring
best-practices so the output is correct by construction.

## Use this when
- Asked to create / scaffold / package a new skill.
- You notice a repeated procedure worth capturing (the "I keep re-explaining this" signal).
- **Skip** if an existing skill already covers the capability, extend it, don't fork.

## Evaluation-driven authoring (do this order)

```
- [ ] 1 GAP     run the task WITHOUT a skill; note what context/steps were missing
- [ ] 2 EVALS   write >=3 concrete eval scenarios that capture those gaps (before docs!)
- [ ] 3 FRAME   one capability, one cell of the taxonomy; name it (gerund, [a-z0-9-])
- [ ] 4 DESCRIBE write the what+when description (third person, trigger keywords, <~200 chars)
- [ ] 5 BODY     minimal SKILL.md that passes the evals; assume the model is smart
- [ ] 6 SPLIT    move detail to references/examples; keep body <500 lines (composing-skills)
- [ ] 7 SUPPORT  generate templates/, checklists/, benchmarks/ as needed
- [ ] 8 PORT     apply the portability contract (capabilities not tool names; fwd slashes)
- [ ] 9 CHECK    self-review against the spec + best-practices (verifying-reasoning)
- [ ] 10 AUDIT   hand to auditing-skills for an independent score
```

Write evals **before** the body, it forces the skill to solve a real gap, not an imagined one.

## Frontmatter the factory emits (spec-exact)
```yaml
---
name: <dir name; [a-z0-9-]; <=64; gerund preferred; no claude/anthropic>
description: <what it does AND when to use it; third person; trigger keywords; <=1024>
license: <e.g. Apache-2.0>            # optional but recommended
metadata:                             # optional
  author: <...>
  version: "1.0"
  tier: "<0-4>"
  layer: <domain|meta>/<knowledge|procedure|tooling|control|quality>
compatibility: <only if real env requirements, keep honest>   # optional
# allowed-tools: <Space-separated, experimental: include only if needed>
---
```

## Body rules the factory enforces
1. **One responsibility.** If the description needs "and also," split into two skills.
2. **Concise; assume intelligence.** Only context the model lacks. Cut anything it knows.
3. **Open with "use this when / not when."** Drives correct activation (`docs/07`).
4. **Degrees of freedom matched to fragility:** high (text) for judgment tasks, low (exact
   script/command) for fragile/irreversible ones.
5. **Progressive disclosure:** body = table of contents; detail in references, one level deep.
6. **No time-sensitive info, consistent terms, concrete examples, forward-slash paths.**
7. **Scripts solve, don't punt; no magic constants; declare dependencies.**

## Portability contract (every emitted skill obeys)
- Reference **capabilities** ("read a file", "run the tests"), never specific tool names in
  required steps.
- Forward-slash paths only. Declare real requirements in `compatibility`; assume nothing else.
- Include a short **"Runtime adaptation"** section: the minimum mechanisms needed and the
  graceful fallback when richer ones (subagents, hooks, compaction) are absent.
- `allowed-tools` only when genuinely needed; treat as experimental.

## Output layout the factory produces
```
<name>/
├── SKILL.md
├── references.md        (depth, loaded on demand)
├── examples.md          (concrete input/output pairs)
├── templates/           (fill-in artifacts the skill uses)
├── checklists/          (gates the skill references)
└── benchmarks/          (>=3 eval scenarios + metrics, from step 2)
```
Use `templates/skill-skeleton/` as the starting structure and `templates/SKILL.md.tpl` for
the body.

## Runtime adaptation
- **Minimum:** filesystem write. Validate names with the spec rules (and `skills-ref
  validate` if available).
- The factory is itself portable: it emits plain files, no runtime-specific assumptions.

## Files
- `references.md`, the spec + best-practices distilled to authoring rules.
- `examples.md`, a capability turned into a full skill, start to finish.
- `templates/SKILL.md.tpl`, body template.
- `templates/skill-skeleton/`, the directory skeleton to copy.
- `checklists/authoring.md`, the pre-ship gate (mirrors Anthropic's checklist + portability).
- `benchmarks/`, does the generated skill pass its own evals & the audit?
