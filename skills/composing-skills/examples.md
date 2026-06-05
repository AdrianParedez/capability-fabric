# Examples: composing-skills

## Example 1: Routing a multi-capability task

**Task:** "Find out how runtime X discovers skills, then update our docs to match."
- CLASSIFY: needs (a) external research, (b) a doc edit verified correct.
- MATCH: progressive-research (a); guarding-code-quality applies to the edit; 
  verifying-reasoning gates correctness.
- MINIMIZE: drop planning (trivial 2-step task). Set = {progressive-research,
  verifying-reasoning} + ambient context-budgeting.
- ORDER: progressive-research → make edit → verifying-reasoning.
- LOAD: research body now; verification body only when checking the edit.

## Example 2: The long build backbone

**Task:** "Implement OAuth across the service this week."
- Set (ordered): decomposing-tasks → sustained-execution → guarding-code-quality →
  verifying-reasoning, all under context-budgeting; wrapped by operating-autonomously if
  run unattended.
- Activation is sequential: plan body loads first; once the ledger exists, the planning
  body falls out and execution/code bodies load per phase. Never all five at once.

## Example 3: Anti-monolith refactor

Someone wrote `do-research-and-build.md` (700 lines): search + plan + code + verify in one
skill. 
- Smell: description says "researches AND plans AND builds AND verifies."
- Fix: delete it; route the same task through the four existing skills. Resting cost drops
  (700-line body no longer loads wholesale), each part is independently testable and reusable.

## Example 4: Registry-only specialist

100 skills installed; a rarely-used `migrating-postgres-to-aurora` lives registry-only.
- For a normal task it isn't in the resting menu (saves ~100 tokens × every turn).
- When a DB migration appears, the conductor reads REGISTRY.md, finds it, and activates it.
  Discovery on demand; resting cost stays O(hot set).

## Example 5: Overlap resolved by "when not to use"

Task could match `progressive-research` or `verifying-reasoning`. Their lines disambiguate:
research = *acquire* external info; verify = *check* a conclusion. The task ("is this
library still maintained?") needs both, chained: research to find signals → verify the
load-bearing claim. Not a competition; a sequence.
