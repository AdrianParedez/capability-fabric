# References: sustained-execution

## Contents
- Ledger schema rationale
- Checkpoint cadence
- Crash/compaction safety
- Relationship to compaction & notes
- Source material

## Ledger schema rationale
Each section answers a resume question:
- GOAL/DONE, "what am I trying to achieve and how do I know I'm finished?"
- PLAN states, "what's done, what's active, what's left?"
- DECISIONS (with why), "why did past-me choose this? can I safely change it?"
- CHECKPOINTS, "where can I restart from cleanly?"
- ARTIFACTS, "what files/URLs does this run depend on or produce?"
- NEXT ACTION, "what exactly do I do right now?"

Omitting *why* from DECISIONS is the most common failure: future-you reverses a choice
without knowing the constraint that forced it, and reintroduces a solved bug.

## Checkpoint cadence
Checkpoint when **any** of:
- Context approaches the hard ceiling (~75-80%).
- A phase boundary is crossed (natural resume point).
- Before a one-way/destructive step (so you can resume *just before* it if it fails).
- Before a risky long-running operation.
Don't checkpoint every step, that's overhead. Checkpoint at meaningful, resumable seams.

## Crash/compaction safety
- **Write-through:** ledger update is part of the step, not a follow-up. Treat
  "did the work but didn't record it" as "didn't do it."
- **Idempotency:** re-running NEXT ACTION after a crash must be safe. For irreversible
  actions, record completion only after confirmation, and make the check ("does the
  column still exist?") part of resume so you don't double-apply.

## Relationship to compaction & notes
This skill operationalizes two context-engineering techniques (see `context-budgeting`):
structured note-taking (the ledger) and compaction (checkpoints). It is the *durable*
counterpart to the *in-window* budgeting that `context-budgeting` handles.

## Source material
- Anthropic, *Effective context engineering* (structured note-taking, NOTES.md pattern).
- *Memory as Action* (arXiv 2510.12635), autonomous context curation for long horizons.
- *Context as a Tool* (arXiv 2512.22087), context management for long SWE agents.
(Full URLs in `docs/research/_sources.md`.)
