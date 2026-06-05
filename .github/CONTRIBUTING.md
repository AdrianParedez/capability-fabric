# Contributing

Contributions are welcome. The library grows under the same discipline that built it:
small, single-purpose, portable skills that compose.

## Principles

- One responsibility per skill. If the description needs "and also," split it.
- Improve the agent's process, not a single domain.
- Name capabilities, never specific tools, so a skill runs on any runtime.
- Load names always, bodies on demand, files on use.
- Measure against a baseline. Ship targets as targets, not as results.

## Adding a skill

1. Place the capability in the taxonomy (`docs/design/05-skill-taxonomy.md`). Do not
   duplicate a filled cell; extend the existing skill instead.
2. Generate it with the `authoring-skills` skill: evals first, then a focused `SKILL.md`,
   then the supporting files.
3. Keep the shape consistent: `SKILL.md`, `references.md`, `examples.md`, `templates/`,
   `checklists/`, `benchmarks/`.
4. Score it with the `auditing-skills` skill. Ship at 16/20 or above, with spec validity
   passing and no rubric dimension at zero.
5. Register it: add a line to `skills/REGISTRY.md` and a dependency edge in
   `docs/design/06-dependency-graph.md` where it composes.

## Format rules

- `SKILL.md` frontmatter follows the Agent Skills spec: `name` is lowercase, hyphenated,
  64 characters or fewer, and equals the directory name; `description` is third person and
  states what the skill does and when to use it.
- Body under 500 lines. Push depth into `references/`, one level deep.
- Use forward-slash paths in repository documentation and examples.
- Validate changed skills before opening a pull request, where `skills-ref` is available.
  See the Agent Skills reference repository for installation and usage:
  https://github.com/agentskills/agentskills

  ```bash
  skills-ref validate ./skills/<name>
  ```

## Commits

Conventional Commits. Keep history clean and the subject in the imperative:

```
feat(<scope>): add the thing
fix(<scope>): correct the thing
docs: explain the thing
```

## Pull requests

Describe what changed and why, the skill's evals, and the audit score. State what you
verified and what you did not.

Use the pull request template and keep the checklist honest. If a check is not applicable,
say so in the PR.
