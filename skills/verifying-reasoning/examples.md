# Examples: verifying-reasoning

## Example 1: Catching a wrong code answer (test > argument)

**Claim:** "`parse_range('5-')` returns `[5, inf)`, the fix is correct."
- ASSUMPTIONS: open-ended ranges are supported; `-` always has a left bound.
- DISCONFIRM: what about `'-5'` (open *left*)? and `''`?
- TEST (don't argue, run it): `parse_range('')` → `IndexError`. **Refuted.**
- VERDICT: refuted, fix handles `'5-'` but crashes on empty/left-open. Next: handle both
  before shipping.

## Example 2: Catching a wrong research conclusion

**Claim:** "Runtime X merges duplicate-named skills." (from a tutorial)
- DISCONFIRM via primary source: X's own docs say duplicates *both appear, unmerged*.
- VERDICT: refuted, the tutorial was wrong/stale. Use the primary behavior.

## Example 3: Catching a broken plan

**Plan claim:** "Steps are independent; safe to run in any order."
- DISCONFIRM: step 4 (migrate clients) reads stubs generated in step 2. Reorder → step 4
  fails.
- VERDICT: confirmed-with-caveats → 4 depends on 2; enforce ordering.

## Example 4: Calibration (don't over-verify)

Task: rename a local variable in a function you just wrote and ran.
- Stakes: low, reversible. Quick-gate only: "does it still compile / pass the one test?"
  Yes → done. No full pass needed. Verification effort matched to stakes.

## Example 5: Answering the asked question (step 6)

**Asked:** "Is this change *safe to deploy on Friday*?" 
**Drafted answer:** "The change is correct.", correct, but not the question.
- ALIGN catches it: safety-to-deploy-Friday also needs rollback plan + low traffic +
  on-call. Re-answer the actual question.
