# References: guarding-code-quality

## Contents
- Fitting the codebase
- The bug-fix proof pattern
- Review focus areas (where defects hide)
- Honest reporting
- Source material

## Fitting the codebase
Before writing, gather (cheaply, via grep/peek, see context-budgeting):
- The nearest analogous function, copy its shape.
- Error handling convention (exceptions? result types? error codes?).
- Logging/observability pattern.
- Test framework + where tests live + naming.
- Formatter/linter config (match it so the diff is clean).
- Existing libraries for the job, reuse before adding a dependency.
Introducing a new pattern/library is a *decision* requiring justification, not a default.

## The bug-fix proof pattern
```
1. Reproduce: trigger the bug; capture the exact failing behavior/output.
2. (optional) Write a failing test that encodes the bug.
3. Fix minimally.
4. Re-run: the repro now passes; the rest of the suite still passes.
5. Report: "failed as <X> before; passes after; full suite green."
```
A fix without step 1 and 4 is unverified. This is `verifying-reasoning`'s "test > argument"
applied to code.

## Review focus areas (where defects hide)
- Off-by-one / boundary in loops and slices.
- Null/empty/missing-key handling on the path you touched.
- Error branch correctness (often untested).
- Async: missing await, unhandled rejection, race on shared state.
- Resource leaks (open files/connections not closed).
- Security: injection, unvalidated input, secrets in code/logs.
- Leftovers: debug prints, commented code, TODOs that should be done now.
- Wrong-variable / copy-paste errors (very common in generated code).

## Honest reporting
The report's job is to make the human's trust calibrated. Always separate:
- **Verified:** what you actually ran and observed.
- **Not verified:** paths you didn't exercise, environments you couldn't test.
- **Assumptions:** anything you took on faith.
Never let "looks correct" read as "tested correct."

## Source material
- Anthropic skill best practices: "solve don't punt", no voodoo constants, validation
  loops, verifiable intermediate outputs.
- Capability Fabric `verifying-reasoning` (test > argument; edges).
(Full URLs in `docs/research/_sources.md`.)
