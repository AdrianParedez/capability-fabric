---
name: verifying-reasoning
description: A fast, on-demand check that catches wrong answers before they ship, surface assumptions, seek disconfirming evidence, and validate the result against the question. Use before committing to a high-stakes conclusion, an irreversible action, or a final answer. Invoked as a quality gate by decomposing-tasks, progressive-research, guarding-code-quality, and the meta-skills.
license: Apache-2.0
metadata:
  author: Adrian Paredez
  version: "1.0"
  tier: "2"
  layer: meta/quality
compatibility: Any runtime. Pure reasoning method; benefits from tool access to run an actual test when one exists.
---

# Verifying reasoning

The costliest failure is a confident wrong answer. This skill is a cheap, deliberate pass
that tries to *break* a conclusion before you rely on it. It has **no outgoing
dependencies**, any skill or tier can invoke it as a gate.

## Use this when
- About to ship a final answer, commit a fix, or take an irreversible action.
- A conclusion is load-bearing and being wrong is expensive.
- Sources disagreed, or the reasoning chain was long.
- **Skip** for low-stakes, trivially reversible steps, verification has a cost too. Match
  rigor to stakes.

## The check (run in order, stop early if it holds)

```
- [ ] 1 RESTATE the claim/result and the exact question it answers
- [ ] 2 ASSUMPTIONS list what must be true for it to hold; flag the shakiest
- [ ] 3 DISCONFIRM actively look for evidence/cases it's WRONG (not more support)
- [ ] 4 TEST       if a cheap objective check exists, run it (don't reason about it)
- [ ] 5 EDGE       check boundaries: empty/zero/max/null/concurrent/error paths
- [ ] 6 ALIGN      does the result actually answer the question asked (not a near-miss)?
- [ ] 7 VERDICT    confirmed | confirmed-with-caveats | refuted | unknown -> next step
```

## Principles

1. **Seek disconfirmation, not confirmation.** Finding three more reasons you're right is
   worthless; finding one case where you're wrong is everything. Ask "what would make this
   false?" and go look for it.
2. **Prefer a test over an argument.** If you can run the code, query the data, or check
   the doc, do that, an objective check beats any chain of reasoning. Reasoning is the
   fallback when no test exists.
3. **Name the assumptions.** Most wrong answers are right *given a false premise*. Surfacing
   premises is where errors hide.
4. **Check edges, not just the happy path.** Empty input, zero, max, null, off-by-one,
   concurrency, the error branch. Bugs and bad conclusions cluster at boundaries.
5. **Answer the asked question.** A correct answer to a slightly different question is a
   wrong answer. Re-read the actual ask.
6. **Calibrate effort to stakes.** A one-line sanity check for small things; the full pass
   for irreversible or high-impact ones. Verification is insurance, buy the right amount.
7. **State a verdict, not a vibe.** Output one of: confirmed / confirmed-with-caveats /
   refuted / unknown, and for anything but "confirmed," the next step.

## What "disconfirm" looks like
- Code: write/Find the input that breaks it; run the actual test; check the error path.
- Research: find a primary source that contradicts the claim; check the version/date.
- Plan: find the step ordering that causes the dependency to fail.
- Math/logic: plug in the boundary; check units; re-derive one step independently.

## Runtime adaptation
- **Minimum:** none for the reasoning pass. If a tool can run a real check, prefer it.
- This skill is deliberately tool-light so it works identically on Claude Code, Codex,
  OpenClaw, Hermes, etc. It is the portable quality primitive other skills call.

## Files
- `references.md`, failure taxonomy, disconfirmation techniques, calibration.
- `examples.md`, catching a wrong answer in code, research, and a plan.
- `templates/verification.md`, the check to fill in.
- `checklists/quick-gate.md`, the 60-second version for medium-stakes calls.
- `benchmarks/`, error-catch-rate method.
