# Context Optimization Strategy

> The cross-cutting token/context discipline the whole Fabric is built to enforce. This
> document is the rationale; `skills/context-budgeting/` is the operational skill.

## 1. The cost model

Three quantities to minimize, in priority order:

1. **Resting cost**, Σ(name+description) of installed skills, paid every turn. Linear in
   skill count. → kept flat by tight descriptions + the registry/router pattern (`07`).
2. **Active cost**, tokens of loaded SKILL.md bodies + conversation + tool outputs, paid
   every turn until cleared. The dominant cost in long runs; grows monotonically unless
   managed. → managed by compaction, offload, tool-clearing.
3. **Marginal cost**, tokens added by one more action (a fetch, a file read). → minimized
   by pointer-first retrieval and `head`/grep-before-read.

Key asymmetry: **resting cost is small but permanent; active cost is large and
compounding.** Optimization effort should follow that, most leverage is in controlling
the active window over a long session.

## 2. Seven techniques (and which skill owns each)

| # | Technique | Mechanism | Owned by |
|---|---|---|---|
| T1 | Progressive disclosure | Load name→body→files in tiers | the standard + every skill |
| T2 | Pointer-first retrieval | Load IDs/paths/links, fetch payload only on use | progressive-research, context-budgeting |
| T3 | Extract-then-discard | Pull the 3 needed lines from a doc; drop the doc | progressive-research |
| T4 | Compaction | Summarize near-full window into a digest, restart | sustained-execution, context-budgeting |
| T5 | Structured note-taking | Persist plan/decisions/results to files; re-read on demand | sustained-execution |
| T6 | Sub-agent isolation | Run wide/noisy work in a sub-agent; return conclusions only | composing-skills, progressive-research |
| T7 | Tool-output clearing | Drop stale tool results once consumed | context-budgeting |

## 3. The budget protocol (portable, runtime-agnostic)

A simple state any agent can maintain in reasoning or a note file:

```
BUDGET
  window_limit:   <model context size>
  soft_ceiling:   ~50-60% of limit  → start offloading detail to files
  hard_ceiling:   ~75-80% of limit  → compact now
  keep_always:    goal, current plan step, open decisions, success criteria
  offload_first:  raw tool output, completed steps, reference dumps, long logs
```

Triggers:
- Approaching **soft ceiling** → apply T2/T3/T5: move payloads to files, keep pointers.
- Approaching **hard ceiling** → apply T4: write a checkpoint digest, reinitialize, reload
  only `keep_always` + the digest.
- After any large tool output is consumed → apply T7.

## 4. What to *never* drop

Compaction is lossy; protect the irreducible core:
- The **goal / success criteria** (verbatim).
- The **current plan and which step is active** (from `decomposing-tasks`).
- **Open decisions and their constraints** (why, not just what).
- **Pointers** to offloaded material (so it can be re-fetched).

Everything else is reconstructable and therefore offloadable.

## 5. Measuring optimization

Per-skill `benchmarks/` track, against a baseline run without the skill:
- **Tokens-to-completion** for a representative task (primary cost metric).
- **Peak active context** (reliability proxy, lower = less rot).
- **Re-read rate** (how often offloaded material is pulled back, too high means
  over-aggressive offload).

Target framing (illustrative, validate per environment): a well-budgeted long run should
hold **peak active context below the hard ceiling indefinitely** and complete a fixed task
in **fewer total tokens** than an unmanaged run, with equal or better output quality.

## 6. Interaction with quality

Optimization must not starve reasoning. The guardrail: optimize the *substrate* (raw
dumps, logs, finished steps), never the *reasoning surface* (goal, plan, open questions,
verification of the current step). `verifying-reasoning` runs *before* compaction on
critical results so nothing important is summarized away unchecked.

This strategy is implemented operationally by `context-budgeting` and consumed by
`progressive-research`, `sustained-execution`, and `operating-autonomously`.
