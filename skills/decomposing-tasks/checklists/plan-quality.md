# Checklist: plan quality (gate before executing)

- [ ] **DONE is defined** and every criterion is **testable** (pass/fail observable).
- [ ] All **blocking unknowns** are resolved by an early step, not assumed away.
- [ ] **Every step has a checkable outcome** (not "work on X").
- [ ] Steps are **ordered to surface risk early** (riskiest-cheap-to-test first).
- [ ] Each step marked **reversible or one-way**; one-way steps are **gated + verified**.
- [ ] Altitude is right: **3-9 steps**, or grouped into **phases** if more.
- [ ] Top 1-2 **risks named** with an early check/mitigation.
- [ ] The plan would let **a fresh agent** execute without re-deriving the goal.
- [ ] Plan **validated** (`verifying-reasoning`), no contradictory or impossible steps.
- [ ] Long run? **Handed off to `sustained-execution`** with the plan written to a file.
