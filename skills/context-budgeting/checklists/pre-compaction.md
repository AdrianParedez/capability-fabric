# Pre-compaction checklist

Run before summarizing/reinitializing a near-full window. Compaction is lossy, this
guards the irreducible core.

- [ ] Goal & success criteria captured **verbatim** in the digest.
- [ ] Current plan written with the **active step** marked.
- [ ] Every open decision recorded **with its why/constraint**, not just the choice.
- [ ] The most recent **critical result was verified** (`verifying-reasoning`) before it
      gets summarized.
- [ ] A **pointer exists for every offloaded artifact** (path / URL / line range).
- [ ] Rejected paths reduced to **one line each** ("tried X, rejected: Y").
- [ ] Raw tool output / finished-step detail / distilled references **dropped**.
- [ ] Digest saved to a file **before** reinitializing (so it survives the reset).
- [ ] After reload, working context contains **only** keep_always + digest + active step.
