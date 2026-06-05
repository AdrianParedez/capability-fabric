# Research Report: The Agent Skills Ecosystem (June 2026)

> Source of truth for the Capability Fabric project. Claims are grounded in primary
> documentation where cited in `docs/research/_sources.md`.
>
> Caveat: this is a snapshot from June 2026. Specific figures (tool counts, marketplace
> sizes) and third-party runtime behaviours come from public sources of varying authority
> and move quickly. Treat the numbers as directional and verify against the cited source
> before relying on them. The design conclusions do not depend on any single figure.

## 1. Executive summary

Between October 2025 and mid-2026 the "Agent Skill" went from an Anthropic feature to
an **open, multi-vendor standard**. A skill is now the lowest-friction way to give *any*
agent runtime new, portable, version-controlled capability. The defining property is
**progressive disclosure**: a skill costs ~100 tokens at rest (its `name` +
`description`) and only pays its full token price when the agent decides it is relevant.

This changes the economics of agent capability. Capability is no longer bought with a
bigger system prompt (which is paid on *every* turn); it is bought with a larger
*library* of cheap-at-rest skills that are loaded *just in time*. The strategic
opportunity, and the goal of this project, is to design skills that are not just
domain tools but **force multipliers on the agent itself**: skills that improve
reasoning, planning, research, cost, reliability, and long-horizon execution, and that
**compose** rather than collide.

## 2. The Agent Skills standard

### 2.1 Anatomy

A skill is a directory whose name matches the `name` field, containing at minimum a
`SKILL.md`:

```
skill-name/
├── SKILL.md          # Required: YAML frontmatter + Markdown body
├── scripts/          # Optional: executable code (run, not read)
├── references/       # Optional: docs loaded on demand
├── assets/           # Optional: templates, schemas, data
└── ...               # Anything else
```

### 2.2 Frontmatter (the open spec)

| Field | Req | Constraints |
|---|---|---|
| `name` | yes | ≤64 chars; `[a-z0-9-]`; no leading/trailing/consecutive hyphens; must equal directory name |
| `description` | yes | ≤1024 chars; non-empty; states **what it does AND when to use it**; third person |
| `license` | no | License name or bundled file reference |
| `compatibility` | no | ≤500 chars; environment requirements (product, packages, network) |
| `metadata` | no | Arbitrary `string→string` map; client-specific keys |
| `allowed-tools` | no | Space-separated pre-approved tools, e.g. `Bash(git:*) Read` (experimental) |

The body has **no format restrictions** but is fully loaded on activation, so it should
stay focused (<500 lines / <5k tokens recommended) and push detail into referenced files.

### 2.3 Progressive disclosure (the core mechanic)

Three tiers, each loaded only when justified:

1. **Discovery (~100 tok/skill):** `name` + `description` pre-loaded for *all* skills at
   startup. This is the only always-on cost.
2. **Activation (<5k tok):** full `SKILL.md` body, loaded when a task matches the
   description.
3. **Execution (as needed):** files under `references/`, `assets/`; `scripts/` are
   *executed* without their source entering context, only their stdout costs tokens.

**Design corollary:** the `description` is the single highest-leverage string in a
skill. It is the entire basis on which the agent decides to spend the activation budget.

## 3. Runtime landscape

The format was created at Anthropic, released as an open standard, and adopted broadly.
By mid-2026, 30+ tools read `SKILL.md`, including Claude Code, OpenAI Codex (CLI +
Desktop), Google Gemini CLI, GitHub Copilot / VS Code, Cursor, OpenCode, OpenHands,
Goose, Letta, Roo Code, Amp, Factory, Kiro, and many more. Community marketplaces
(SkillsMP, Skills.sh, ClawHub) collectively index hundreds of thousands of skills.

### 3.1 Runtime-specific facts that matter for portability

