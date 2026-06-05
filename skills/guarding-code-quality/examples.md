# Examples: guarding-code-quality

## Example 1: A verified bug fix (proves itself)

Report after fixing a date bug:
- Reproduced: `format_date('2026-03-09', tz='PT')` returned `03-08` (off by a day at DST).
- Wrote failing test `test_dst_boundary`.
- Fix: use UTC instant before formatting (matches existing `format_ts` convention).
- Re-ran: `test_dst_boundary` passes; full suite 143/143 green.
- Verdict (verifying-reasoning): confirmed, failed before, passes after, no regressions.

## Example 2: Fit the codebase (don't impose habits)

Task: add input validation. The repo uses a `Result[T, Error]` return pattern, not
exceptions.
- ❌ Throw `ValueError` (your habit), alien to the codebase.
- ✅ Return `Err(InvalidInput(...))` matching the neighboring functions. Diff reads native.

## Example 3: Honest partial report (gold)

"Implemented the CSV export endpoint. **Verified:** unit tests for row formatting pass; ran
the endpoint locally, downloaded a correct file for the seed dataset. **Not verified:**
behavior on datasets >100k rows (didn't have one); the scheduled-export cron path. 
**Assumption:** report API returns all rows in one page, confirm for large reports."
This calibrates trust precisely; the reader knows exactly what's safe.

## Example 4: Don't punt

❌ `def parse(x): return int(x)  # caller should handle bad input`
✅ Handle it where it occurs, per the project's pattern:
```
def parse(x):
    # IDs are numeric; non-numeric means a malformed upstream record -> skip, don't crash
    if not x.isdigit():
        log.warning("skipping malformed id %r", x); return None
    return int(x)
```

## Example 5: Anti-pattern

❌ Write 80 lines, never run them, reply "Done, the feature works." A leftover `print`,
an unhandled empty list, and a wrong variable ship to the user.
✅ Run the path, self-review the diff, report what was and wasn't verified.
