# Checklist: self-review the diff (before claiming done)

Read your own change as a hostile reviewer.

## Correctness
- [ ] Does it actually meet the requirement (re-read the ask)?
- [ ] **Ran** the changed path / test / app, observed it work (not assumed)?
- [ ] Bug fix: reproduced the failure first, and confirmed it's gone after?
- [ ] Edges on the touched path handled: empty / null / boundary / error branch?
- [ ] No wrong-variable / copy-paste error / missing await?

## Fit & cleanliness
- [ ] Matches neighboring conventions (naming, errors, libs, format)?
- [ ] Smallest change that works, no unasked refactor / abstraction?
- [ ] No new dependency/pattern without a stated reason?
- [ ] No magic numbers (constants justified) and no leftover debug prints / dead code / TODOs?

## Safety
- [ ] Input validated where it enters; no injection / unsafe eval?
- [ ] No secrets in code or logs?
- [ ] Irreversible/destructive operations gated and verified (see decomposing-tasks)?

## Honesty
- [ ] Report separates **verified** from **not verified** from **assumptions**?
- [ ] No "done" claim on anything I didn't actually run?
