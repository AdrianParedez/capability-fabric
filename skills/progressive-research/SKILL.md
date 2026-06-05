---
name: progressive-research
description: Finds external information without flooding context, a tiered search, triage, extract, corroborate, synthesize loop. Use when answering needs web search, docs, or unfamiliar APIs/libraries. For breaking a task into steps use decomposing-tasks; for raw window management use context-budgeting.
license: Apache-2.0
metadata:
  author: Adrian Paredez
  version: "1.0"
  tier: "2"
  layer: meta/procedure
compatibility: Requires a web/search and fetch capability and filesystem read. Sub-agents enhance isolation but are not required.
---

# Progressive research

Research is the #1 token sink in agent runs. Spend tokens on *finding* and *deciding*,
not on *holding* sources. Default to the cheapest tier that answers the question.

## Use this when
- The answer needs information you don't already have: web, docs, an unfamiliar API.
- You're tempted to read many pages or fetch large references.
- **Do NOT** use for decomposing a task (`decomposing-tasks`) or pure window mechanics
  (`context-budgeting`), this is about *acquiring external knowledge cheaply*.

## The loop

```
- [ ] 1 FRAME   write the exact question + what a sufficient answer looks like
- [ ] 2 SEARCH  one good query; collect pointers (titles+URLs), not content
- [ ] 3 TRIAGE  rank pointers by likely payoff; pick the 1-2 best
- [ ] 4 EXTRACT open only those; pull the few facts that answer the question
- [ ] 5 CORROBORATE for any load-bearing claim, confirm with a 2nd independent source
- [ ] 6 SYNTHESIZE write the answer + cite pointers; discard the raw sources
- [ ] 7 STOP     enough to answer? stop. else refine the query (max 2-3 cycles)
```

## Rules

1. **Frame before you search.** A question you can't state precisely produces searches you
   can't triage. Define "sufficient answer" first, it's your stop condition.
2. **Pointers before payloads.** A search returns titles + URLs. Keep those; open pages
   only after triage. Never read 10 results, read the 1-2 that triage picks.
3. **Breadth via the index, not the window.** Skim many candidates at the pointer level;
   only the winners pay the fetch cost.
4. **Extract, don't archive.** From each opened source, distill the specific facts and a
   pointer back. Drop the page. (See `context-budgeting` extract-then-discard.)
5. **Corroborate load-bearing claims.** Anything you'll act on (a version number, an API
   contract, a security claim) needs ≥2 independent sources, or an explicit "unverified"
   flag. Hand contested claims to `verifying-reasoning`.
6. **Prefer primary sources.** Official docs / source code / specs over blog summaries;
   note recency (the web has stale answers).
7. **Bounded cycles.** Refine the query at most 2-3 times. If still unanswered, report
   what's known, what's not, and the best next step, don't spiral.

## Cheapest-tier-first

| Tier | When it suffices | Cost |
|---|---|---|
| 0 own knowledge | stable, well-known facts | ~0 |
| 1 single search → pointers | "what/where/which" lookups | low |
| 2 open 1-2 primary sources | need exact detail/contract | medium |
| 3 sub-agent deep dive | wide survey, many sources | high, isolate it |

Escalate only when the current tier can't meet "sufficient answer."

## Sub-agent isolation (when available)

For wide surveys, delegate to a sub-agent: it reads many sources in *its* window and
returns only the synthesized conclusion + pointers. Your main window stays clean. If no
sub-agents: do the survey, then aggressively extract+discard before continuing.

## Runtime adaptation
- **Minimum:** a search tool + a fetch tool + filesystem read.
- Reference capabilities ("search the web", "fetch a URL"), never specific tool names.
- If only fetch (no search): start from a known primary doc and follow its links at the
  pointer level.

## Files
- `references.md`, source-quality heuristics, recency, query crafting.
- `examples.md`, worked research traces (cheap vs expensive).
- `templates/research-log.md`, frame → pointers → extracts → answer.
- `templates/source-card.md`, one card per opened source.
- `checklists/before-trusting-a-source.md`, corroboration gate.
- `benchmarks/`, tokens-per-answer and accuracy method.
