# Capability Matrix

> Maps the capability space of agent skills to coverage (public ecosystem) and to the
> Capability Fabric skills that address each cell. Legend: ●=well covered publicly,
> ◐=partial, ○=open/underserved.

## 1. Capability axes

We classify any agent skill along two axes:

- **Layer**, *what it acts on*: `Domain` (the task/world) vs `Meta` (the agent itself).
- **Function**, *what kind of help*: Knowledge, Procedure, Tooling, Control, or Quality.

```
                 Knowledge   Procedure   Tooling    Control     Quality
   Domain          ●            ●           ●          ◐           ●
   Meta            ○            ◐           ○          ○           ○
```

The public ecosystem is dense in the **Domain** row and sparse in the **Meta** row. The
Fabric is built almost entirely in the **Meta** row.

## 2. Capability → public coverage → Fabric skill

| # | Capability | Layer/Function | Public | Fabric skill |
|---|---|---|---|---|
| C1 | Token & context budgeting | Meta/Control | ○ | `context-budgeting` |
| C2 | Token-disciplined research | Meta/Procedure | ◐ | `progressive-research` |
| C3 | Task decomposition & planning | Meta/Procedure | ◐ | `decomposing-tasks` |
| C4 | Long-horizon execution (notes, checkpoints, compaction) | Meta/Control | ○ | `sustained-execution` |
| C5 | Reasoning verification (assumptions, self-check) | Meta/Quality | ○ | `verifying-reasoning` |
| C6 | Autonomous operation (loops, stop/recovery) | Meta/Control | ○ | `operating-autonomously` |
| C7 | Code-quality guardrails | Domain/Quality | ● | `guarding-code-quality` |
| C8 | Skill composition & orchestration | Meta/Control | ○ | `composing-skills` |
| C9 | Skill authoring/generation | Meta/Procedure | ◐ | `authoring-skills` (meta) |
| C10 | Skill auditing/improvement | Meta/Quality | ○ | `auditing-skills` (meta) |

## 3. Objective coverage matrix

Each Fabric skill mapped to the project's 10 design objectives (✓ primary, ·secondary).

| Skill ＼ Objective | Tok↓ | Reason↑ | Plan↑ | Research↑ | Code↑ | Reliab↑ | LongHz↑ | Auto↑ | Compose | ImproveSkills |
|---|---|---|---|---|---|---|---|---|---|---|
| context-budgeting | ✓ | · | · | · | | · | ✓ | · | · | |
| progressive-research | ✓ | · | | ✓ | | · | · | | · | |
| decomposing-tasks | · | ✓ | ✓ | · | · | ✓ | ✓ | · | · | |
| sustained-execution | ✓ | | · | | | ✓ | ✓ | ✓ | · | |
| verifying-reasoning | · | ✓ | · | ✓ | ✓ | ✓ | | · | | · |
| operating-autonomously | · | | · | | | ✓ | ✓ | ✓ | · | |
| guarding-code-quality | | · | | | ✓ | ✓ | | | | |
| composing-skills | ✓ | · | · | | | · | · | · | ✓ | ✓ |
| authoring-skills | ✓ | · | | | | · | | | ✓ | ✓ |
| auditing-skills | ✓ | · | | | · | ✓ | | | · | ✓ |

Every objective has at least two skills targeting it; no skill is single-purpose dead
weight. The **token-reduction** column is intentionally broad: nearly every meta-skill
pays for itself in saved context.

## 4. Composition density

Capabilities that frequently co-activate (drives the dependency graph in `06`):

- C3 `decomposing-tasks` → C4 `sustained-execution` → C6 `operating-autonomously`
  (the long-horizon spine).
- C2 `progressive-research` ↔ C1 `context-budgeting` (research is where tokens leak).
- C5 `verifying-reasoning` is a *cross-cutting* quality gate invoked by C3, C7, C9.
- C8 `composing-skills` + C9 `authoring-skills` + C10 `auditing-skills` form the
  **self-improvement triangle**, skills that operate on skills.

## 5. Reading the matrix

The matrix is the bridge between Phase 1 (what exists) and Phase 2 (what we build). It
shows the Fabric is not a random pile of skills but a **deliberately Meta-weighted set**
chosen to fill the empty row of the capability space, with built-in composition paths so
the skills reinforce each other instead of duplicating domain catalogs.
