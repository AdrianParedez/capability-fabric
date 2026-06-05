<!-- BEGIN capability-fabric (auto-managed by install/install.ps1 and install/install.sh, edit the repo copy, not this block) -->
## Capability Fabric: skill routing (installed)

You have the **Capability Fabric** skill library installed (10 agent-improving skills).
For any non-trivial request, route *before* acting.

**If there is even a 1% chance a skill applies, invoke it.** An invoked skill that does not
fit costs nothing to set aside; skipping one that fits is the expensive mistake.

1. **Identify** the capabilities the task needs (research? planning? code? verification?).
2. **Activate the smallest matching set** by skill description; for >1, use `composing-skills`
   to sequence them (tier N may call tier ≤N, never above).
3. **Default routes:**
   - needs external info → `progressive-research` → `verifying-reasoning`
   - multi-step / ambiguous → `decomposing-tasks` → `sustained-execution` (if long) →
     `guarding-code-quality` (for code) → `verifying-reasoning`
   - run unattended / "until done" → `operating-autonomously` (wraps the above)
   - create or improve a skill → `authoring-skills` / `auditing-skills`
   - **always ambient:** `context-budgeting`
4. **Match rigor to stakes**; verify before any irreversible action; report what was and
   wasn't verified.

Full index: `skills/REGISTRY.md`. Don't reinvent these behaviors inline, route to the skill.
<!-- END capability-fabric -->
