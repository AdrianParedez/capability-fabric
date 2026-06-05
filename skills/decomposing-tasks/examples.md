# Examples: decomposing-tasks

## Example 1: Good plan (risk-ordered, testable)

**Goal:** "Add CSV export to the reports page."
```
GOAL: Users can download the current report as CSV.
DONE WHEN:
  - Clicking "Export CSV" downloads a file matching the on-screen rows.
  - Columns/headers match the table; encoding is UTF-8.
UNKNOWNS:
  - Does the report API expose raw rows or only rendered HTML? -> resolve by step 1
PLAN:
  1. Inspect report API response shape, outcome: confirmed raw rows available -
     [reversible], de-risks the whole approach.
  2. Add server endpoint /reports/:id/export.csv, outcome: returns valid CSV for 1 row -
     [reversible].
  3. Wire "Export CSV" button to endpoint, outcome: browser downloads file, [reversible].
  4. Match columns/encoding to table, outcome: diff vs on-screen rows = 0, [reversible].
RISKS: API may only return HTML -> step 1 checks this before any UI work.
```
Note: the riskiest unknown (data availability) is step 1, not an afterthought.

## Example 2: Bad plan (and the fix)

❌ "1. Build the UI button. 2. Style it. 3. Hook up export. 4. Get data."
Risk (data availability) is discovered *last*, after UI is built, maximal rework.
✅ Reorder: resolve data availability first (Example 1).

## Example 3: One-way door handling

**Goal:** "Clean up the users table, remove the deprecated `legacy_id` column."
```
DONE WHEN: column dropped; nothing reads it; rollback documented.
PLAN:
  1. grep codebase + check views/migrations for legacy_id reads, outcome: zero readers -
     [reversible]. MUST pass before step 3.
  2. Take/verify backup of users table, outcome: restorable snapshot, [reversible].
  3. DROP COLUMN legacy_id, outcome: column gone, app green, [ONE-WAY], gated on 1 & 2,
     verify with verifying-reasoning, confirm with user.
```
The destructive step is explicitly one-way, gated, and verified, not done casually.

## Example 4: Right altitude (grouping)

A 25-step migration → group into phases: *Audit → Backfill → Cutover → Cleanup*, each a
mini-plan. The top level stays 4 trackable phases; detail lives in each phase, loaded when
that phase is active (progressive disclosure for plans).
