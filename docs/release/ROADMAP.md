# Roadmap

Capability Fabric is experimental, but it is intended to be maintained with discipline.
This roadmap describes the current lane, not a promise of dates.

## Current lane

- Prepare the repository for public release.
- Keep the 10-skill core small, portable, and validated.
- Preserve the tiered routing model and acyclic dependency graph.
- Keep installers idempotent and reversible.

## Next

- Publish the repository publicly once launch checks are complete.
- Add CI for skill validation and installer syntax checks.
- Add release packaging notes for plugin distribution.
- Add examples showing multi-skill routing in realistic tasks.
- Add a small compatibility matrix for supported agent runtimes.

## Later

- Add rare, registry-only specialist skills without increasing resting context cost.
- Add benchmark fixtures that measure method quality without inventing results.
- Add release automation once the public workflow stabilizes.
- Consider a public skill catalog submission path.

## Non-goals

- Do not turn the library into one monolithic agent prompt.
- Do not make skills depend on a single runtime.
- Do not claim benchmark results without measured evidence.
- Do not add broad domain skills that duplicate existing specialist collections.
