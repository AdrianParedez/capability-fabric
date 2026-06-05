# Change report: <what changed>

```
CHANGE: <one-line summary>
FILES:  <paths touched>
WHY:    <the requirement / bug this addresses>

FIT:    matched conventions: <error handling | naming | libs | test style>
        new pattern/dependency introduced? <none | <what> because <why>>

VERIFIED (ran & observed):
  - <test / app run / path> -> <result>
  - bug fix proof: failed as <X> before; passes after; suite <n/n> green

NOT VERIFIED (be explicit):
  - <path/env not exercised>

EDGES handled: <empty | null | error-path | boundary | n/a>

ASSUMPTIONS: <anything taken on faith, flag for confirmation>

VERDICT (verifying-reasoning): <confirmed | confirmed-with-caveats | needs-work>
```

Rule: nothing in VERIFIED unless you actually ran and observed it. Untested → NOT VERIFIED.
