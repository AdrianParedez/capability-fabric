# Checklist: authoring (pre-ship gate)

Mirrors Anthropic's checklist + the Fabric portability contract. All must pass.

## Spec compliance
- [ ] `name`: ≤64, `[a-z0-9-]`, no leading/trailing/consecutive hyphen, == directory name,
      no reserved words.
- [ ] `description`: ≤1024, non-empty, **what + when**, third person, trigger keywords.
- [ ] Optional fields used correctly (`compatibility` only if real requirements).

## Core quality
- [ ] Single responsibility, description has no "and also."
- [ ] Opens with "use this when / not when."
- [ ] Concise, no explaining what the model already knows.
- [ ] Body <500 lines; detail in references, **one level deep**.
- [ ] Degrees of freedom matched to task fragility.
- [ ] Examples concrete (incl. an anti-example); consistent terminology.
- [ ] No time-sensitive info (or quarantined in an "old patterns" section).
- [ ] Workflows have clear steps; complex ones have a copyable checklist.

## Portability
- [ ] References **capabilities**, not specific tool names, in required steps.
- [ ] Forward-slash paths everywhere.
- [ ] "Runtime adaptation" section present (minimum + fallbacks).
- [ ] `allowed-tools` only if needed; treated as experimental.

## Code/scripts (if any)
- [ ] Scripts solve, don't punt; explicit error handling; no magic constants.
- [ ] Dependencies declared; not assumed installed.

## Testing
- [ ] ≥3 eval scenarios written (before the body) and present in benchmarks/.
- [ ] Self-checked with `verifying-reasoning`.
- [ ] Handed to `auditing-skills` for an independent score.
