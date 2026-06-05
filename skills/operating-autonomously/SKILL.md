---
name: operating-autonomously
description: Runs a goal unattended with a disciplined progress / stuck / done loop, bounded retry-with-variation, and clear stop and escalation criteria. Use for long unattended runs, background jobs, or any "keep going until done" task. Wraps the decomposing-tasks -> sustained-execution spine and watches context-budgeting limits as a stop signal.
license: Apache-2.0
metadata:
  author: Adrian Paredez
  version: "1.0"
  tier: "3"
  layer: meta/control
compatibility: Any runtime capable of a multi-step loop. Benefits from filesystem (ledger) and scheduling, but degrades to a single-session loop without them.
---

# Operating autonomously

Autonomy is not "loop forever", it is knowing **when to continue, when to stop, when to
recover, and when to ask**. An agent without stop/recovery discipline either spins
uselessly or quits early. This skill supplies the control policy runtimes leave to you.

## Use this when
- A goal must run unattended ("work until done," background/scheduled jobs).
- The loop could get stuck, loop, or run away.
- **Skip** for interactive, step-by-step work where the user is in the loop anyway.

## The control loop

```
loop:
  - [ ] OBSERVE  read ledger/state: what's done, what's the NEXT ACTION
  - [ ] DECIDE   is the goal DONE? is it BLOCKED? else pick the next step
  - [ ] ACT      execute one step
  - [ ] CHECK    verify the step's outcome (verifying-reasoning for critical)
  - [ ] DETECT   progress made? stuck? done? -> branch
        progress -> record, continue
        stuck    -> recovery protocol (below)
        done     -> STOP cleanly
        budget/turn ceiling hit -> checkpoint + STOP or hand back
```

## Three states to detect each iteration

1. **PROGRESS**, the step changed state toward DONE (a criterion got closer, a check
   passed). Record it (ledger) and continue.
2. **STUCK**, no forward movement: same error twice, repeating the same action, or a
   check that won't pass. Enter recovery. Stuck is *normal*; not detecting it is the bug.
3. **DONE**, all DONE criteria from the plan are satisfied **and verified**. Stop. Don't
   gold-plate past the criteria.

## Recovery protocol (bounded)

```
on STUCK:
  1. Diagnose: read the actual error/output; name the cause (don't retry blindly).
  2. Retry WITH VARIATION: change the approach, not just rerun the same thing.
  3. Bound it: max N attempts (default 3) per sub-problem, with DIFFERENT strategies.
  4. If still stuck after N: de-scope (do the part you can) OR escalate (below).
  5. Never: repeat an identical failing action; loop on it; or silently abandon the goal.
```

## Stop criteria (any one → stop)

- **DONE:** all criteria met and verified.
- **Blocked-hard:** a required input/permission/resource is missing and can't be obtained.
- **Budget ceiling:** context hard ceiling or a turn/cost cap reached → checkpoint, stop.
- **No-progress:** recovery exhausted (N varied attempts) across the *whole* goal.
- **Out-of-scope/unsafe:** the next step is destructive/irreversible beyond the granted
  mandate, or ambiguous in a way that risks harm.

## Escalation (when to ask a human)

Ask, don't guess, when: an irreversible/one-way action exceeds the mandate; requirements
are genuinely ambiguous and wrong guesses are costly; credentials/permissions are needed;
or recovery is exhausted. Escalate with: what you tried, why you're stuck, the specific
decision needed, and your recommended option. Make the human's decision a one-click choice.

## Principles
1. **Every iteration must detect progress/stuck/done**, the loop is blind without it.
2. **Retry with variation, never repetition.** Same action, same result.
3. **Bound everything**, attempts, budget, scope. Unbounded loops are the core failure.
4. **Stop at DONE; don't gold-plate.** The plan's criteria are the finish line.
5. **Escalate with a decision, not a dump.** Hand back a choice, not your confusion.
6. **Leave a resumable trail** (ledger) so a human or a later run can take over.

## Runtime adaptation
- **Minimum:** a step loop. Use `sustained-execution`'s ledger for state if filesystem
  exists; else keep state in-window and stop before the window fills.
- **OpenClaw/Hermes (native loops):** this skill is the *policy* for their plan-execute-
  reflect / self-eval loop, plug the states and bounds into their cycle.
- **Scheduled/background runtimes:** STOP can mean "checkpoint and yield to next run";
  resume via `sustained-execution`.
- If no human is reachable, "escalate" → record the blocked decision in the ledger and stop.

## Files
- `references.md`, loop detection, retry-variation, escalation design.
- `examples.md`, a run that recovers, one that stops, one that escalates.
- `templates/run-config.md`, bounds & stop criteria to set before launching.
- `checklists/iteration.md`, per-iteration loop checklist.
- `benchmarks/`, autonomy success & runaway-prevention method.
