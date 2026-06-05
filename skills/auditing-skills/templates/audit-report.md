# Audit report: <skill name>: <date>

```
SPEC (R1, hard gate): <PASS | FAIL: reason>

SCORES (0-2):
  R2 description       : <n>
  R3 single-resp       : <n>
  R4 conciseness       : <n>
  R5 prog-disclosure   : <n>
  R6 activation-safety : <n>
  R7 portability       : <n>
  R8 examples          : <n>
  R9 testability       : <n>
  R10 safety/scripts   : <n>
  -------------------------------
  GRADE: <Σ>/20   VERDICT: <ship (>=16, R1 pass, no 0) | iterate>

TOP FINDINGS (by leverage, max 3):
  1. [R<#>] <issue>, evidence: <line/missing case>, fix: <concrete>
  2. ...

FIXES:
  applied: <list>            (RECHECK grade: <new Σ>/20)
  proposed (route to authoring-skills): <e.g. split into A, B>

EVALS: <present? pass after fix?>
```
Report the prioritized few, not every nit. Each finding cites evidence.
