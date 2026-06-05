# References: progressive-research

## Contents
- Source-quality hierarchy
- Recency & staleness
- Query crafting
- When to corroborate vs accept
- Source material

## Source-quality hierarchy (prefer top)
1. Primary spec / official docs / standard.
2. Source code / API definition itself.
3. Maintainer changelog / release notes.
4. Reputable reference (well-known docs sites, peer-reviewed).
5. Blog posts / tutorials / forum answers, useful for *orientation*, weak for *facts*.
6. LLM-generated summaries of the above, treat as a pointer, verify against 1-4.

A load-bearing fact should rest on tier 1-3. Tiers 4-6 can *lead* you there but shouldn't
be the final citation for anything you act on.

## Recency & staleness
- The web mixes versions and eras. Check dates; prefer the version that matches the user's
  environment. Note version explicitly in extracts (`as of vX.Y`).
- For fast-moving tools, a single search may surface 3 different "current" answers, that
  is a signal to corroborate, not to pick the first.

## Query crafting
- One precise query beats five vague ones. Put the distinguishing nouns/version/error
  string in the query.
- If results are off-target, change *terms*, not just rerun, add the domain, the version,
  or the exact error text.
- Use `allowed_domains`/site filters when you know the authoritative host.

## When to corroborate vs accept
| Claim type | Action |
|---|---|
| Stable, well-known | accept from one good source |
| Version-specific / API contract / numbers | corroborate ≥2 or read primary |
| Security / destructive / irreversible | corroborate primary + flag to verifying-reasoning |
| Contested across sources | present the disagreement, don't silently pick |

## Source material
- Anthropic, *Effective context engineering for AI agents* (sub-agent isolation, JIT retrieval).
- Multi-agent research patterns (lead/sub-agent separation of concerns).
(Full URLs in `docs/research/_sources.md`.)
