# Competitive Analysis: Existing Skills & Ecosystems

> What already exists, what it's good at, and where it leaves room. Scope: public skill
> catalogs and the meta-capability practices baked into agent runtimes as of June 2026.
>
> Caveat: tool counts, marketplace sizes, and named third-party runtimes are a June 2026
> snapshot from public sources of varying authority. Verify against `docs/research/_sources.md`
> before citing any specific number; the gap analysis holds regardless of the exact totals.

## 1. Categories of what's public today

| Category | Representative examples | Maturity | Strength | Limitation for our goal |
|---|---|---|---|---|
| **Document / file ops** | `pdf-processing`, `docx`, `xlsx`, `pptx` (Anthropic repo) | High | Battle-tested, script-backed, canonical authoring reference | Domain tools, not agent-improving |
| **Dev workflow** | commit-message, code-review, test-gen (Codex/Copilot catalogs) | High | Directly useful in coding loops | Thin; rarely encode reasoning discipline |
| **Framework-specific** | Laravel Boost, Android (Firebender), data (Databricks/Snowflake) | Med-High | Deep domain context | Locked to one stack/runtime |
| **Integrations** | BigQuery, GitHub, Slack, Jira skills (often MCP-backed) | Med | Connect agents to systems | Capability = the integration, not the agent |
| **Marketplace long-tail** | 100k+ on SkillsMP / Skills.sh / ClawHub | Low-Med | Breadth | Uneven quality, little composition design, descriptions noisy |
| **Meta / agent-improving** | sparse: a few "skill-creator", "planning" prompts | **Low** |, | **The gap this project targets** |

## 2. First-party authoring guidance (the de-facto competition for "how")

Anthropic's best-practices doc is the strongest existing artifact on *how* to build
skills. It establishes principles we adopt wholesale and treat as table stakes:

- Concise-is-key; assume the model is smart; justify every token.
- Degrees of freedom matched to task fragility (high/medium/low).
- Description must be third-person, specific, what+when.
- Progressive disclosure; references one level deep; ToC for long files.
- Evaluation-driven development (write evals before docs; ≥3 scenarios).
- "Claude A authors / Claude B uses" iteration loop.
- Anti-patterns: Windows paths, too many options, time-sensitive info, magic constants.

**What it does *not* provide:** ready-made, composable *meta-skills*; a cross-runtime
portability discipline; a routing/activation strategy for hundreds of skills; or
skills whose job is to improve *other* skills. That is open ground.

## 3. Runtime meta-capabilities (built in, not as skills)

| Runtime | Built-in meta-capability | Gap a skill can fill |
|---|---|---|
| Claude Code | Hooks, subagents, plan mode, memory dir, compaction | Discipline for *when/how* to use them is left to the model |
| Codex | `AGENTS.md` layering, implicit/explicit skill invocation, context cap | No portable reasoning/planning skills shipped |
| OpenClaw | plan-execute-reflect loop, sandbox | Loop is generic; no domain-agnostic reflection rubric |
| Hermes | runtime skill creation + self-eval loop | Skill *quality* not enforced; self-eval rubric ad hoc |
| swarmclaw | delegation, memory, schedules | Orchestration policy left to the operator |

The pattern: runtimes provide *mechanisms* (hooks, loops, memory, sub-agents) but not
*policy* (when to checkpoint, how to reflect, how to budget context, how to route). Policy
is portable and is exactly what a well-designed skill encodes.

## 4. Where existing skills under-deliver against our objectives

| Objective | State of the art | Verdict |
|---|---|---|
| Reduce tokens / cost | Implicit via progressive disclosure; no skill *teaches* budgeting | **Underserved** |
| Improve reasoning quality | Occasional "think step by step" prompts | **Underserved** |
| Improve planning | Plan modes exist; no portable planning rubric skill | **Underserved** |
| Improve research | Search tools exist; no token-disciplined research method | **Underserved** |
| Long-horizon execution | Compaction/notes documented as *technique*, not packaged | **Underserved** |
| Autonomous operation | Loops exist in runtimes; no portable stop/recovery policy | **Underserved** |
| Code quality | Many code-review skills | **Served (crowded)** |
| Compose skills | Essentially none | **Open** |
| Improve other skills | "skill-creator" exists thinly | **Open** |
| Scale to hundreds | Marketplaces scale *storage*, not *selection* | **Open** |

## 5. Conclusion

The market is saturated at the **domain-tool** layer and nearly empty at the
**agent-improving meta** layer. Competition for "a PDF skill" is fierce and pointless;
competition for "a skill that makes any agent budget its context, plan before acting,
research without burning tokens, and write better skills" barely exists. Capability
Fabric stakes its claim on that meta layer, and on the **composition + routing**
discipline needed to run hundreds of skills without context bloat.
