# Examples: authoring-skills

## Example: capability → full skill, start to finish

**Request:** "Make a skill that helps the agent write good git commit messages."

**1 GAP (run without a skill):** agent writes vague one-liners, ignores the repo's
`type(scope):` convention, sometimes dumps the diff into the message.

**2 EVALS (before docs):**
- `bench-convention`: staged a feat change → expect `feat(scope): ...` + body. 
- `bench-bugfix`: staged a fix → expect `fix(...)` + what/why.
- `bench-noise`: large diff → message summarizes intent, doesn't paste the diff.

**3 FRAME:** one capability (commit-message writing); taxonomy Domain/Procedure, tier 0.
Name: `writing-commit-messages` (gerund, valid chars).

**4 DESCRIBE:**
`Writes conventional, descriptive git commit messages by analyzing staged changes. Use
when committing or when the user asks for a commit message. Follows the repo's existing
commit style.`  (third person, what+when, trigger words, <200 chars).

**5 BODY (minimal, passes evals):** read the repo's recent log for the convention → infer
type/scope from the diff → subject ≤50 chars imperative → body = what & why, wrapped →
never paste raw diff. (No explanation of "what git is", model knows.)

**6 SPLIT:** examples of input-diff → output-message go to `examples.md`; the convention
heuristics to `references.md`. Body stays short.

**7 SUPPORT:** `templates/commit.tpl`, `checklists/before-commit.md`,
`benchmarks/README.md` (the 3 evals + a quality rubric).

**8 PORT:** "run `git diff --staged`" framed as a capability; forward-slash paths;
`compatibility: requires git`. Runtime-adaptation note: if it can't run git, ask for the
diff.

**9 CHECK (verifying-reasoning):** description distinct from neighbors? body <500 lines?
no time-sensitive info? evals cover the gaps?, confirmed.

**10 AUDIT:** hand to `auditing-skills` → score ≥ threshold or iterate.

Result: a spec-compliant, portable skill that solves the *observed* gap, with its own evals.

## Anti-example
Asked for "a skill for working with our backend." Too broad → would become a monolith.
The factory refuses the frame: split into specific capabilities (e.g. `querying-our-db`,
`calling-our-api`) each with its own narrow description, and compose them.
