# Universal Skill Taxonomy

> A classification any developer can use to place, name, size, and compose skills -
> independent of runtime. The Fabric's own skills are the worked example.

## 1. The two-axis model

Every skill is located by **Layer × Function** (introduced in `03-capability-matrix.md`).

**Layer**, what the skill acts on:
- **Domain**, the user's task or external world (PDFs, a codebase, an API).
- **Meta**, the agent's own process (reasoning, context, planning, other skills).

**Function**, the kind of help:
- **Knowledge**, facts/schemas the model lacks. (Mostly `references/`.)
- **Procedure**, a repeatable method/workflow.
- **Tooling**, scripts/commands the agent executes.
- **Control**, *when/whether* to act: budgeting, looping, stopping, routing.
- **Quality**, verification, review, scoring.

A skill should occupy **one** primary cell. If it spans many, it is a candidate for
splitting (see `composing-skills`).

## 2. The five-tier capability stack

Skills also stack by *altitude*, how close to the metal they operate. Higher tiers
orchestrate lower ones.

```
Tier 4  META          authoring-skills, auditing-skills      (skills about skills)
Tier 3  ORCHESTRATION composing-skills, operating-autonomously (run many things)
Tier 2  PROCESS       decomposing-tasks, progressive-research,
                      sustained-execution, verifying-reasoning (how to work)
Tier 1  RESOURCE      context-budgeting                       (manage the substrate)
Tier 0  DOMAIN        guarding-code-quality, pdf-processing…  (do the task)
```

Rule of altitude: **a skill may reference skills at its own tier or below, never above.**
This keeps the dependency graph acyclic (see `06`).

## 3. Naming convention

- **Form:** gerund (`verb-ing`) for process/control/quality skills (`decomposing-tasks`),
  noun-phrase acceptable for pure knowledge/tooling (`code-style-rules`).
- **Constraints:** `[a-z0-9-]`, ≤64 chars, dir name == `name`, no reserved words
  (`claude`, `anthropic`).
- **Specificity:** name the *capability*, not the *domain noun*. `verifying-reasoning`
  not `checker`; `context-budgeting` not `tokens`.

## 4. Sizing rules (single responsibility)

| Signal a skill is too big | Action |
|---|---|
| SKILL.md > 500 lines / 5k tokens | Move detail to `references/`, split distinct jobs |
| Description needs "and also…" | Split into two skills |
| Two unrelated trigger contexts | Split; let routing pick |
| Activates but only 20% used most times | Split the hot path into its own skill |

| Signal a skill is too small | Action |
|---|---|
| Always co-activates with another | Merge or make one reference the other |
| Body < ~15 lines and no resources | Fold into the parent skill |

## 5. The Fabric taxonomy (placed)

| Skill | Layer/Function | Tier | One-line role |
|---|---|---|---|
| context-budgeting | Meta/Control | 1 | Spend the context window deliberately |
| progressive-research | Meta/Procedure | 2 | Find answers without flooding context |
| decomposing-tasks | Meta/Procedure | 2 | Turn a goal into a verifiable plan |
| sustained-execution | Meta/Control | 2 | Survive long runs via ledger + checkpoints |
| verifying-reasoning | Meta/Quality | 2 | Catch wrong answers before they ship |
| operating-autonomously | Meta/Control | 3 | Run unattended: progress, stop, recover |
| guarding-code-quality | Domain/Quality | 0 | Keep generated code correct & clean |
| composing-skills | Meta/Control | 3 | Chain skills without bloat |
| authoring-skills | Meta/Procedure | 4 | Generate new skills to spec |
| auditing-skills | Meta/Quality | 4 | Score & refactor existing skills |

## 6. Extensibility for other developers

To extend the Fabric, a developer:
1. Locates the new capability in the Layer×Function grid (avoid duplicating a filled cell).
2. Assigns a tier; confirms it only references same-or-lower tiers.
3. Names it per §3, sizes it per §4.
4. Generates it with `authoring-skills`, audits with `auditing-skills`.
5. Registers it in `skills/REGISTRY.md` and adds composition edges in `06`.

This taxonomy is intentionally runtime-neutral: nothing in it assumes Claude Code vs
Codex vs OpenClaw. It classifies *capabilities*, which are portable.
