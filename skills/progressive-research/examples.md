# Examples: progressive-research

## Example 1: Cheap lookup (Tier 1, don't escalate)

**Q:** "What's the frontmatter char limit for a skill `description`?"
- FRAME: a single number from the spec. Sufficient = the number + its source.
- SEARCH: `agent skills SKILL.md description max characters spec` → pointers.
- TRIAGE: the agentskills.io specification result is primary → open only that.
- EXTRACT: `description ≤ 1024 chars (spec)`. Discard page.
- STOP. No corroboration needed (stable, primary source). ~1 page opened.

## Example 2: Corroborate a version-specific claim

**Q:** "Does runtime X support the `allowed-tools` field?"
- Source A (blog): "yes, fully supported." → not load-bearing enough.
- CORROBORATE: open X's own docs → "experimental, partial." 
- SYNTHESIZE: "`allowed-tools` is experimental in X; support may vary (per X docs)."
  Flag as experimental rather than asserting "fully supported."

## Example 3: Wide survey via sub-agent isolation

**Q:** "Which of 30 agent runtimes read SKILL.md, and how do their discovery dirs differ?"
- This is broad → Tier 3. Delegate to a sub-agent: "survey runtime skill-discovery
  locations; return a table of runtime → dirs → quirks + source URLs. Do not return raw
  pages."
- Sub-agent reads 30 pages in *its* window; returns a 20-line table.
- Main window cost: ~20 lines instead of ~30 fetched pages.

## Example 4: Anti-pattern (what NOT to do)

❌ Search → open all 10 results → read each fully → 60k tokens in context → then start
thinking. 

✅ Search → triage to 2 → extract 6 facts → 400 tokens → answer. Same answer, 100× cheaper.

## Example 5: Bounded cycles, honest stop

After 3 refined queries the exact rate-limit number isn't published anywhere primary.
Don't spiral. Report: "Not documented publicly; observed values in community reports range
40-60/min (unverified). Recommend confirming via the provider dashboard or a probe."
