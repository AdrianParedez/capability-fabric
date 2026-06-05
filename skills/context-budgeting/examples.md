# Examples: context-budgeting

## Example 1: Peek before you read

**Task:** "Where is the retry limit set in this service?"

**Bad (payload):**
```
Read src/client.py        # 1,900 lines -> ~14k tokens into context, used 4
```
**Good (pointer + peek):**
```
grep -n "MAX_RETRIES\|retry" src/        # -> client.py:212
Read src/client.py offset 200 limit 30   # ~250 tokens
```
Note kept in context: `retry limit = MAX_RETRIES=3 @ src/client.py:212`. The 1,900-line
file never entered the window.

## Example 2: Extract then discard

**Task:** summarize an API's auth flow from a 4k-line reference page.

- Fetch page → it's huge. Do **not** keep it.
- Extract: `auth = OAuth2 client-credentials; token URL /oauth/token; 1h expiry; scope=read:data`.
- Discard the page; keep the 4-line extract + the URL pointer.

Context held: ~40 tokens instead of ~30k.

## Example 3: Tool-output clearing

```
$ pytest -q                 # 600 lines of output
```
Instead of carrying 600 lines forward, collapse to:
`tests: 142 passed, 1 failed -> test_billing.py::test_proration (assert 0.5 != 0.33)`.
The one failing assertion is the only thing the next step needs.

## Example 4: Soft → hard ceiling on a long build

Session at ~55% (soft):
- Move completed steps 1-4 detail to `notes/ledger.md`, keep one-line outcomes + pointers.

Session at ~78% (hard):
1. Write `notes/digest-001.md` from `templates/digest.md`.
2. Reinitialize working context.
3. Reload: goal + success criteria + plan with step 5 active + `digest-001.md` + pointers.
4. Continue at step 5 with a near-empty, focused window.

Result: a 6-hour build that would have blown the window completes in one continuous run.

## Example 5: Protect the reasoning surface (anti-pattern avoided)

About to compact, and the most recent result is "migration script will drop column
`legacy_id`." **Don't** summarize it away unchecked. First run `verifying-reasoning`:
confirm nothing reads `legacy_id` → *then* record the verified decision in the digest.
Optimization never deletes an unverified critical claim.
