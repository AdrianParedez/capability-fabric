# Examples: operating-autonomously

## Example 1: Recovers via variation, then succeeds

Goal: get the test suite green.
- Iter 1: run tests → 3 fail (import error). PROGRESS (diagnosed).
- Iter 2: fix import → 1 fail (assertion). PROGRESS.
- Iter 3: tweak assertion expectation → still fails, same way. STUCK (same error).
- Recovery: *diagnose* instead of retrying, the test expects rounding the code doesn't do.
  Strategy change: fix the *code's* rounding, not the test. → passes. PROGRESS.
- Iter 4: all green, verified. DONE → stop. (Did not keep "improving" past green.)

## Example 2: Stops at a hard block (no runaway)

Goal: deploy to staging. Step needs `STAGING_TOKEN`, not present and not obtainable.
- DETECT: blocked-hard (required resource missing).
- Recovery can't manufacture a secret → STOP. Ledger records: "blocked: missing
  STAGING_TOKEN; all prior steps done; resume after token provided." No spinning.

## Example 3: Escalates with a decision

Goal: clean up DB. Next step drops a column (irreversible, beyond mandate).
- Detected one-way + out-of-mandate → escalate, not guess:
  "Ready to DROP `legacy_id` (0 readers found, backup taken). Irreversible & beyond my
  granted scope. Recommend proceeding. Approve? [proceed / skip / take backup first]."
- Loop pauses at a single decision, fully prepped, human answers in one click.

## Example 4: Runaway prevented by bounds

Goal: optimize a function. The agent could tweak forever.
- Bound: stop when the benchmark meets target OR 3 distinct strategies tried.
- Strategy 1 (memoize) hits target → DONE. Stops. Without the bound it would gold-plate
  indefinitely, burning budget for no required gain.

## Example 5: Anti-pattern

❌ Tests fail → rerun identical command 9 times hoping it changes → context fills → quits
with no progress and no record.
✅ Two identical failures = STUCK → diagnose → vary strategy → bound at 3 → escalate/record.
