# References: authoring-skills

## Contents
- The spec (authoritative field rules)
- Best-practices distilled
- Description engineering
- Degrees of freedom
- Common authoring mistakes
- Source material

## The spec (authoritative field rules)
| Field | Req | Rule |
|---|---|---|
| name | yes | ≤64; `[a-z0-9-]`; no leading/trailing/consecutive hyphen; == dir name; not "claude"/"anthropic" |
| description | yes | ≤1024; non-empty; what + when; third person |
| license | no | name or bundled file ref |
| compatibility | no | ≤500; only if real env requirements |
| metadata | no | string→string map; namespaced keys |
| allowed-tools | no | space-separated; experimental; e.g. `Bash(git:*) Read` |

Body: no format rules, but loads wholly on activation → keep <500 lines / <5k tokens;
push detail to referenced files one level deep.

## Best-practices distilled (Anthropic)
- Concise is key; the context window is a public good; justify every token.
- Assume the model is smart, add only what it lacks.
- Match degrees of freedom to task fragility (high/medium/low).
- Workflows as numbered steps + a copyable checklist for complex ones.
- Feedback loops: validator → fix → repeat.
- Examples beat description for style-sensitive output.
- Anti-patterns: Windows paths; too many options; time-sensitive info; magic constants;
  deep nested references; vague descriptions; assuming tools installed.
- Build evals first (≥3); test across model sizes; iterate by observing real usage.

## Description engineering (the highest-leverage string)
- First clause carries trigger nouns/verbs. Third person. What it does AND when.
- Name the negative space when neighbors overlap ("for X instead, use Y").
- Keep ≤~200 chars where possible, resting cost is per-character × every turn.

## Degrees of freedom
| Freedom | Form | Use when |
|---|---|---|
| High | prose guidance | many valid approaches; judgment-driven |
| Medium | parameterized pseudocode/script | a preferred pattern with variation |
| Low | exact command/script, no options | fragile/irreversible; consistency critical |

## Common authoring mistakes (the factory prevents)
- Monolith (many jobs in one body) → split.
- Vague description → no/incorrect activation.
- Explaining what the model already knows → token waste.
- Tool-name coupling → breaks portability across runtimes.
- No evals → documents an imagined problem.

## Source material
- Agent Skills specification (agentskills.io/specification).
- Anthropic. Skill authoring best practices.
- Codex skills (discovery dirs, openai.yaml) for cross-runtime portability.
(Full URLs in `docs/research/_sources.md`.)
