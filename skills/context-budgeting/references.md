# References: context-budgeting

## Contents
- The cost model (resting / active / marginal)
- The seven techniques
- Compaction: how to do it without losing fidelity
- Why context degrades ("context rot")
- Source material

## The cost model

| Cost | What it is | Paid | Scales with | Lever |
|---|---|---|---|---|
| Resting | name+description of installed skills | every turn | # installed skills | tight descriptions, registry/router |
| Active | loaded bodies + history + tool output | every turn until cleared | session length | compaction, offload, clearing |
| Marginal | tokens from one more action | once, then becomes active | size of each fetch/read | peek-before-read, pointers |

Asymmetry to remember: resting cost is small but permanent; active cost is large and
compounding. Spend your optimization effort on the active window.

## The seven techniques

1. **Progressive disclosure**, the standard's tiering: name → body → files. Free; always on.
2. **Pointer-first retrieval**, hold references, fetch payloads on use.
3. **Extract-then-discard**, distill needed facts, drop the source.
4. **Compaction**, summarize a near-full window into a digest and reinitialize.
5. **Structured note-taking**, persist plan/decisions/results to files; re-read on demand.
6. **Sub-agent isolation**, run noisy exploration elsewhere, return conclusions only.
7. **Tool-output clearing**, drop stale tool results after they're consumed.

## Compaction without losing fidelity

A good digest is *lossy on substrate, lossless on intent*. Preserve:
- Goal and success criteria, verbatim.
- The plan and the index of the current step.
- Open decisions with their *why* (constraints), not just the chosen option.
- Pointers to every offloaded artifact (paths/URLs/line ranges) so it's re-fetchable.
- The single most recent verified result.

Drop: raw tool output, completed-step detail, exploratory dead-ends (keep one line:
"tried X, rejected because Y"), and any reference text already distilled.

Always run `verifying-reasoning` on a critical result *before* it gets compacted, so you
never summarize away an unchecked error.

## Why context degrades

As the active window grows, models exhibit "context rot": earlier facts get less
attention weight, instructions blur, and error rate climbs, independent of hitting the
hard token limit. This is why budgeting targets a *working ceiling* (~75-80%) rather than
the raw limit, and why peak active context is a reliability metric, not just a cost one.

## Source material
- Anthropic, *Effective context engineering for AI agents*.
- Claude Cookbook, *Context engineering: memory, compaction, and tool clearing*.
- *Context as a Tool* (arXiv 2512.22087), *Memory as Action* (arXiv 2510.12635).
- Agent Skills spec, progressive disclosure tiers.
(Full URLs in `docs/research/_sources.md`.)
