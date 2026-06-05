# Checklist: per iteration

Run every loop iteration. The loop is blind without this.

- [ ] OBSERVE: read current state / ledger NEXT ACTION.
- [ ] DECIDE: is the goal **DONE** (all criteria met + verified)? → stop.
- [ ] DECIDE: is it **blocked-hard** or past a **bound**? → stop / escalate.
- [ ] ACT: execute exactly **one** step.
- [ ] CHECK: did the step's outcome pass its check (`verifying-reasoning` if critical)?
- [ ] DETECT state:
  - [ ] **Progress?** record it, continue.
  - [ ] **Stuck?** (same error/action twice, NEXT ACTION unchanged) → recovery.
- [ ] If recovery: **diagnose first**, then **retry with a DIFFERENT strategy**; count the
      attempt (max 3 distinct).
- [ ] Did I avoid: repeating an identical failing action? unbounded looping? silent abandon?
- [ ] Update the ledger (write-through) so the run stays resumable.
