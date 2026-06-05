# Composition plan: <task>

```
TASK: <one sentence>

CAPABILITIES NEEDED:
  - <e.g. external research>
  - <e.g. multi-step planning>
  - <e.g. code change + verification>

CHOSEN SET (smallest covering, most specific):
  - <skill>, covers <need>, <why this one over alternatives>
  - <skill>, covers <need>
  DROPPED: <skill considered but not needed, why>

ORDER (tier N -> <=N; plan -> execute -> verify):
  1. <skill>  (load body at this phase)
  2. <skill>
  3. <skill>  (gate)
AMBIENT: context-budgeting (throughout)   WRAPPER: <operating-autonomously? y/n>

HAND-OFF: state passed via <ledger | direct> ; sub-agent for <bounded subtask?>
```

Monolith check: is any single chosen skill trying to do everything? If yes, you mis-routed.
