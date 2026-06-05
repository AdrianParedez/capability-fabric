# Gap Analysis

> The specific, addressable gaps between the current ecosystem and the project's success
> criteria, and the design commitments each gap forces.

## 1. Method

For each gap: **Evidence** (from research) → **Impact** (why it blocks our success
criteria) → **Commitment** (what the Fabric does about it).

## 2. Gaps

### G1: No portable context/cost discipline
- **Evidence:** Progressive disclosure reduces *resting* cost, but nothing teaches an
  agent to budget the *active* window: when to summarize, offload, or refuse payload.
  Context rot and linear cost growth are documented but unpackaged.
- **Impact:** Blocks "reduce token consumption" and "improve reliability", long runs
  silently degrade.
- **Commitment:** `context-budgeting`, an explicit budget model, offload/compaction
  triggers, and a "load pointers not payloads" rule. Cross-referenced by most skills.

### G2: Research burns context
- **Evidence:** Search/fetch tools exist everywhere; no skill enforces *cheap* research
  (pointer-first, sub-agent isolation, extract-then-discard).
- **Impact:** Blocks "improve research quality" and "reduce cost" simultaneously -
  research is the #1 token sink in agent runs.
- **Commitment:** `progressive-research`, a tiered search→triage→extract→synthesize
  loop that keeps only conclusions in context.

### G3: Planning is a mode, not a method
- **Evidence:** Runtimes ship "plan mode" mechanisms; none ship a portable decomposition
  *rubric* (success criteria, unknowns-first, reversible-vs-one-way).
- **Impact:** Blocks "improve planning quality"; poor plans cascade into long-horizon
  failure.
- **Commitment:** `decomposing-tasks`, a method that produces a verifiable plan with
  explicit success criteria and risk-ordered steps.

### G4: Long-horizon technique is documented, not packaged
- **Evidence:** Compaction, structured note-taking, sub-agent isolation are *described*
  in context-engineering writing but not delivered as a reusable skill.
- **Impact:** Blocks "improve long-horizon execution" and "autonomous operation."
- **Commitment:** `sustained-execution`, an external task ledger + checkpoint + 
  compaction-survival protocol any runtime can follow.

### G5: Reasoning quality left to the model's mood
- **Evidence:** Beyond ad-hoc "think step by step," no portable skill enforces assumption
  surfacing, counter-evidence search, and answer verification.
- **Impact:** Blocks "improve response quality" and "reliability"; silent wrong answers
  are the costliest failure.
- **Commitment:** `verifying-reasoning`, a lightweight, on-demand verification rubric
  usable as a quality gate by other skills.

### G6: Autonomy lacks a stop/recovery policy
- **Evidence:** OpenClaw/Hermes loops execute indefinitely; *when to stop, when to ask,
  when to recover* is operator-defined and non-portable.
- **Impact:** Blocks "autonomous operation" and "reliability", runaway or prematurely
  stopping agents.
- **Commitment:** `operating-autonomously`, explicit progress/stuck/done detection,
  bounded retry-with-variation, and escalation criteria.

### G7: No composition discipline; monoliths defeat the standard
- **Evidence:** Marketplaces scale storage, not selection. Large "do-everything" skills
  reintroduce the system-prompt tax progressive disclosure was meant to remove.
- **Impact:** Blocks "scale to hundreds of skills" and "composability over monoliths."
- **Commitment:** `composing-skills`, single-responsibility sizing, reference-don't-inline
  rule, and an orchestration pattern for chaining skills; plus the routing/activation
  strategy in `docs/07`.

### G8: Skill quality is unmanaged at scale
- **Evidence:** Authoring guidance exists; *generation* and *auditing* of skills as
  repeatable, evaluable processes do not.
- **Impact:** Blocks "skills that improve other skills" and sustainable scale.
- **Commitment:** `authoring-skills` (generate to spec) + `auditing-skills` (score and
  refactor against a rubric), the meta-skills of Phase 4.

### G9: Portability is assumed, not engineered
- **Evidence:** Same `SKILL.md` parses everywhere, but skills routinely hard-code tool
  names, paths, and runtime assumptions, breaking on Codex/OpenClaw/Hermes.
- **Impact:** Blocks "model-agnostic across Claude Code, Codex CLI, Codex Desktop,
  OpenClaw, and future runtimes."
- **Commitment:** A **portability contract** (see `docs/07` §4) every Fabric skill obeys:
  write to capabilities not tool names, forward-slash paths, declare `compatibility`,
  degrade gracefully when a mechanism is absent.

## 3. Gap → success-criteria traceability

| Success criterion | Closed by |
|---|---|
| Reduce token consumption | G1, G2, G7 |
| Improve response quality | G5 |
| Improve planning quality | G3 |
| Improve code quality | G5, (G3) + `guarding-code-quality` |
| Improve research quality | G2 |
| Improve agent reliability | G1, G4, G5, G6 |
| Scale to hundreds of skills | G7, G8 |
| Model-agnostic across runtimes | G9 |

## 4. Non-goals (explicit scope fence)

- Not building domain catalogs (PDF/Excel/framework skills), crowded and off-thesis.
- Not building MCP integrations, capability lives in the server, not the skill.
- Not depending on any one runtime's proprietary features as a *requirement* (only as an
  *enhancement* when present).
