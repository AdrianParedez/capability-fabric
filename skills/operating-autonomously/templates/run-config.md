# Autonomous run config: set BEFORE launching

```
GOAL: <one sentence, pulled from decomposing-tasks>
DONE WHEN (the ONLY finish line, don't exceed):
  - <testable criterion>
  - <testable criterion>

BOUNDS:
  attempts_per_subproblem : 3   (distinct strategies, not reruns)
  context_ceiling         : ~78% -> checkpoint + stop/yield
  turn_or_cost_cap        : <n turns / $budget>
  wall_clock (if scheduled): <per-run budget>

STOP IF (any):
  - all DONE criteria met + verified
  - blocked-hard (missing input/permission/resource)
  - budget/turn ceiling reached
  - recovery exhausted across the whole goal
  - next step is destructive beyond mandate / unsafely ambiguous

MANDATE (what I may do without asking):
  - <e.g. edit code, run tests, read repo>   NOT: <delete data, deploy, send, spend>

ESCALATE TO: <human / ledger note if none> , format: tried+blocker+decision+recommendation

STATE STORE: <ledger path | in-window (short runs only)>
```