| Runtime | Skill discovery roots | Notable differences |
|---|---|---|
| **Claude Code** | `.claude/skills/` (project), `~/.claude/skills/` (personal), plugins | Honors `allowed-tools`; Read/Bash filesystem navigation; rich hook system |
| **Codex CLI / Desktop** | `.agents/skills` (cwd→repo root), `~/.agents/skills`, `/etc/codex/skills`, built-ins | Optional `agents/openai.yaml` for UI (`interface`, `policy`, `dependencies`); skill list capped at ~2% of context / ~8k chars; explicit (`$name`, `/skills`) + implicit invocation; duplicate names both shown, not merged |
| **Gemini CLI / Copilot / Cursor / OpenCode / others** | Tool-specific dirs; Cursor needs manual placement | All parse the same `SKILL.md`; vary in tool-call vocabulary and sandboxing |

### 3.2 Autonomous runtimes (OpenClaw, Hermes, swarmclaw)

- **OpenClaw**: self-hosted autonomous runtime built around a *plan-execute-reflect*
  loop and a persistent containerized sandbox (terminal, headless browser, filesystem).
  Works with any OpenAI-compatible endpoint; gateway-first positioning.
- **Hermes Agent**: Python framework centered on an `AIAgent` loop (`run_agent.py`)
  that interleaves reasoning, tool execution, **runtime skill creation**, and
  self-evaluation. Agent-first positioning; tuned for function-calling models.
- **swarmclaw**: multi-agent runtime: agent memory, MCP tools, schedules, delegation,
  23+ providers.

**Implication:** these runtimes value skills that encode *control-loop discipline*
(when to reflect, when to checkpoint, when to stop), exactly the meta-skills this
project targets. They also vary in tool vocabulary, which is why skills must be written
against **capabilities** ("read a file", "run a command") rather than specific tool names.

## 4. Context engineering (the deeper discipline skills plug into)

Skills are one instrument; context engineering is the orchestra. Established 2026 practice:

- **Context is a finite, degrading resource.** As context grows: requests get rejected,
  cost scales linearly, and quality degrades ("context rot"). Frontier models now sustain
  multi-hour tasks (METR: ~tens of hours at 80% reliability, doubling ~every 7 months),
  which makes context management the binding constraint, not raw capability.
- **Compaction:** summarize a near-full window into a high-fidelity digest and reinitiate.
  The critical lever for long-horizon runs; preserves flow at the cost of some fidelity.
- **Structured note-taking:** persist plans/decisions/results to external files (e.g.
  `NOTES.md`, a task ledger) and re-read on demand, memory that survives compaction.
- **Sub-agent isolation:** push wide, noisy exploration into sub-agents; return only
  conclusions to the lead agent. Keeps the lead context clean.
- **Just-in-time retrieval:** load identifiers/pointers, not payloads; fetch the payload
  only when needed. (Progressive disclosure *is* this principle applied to capability.)
- **Tool clearing:** drop stale tool outputs from context once consumed.

These five techniques are the conceptual backbone of the Fabric's reliability skills
(`sustained-execution`, `context-budgeting`, `operating-autonomously`).

## 5. Strategic reading

1. **The activation surface is the product.** With hundreds of skills installed, the
   bottleneck shifts from *having* a capability to the agent *selecting* it. Descriptions
   and a routing discipline are first-class engineering.
2. **Meta-skills are the highest leverage.** A skill that improves how the agent reasons,
   plans, or writes other skills multiplies the value of every domain skill.
3. **Composability beats monoliths.** A 2,000-line "do everything" skill defeats
   progressive disclosure. Small, single-responsibility skills that reference each other
   keep the resting cost flat while scaling capability.
4. **Model-agnosticism is achievable but not free.** Writing to capabilities (not tool
   names), avoiding runtime-specific assumptions, and declaring `compatibility` honestly
   are what make a skill portable across Claude Code, Codex, OpenClaw, Hermes, and beyond.

See `02-competitive-analysis.md` for who does what today, `03-capability-matrix.md` for
the coverage grid, and `04-gap-analysis.md` for where this project plants its flag.
