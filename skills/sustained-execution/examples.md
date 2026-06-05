# Examples: sustained-execution

## Example 1: A multi-session build, end to end

**Goal:** migrate a service from REST to gRPC (long, multi-session).

**Session 1**, INIT ledger:
```
GOAL: service speaks gRPC; REST removed; clients migrated.
DONE WHEN: all 6 endpoints have gRPC equivalents w/ passing contract tests; REST deleted.
PLAN:
  [>] 1. Define .proto from existing REST contracts
  [ ] 2. Generate stubs + implement handlers
  [ ] 3. Port endpoints (6) w/ contract tests
  [ ] 4. Migrate clients
  [ ] 5. Remove REST  [ONE-WAY]
NEXT ACTION: write users.proto from /users REST contract
```
Work proceeds; after each endpoint, PLAN state + DECISIONS + NEXT ACTION updated.

**Context hits 78%** mid-step-3 → CHECKPOINT digest saved, pointer added, reinitialize,
reload goal + ledger. NEXT ACTION says "port /orders endpoint" → continue. No re-work.

**Session 2** (next day, fresh agent). Resume protocol: read ledger → NEXT ACTION =
"migrate billing client" → continue. The agent never re-derives the proto or re-decides
settled questions.

**Final**, step 5 is one-way (delete REST): gated on all contract tests green, verified,
confirmed, *then* recorded done. All DONE criteria checked → ledger closed.

## Example 2: Write-through saves a run

Agent implements handler, tests pass, but **before** recording, context auto-compacts.
Because the rule is write-through, the ledger was updated *as part of* finishing the step,
so post-compaction NEXT ACTION is correct. Had it been "record later," the agent would
redo a finished handler, or worse, skip it thinking it's done.

## Example 3: Idempotent resume on a one-way door

Step: "DROP TABLE temp_import [ONE-WAY]." Crash mid-step. Resume re-reads NEXT ACTION,
which includes the check: "if temp_import exists, drop it; else mark done." Re-running is
safe, no double-drop error, no skipped cleanup.

## Example 4: Anti-pattern

❌ Keeping all state in the chat window on a 4-hour task. At hour 3 the window compacts,
the summary drops which endpoints were ported, and the agent re-ports two and forgets one.
✅ The ledger's PLAN states make "what's done" durable and unambiguous.
