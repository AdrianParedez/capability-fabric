# Checklist: resume protocol

Run on any fresh start: new session, post-compaction, or after interruption.

- [ ] Read the **ledger** file first, before doing anything else.
- [ ] Reload **GOAL + DONE** criteria (verbatim).
- [ ] Reload **PLAN states**, know exactly what's done vs pending.
- [ ] Load the **latest CHECKPOINT** digest (not older ones).
- [ ] Load **ARTIFACTS** pointers (don't re-create files that exist).
- [ ] Read **NEXT ACTION**, this is where you continue.
- [ ] Confirm NEXT ACTION is **still valid** (did an external thing change?). If a one-way
      step, run its **idempotency check** before acting.
- [ ] Do **not** re-explore solved sub-problems or re-decide logged DECISIONS.
- [ ] After continuing, resume **write-through** updates.
