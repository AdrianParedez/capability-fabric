# References: verifying-reasoning

## Contents
- Failure taxonomy (where wrong answers come from)
- Disconfirmation techniques
- Calibrating rigor to stakes
- Why test > argument
- Source material

## Failure taxonomy
| Failure | Signature | Catch with |
|---|---|---|
| False premise | answer correct *if* X, but X is false | step 2 assumptions |
| Wrong question | correct answer, different question | step 6 align |
| Happy-path-only | works on the example, breaks on edges | step 5 edges |
| Stale fact | true for an old version | research recency + step 2 |
| Overgeneralization | one case → universal claim | step 3 disconfirm |
| Confirmation bias | only sought supporting evidence | step 3 disconfirm |
| Unchecked composition | parts right, combination wrong | step 4 test the whole |

## Disconfirmation techniques
- **Inversion:** assume the conclusion is false; what must the world look like? Go check.
- **Counterexample hunt:** the single input/case/source that breaks it.
- **Independent re-derivation:** redo one critical step a *different* way; compare.
- **Steelman the alternative:** make the strongest case for the opposite answer.
- **Boundary substitution:** plug in 0, 1, empty, max, null, negative, duplicate.

## Calibrating rigor to stakes
```
stakes = impact_if_wrong × difficulty_to_reverse
low    -> one-line sanity check (quick-gate)
medium -> steps 1,2,5,6
high / irreversible -> full pass + an objective test if any exists
```
Over-verifying trivia wastes tokens; under-verifying an irreversible action is the
expensive mistake. The skill's value is *targeting* rigor, not maximizing it.

## Why test > argument
A reasoning chain can be internally consistent and externally wrong. An objective check
(run the test, query the data, read the primary source) samples reality directly. Whenever
a cheap real check exists, it dominates any amount of careful reasoning. Reserve pure
reasoning for claims you genuinely cannot test.

## Source material
- Anthropic context-engineering: plan-validate-execute, verifiable intermediate outputs,
  validator→fix→repeat feedback loops.
(Full URLs in `docs/research/_sources.md`.)
