# Verification: <claim/result id>

```
CLAIM      : <the result/conclusion being checked>
QUESTION   : <the exact question it must answer>
STAKES     : <low | medium | high/irreversible>   -> rigor: <quick | partial | full>

ASSUMPTIONS (must be true):
  - <assumption>, confidence <high/med/low>   <- shakiest flagged
DISCONFIRM (what would make it false; did I look?):
  - <counterexample/inversion tried> -> <result>
TEST (objective check if one exists):
  - <command/query/source> -> <actual output>
EDGES checked: <empty | 0 | max | null | error-path | concurrency | n/a>
ALIGN: does it answer THE question? <yes/no, if no, what's missing>

VERDICT: <confirmed | confirmed-with-caveats | refuted | unknown>
CAVEATS / NEXT: <...>
```
