# References: auditing-skills

## Contents
- Rubric anchors (0 / 1 / 2 per dimension)
- Leverage ranking
- Library-scale auditing
- Source material

## Rubric anchors

**R1 Spec validity** (hard gate)
- 2: all frontmatter rules pass (name chars/length/dir-match; description ≤1024 non-empty).
- 0: any violation. (Blocks ship regardless of other scores.)

**R2 Description quality**
- 2: states what + when, third person, leading trigger keywords, distinct from neighbors.
- 1: has what+when but vague triggers or mild overlap with another skill.
- 0: vague ("helps with X"), first/second person, or collides with a sibling.

**R3 Single responsibility**
- 2: one capability; description has no "and also."
- 1: mostly one but a secondary concern leaks in.
- 0: monolith, multiple capabilities bundled.

**R4 Conciseness**
- 2: every section earns its tokens; assumes model intelligence.
- 1: some explanation of model-known facts.
- 0: verbose; teaches basics; padded.

**R5 Progressive disclosure**
- 2: body <500 lines; depth in references, one level deep; ToC on long files.
- 1: a bit long or one nested reference.
- 0: everything inline / deeply nested chains.

**R6 Activation safety**
- 2: "use when / not when" present; overlaps cross-linked.
- 1: partial guidance.
- 0: no activation guidance; will misfire.

**R7 Portability**
- 2: capabilities not tool names; fwd slashes; runtime-adaptation section; honest compatibility.
- 1: minor coupling or missing adaptation note.
- 0: hard-coded tool names/paths; breaks off its origin runtime.

**R8 Evidence/examples**
- 2: concrete examples incl. an anti-example; consistent terminology.
- 1: thin or abstract examples.
- 0: none, or inconsistent terms.

**R9 Testability**
- 2: ≥3 measurable evals; benchmark method present.
- 1: 1-2 evals or vague metrics.
- 0: none.

**R10 Safety/scripts**
- 2: scripts solve-don't-punt, no magic constants, deps declared; one-way ops gated.
- 1: minor lapses.
- 0: punts, magic constants, undeclared deps, ungated destructive ops. (n/a → score R10 as 2 if no scripts/risk.)

## Leverage ranking
Order fixes by `impact × reach`: a description fix (affects every activation) outranks a
wording tweak. Report the top 1-3, not all 20 micro-nits, an audit that overwhelms doesn't
get acted on.

## Library-scale auditing
- Run R1+R2 across all skills first (cheap, catches the activation-breakers).
- Track aggregate resting-cost (Σ description tokens) and flag overlap clusters
  (skills with colliding trigger words), feed to `composing-skills` registry decisions.
- Periodic re-audit after model upgrades (a skill over-explaining for an older model may
  now be redundant).

## Source material
- Agent Skills spec + Anthropic best-practices checklist (basis of R1-R10).
- Capability Fabric `docs/07` (activation) and `docs/08` (context) for R2/R5/R7 anchors.
(Full URLs in `docs/research/_sources.md`.)
