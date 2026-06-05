# Skill Dependency Graph

> How Fabric skills reference and reinforce one another. "Depends on" here means *may
> invoke / hand off to / cite*, not a hard runtime import, skills must also work alone.

## 1. Directed graph (text form)

```
authoring-skills ─────────────┐  (Tier 4)
   │ generates                │ uses to score output
   ▼                          ▼
auditing-skills ◄──────► verifying-reasoning   (4 → 2 quality gate)
   │ audits all skills
   ▼
composing-skills ─────────────────────────────┐  (Tier 3)
   │ orchestrates                              │
   ├──► decomposing-tasks ──► sustained-execution ──► operating-autonomously
   │         │ (2)                  │ (2)                    │ (3)
   │         ▼                      ▼                        ▼
   │   verifying-reasoning    context-budgeting        context-budgeting
   │         (2 gate)              (1)                       (1)
   ├──► progressive-research ──► context-budgeting          │
   │         (2)                     (1)                     │
   └──► guarding-code-quality ──► verifying-reasoning        │
             (0)                        (2)                  │
                                                             ▼
                                                  (re-enters the spine on recovery)
```

## 2. Edge table (who references whom, and why)

| From | → To | Relationship | Why |
|---|---|---|---|
| decomposing-tasks | context-budgeting | uses | size the plan to the window |
| decomposing-tasks | verifying-reasoning | gate | validate the plan before executing |
| decomposing-tasks | sustained-execution | hands off | execute a long plan via ledger |
| sustained-execution | context-budgeting | uses | trigger compaction/offload |
| sustained-execution | operating-autonomously | hands off | unattended execution of the ledger |
| operating-autonomously | context-budgeting | uses | watch budget as a stop signal |
| operating-autonomously | sustained-execution | re-enters | resume from checkpoint after recovery |
| progressive-research | context-budgeting | uses | pointer-first, extract-then-discard |
| progressive-research | verifying-reasoning | gate | corroborate before trusting a source |
| guarding-code-quality | verifying-reasoning | gate | verify a fix actually fixes |
| composing-skills | (all Tier ≤2) | orchestrates | pick & sequence skills per task |
| authoring-skills | verifying-reasoning | gate | self-check generated skill |
| authoring-skills | composing-skills | uses | size/split new skills correctly |
| auditing-skills | verifying-reasoning | gate | justify each finding |
| auditing-skills | authoring-skills | feeds | hand refactors back to the generator |

## 3. Acyclicity invariant

Edges only point **down or sideways** in tier (Tier N → Tier ≤N). `verifying-reasoning`
(Tier 2) is the one widely-shared *sideways/up-referenced* node, it is a pure quality
gate with **no outgoing edges**, so it can be cited by any tier without creating a cycle.
`context-budgeting` (Tier 1) is the universal *down* sink. These two are the graph's
load-bearing leaves; keep them dependency-free.

## 4. Activation clusters

Real tasks light up *subgraphs*, not single skills:

- **"Research a topic and report"** → progressive-research + context-budgeting +
  verifying-reasoning.
- **"Build feature X over a long session"** → decomposing-tasks → sustained-execution →
  guarding-code-quality (+ context-budgeting throughout).
- **"Run this goal unattended"** → operating-autonomously wrapping the spine.
- **"Make me a new skill for Y"** → authoring-skills → composing-skills (sizing) →
  auditing-skills (score).

`composing-skills` is the entry point that recognizes which cluster a task needs, see
`07-activation-strategy.md`.

## 5. Failure isolation

Because edges are soft (hand-off, not import), removing any node degrades gracefully:
without `sustained-execution`, `decomposing-tasks` still yields a plan; without
`context-budgeting`, others still work but lose efficiency. No skill hard-fails another.
This is the composability guarantee that lets the set scale and be partially adopted.
