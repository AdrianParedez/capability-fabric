# AGENTS.md

Guidance for AI coding agents maintaining this repository.

## What this is

Capability Fabric is a model-agnostic library of agent-improving Agent Skills. The skills
are the product. The research and design rationale live in `docs/`.

## Repository map

- `skills/<name>/` contains each skill, with `SKILL.md`, `references.md`, `examples.md`,
  `templates/`, `checklists/`, and `benchmarks/`.
- `skills/REGISTRY.md` is the discovery index and default routing map.
- `docs/research/` contains research documents and citations.
- `docs/design/` contains taxonomy, dependency graph, activation strategy, and context
  design.
- `docs/release/` contains changelog and roadmap.
- `install/install.ps1` and `install/install.sh` install or remove the skill library.
- `install/routing-directive.md` is the routing block injected into agent configuration.
- `.claude-plugin/` contains Claude Code plugin manifests.
- `.github/` contains issue and pull request templates.
- `.github/CONTRIBUTING.md`, `.github/SECURITY.md`, and `.github/CODE_OF_CONDUCT.md` are
  public governance files.
- `docs/release/CHANGELOG.md` and `docs/release/ROADMAP.md` record release history and
  planned work.

## Project conventions

- Use forward-slash paths in repository documentation and examples.
- Keep skills portable. Required steps should name capabilities, not one specific agent
  runtime or tool.
- Every `SKILL.md` must include a "Runtime adaptation" section.
- Frontmatter must follow the Agent Skills spec:
  - `name` is lowercase, hyphenated, 64 characters or fewer, and matches the directory.
  - `description` is third person, 1024 characters or fewer, and says what the skill does
    and when to use it.
- Keep each `SKILL.md` under 500 lines. Move depth into supporting files.
- Benchmarks describe methods and targets. Do not invent executed results.
- Keep routing block markers intact:

```text
<!-- BEGIN capability-fabric ... -->
<!-- END capability-fabric -->
```

## Changing or adding a skill

Follow `.github/CONTRIBUTING.md` for the canonical contributor workflow.

Agent-specific reminders:

- Check `docs/design/05-skill-taxonomy.md` before creating a new skill.
- Keep the six-part skill shape intact.
- Update `skills/REGISTRY.md` and `docs/design/06-dependency-graph.md` together.
- Keep tiers acyclic. A skill may reference its own tier or a lower tier, never a higher
  tier.

## Test and install

Install into every detected agent:

```powershell
./install/install.ps1
```

```bash
./install/install.sh
```

Remove the installation:

```powershell
./install/install.ps1 -Uninstall
```

```bash
./install/install.sh --uninstall
```

Validate changed skills where the tool is available:

```bash
skills-ref validate ./skills/<name>
```

Check installer syntax after editing installers:

```powershell
$tokens = $null
$errors = $null
$null = [System.Management.Automation.Language.Parser]::ParseFile(
  (Resolve-Path 'install/install.ps1'),
  [ref]$tokens,
  [ref]$errors
)
$errors
```

```bash
bash -n install/install.sh
```

## Before committing

- Confirm each changed `skills/*/SKILL.md` frontmatter `name` equals its directory.
- Confirm changed skills still have all six parts.
- Run `skills-ref validate ./skills/<name>` where available for changed skills.
- Confirm README and documentation links resolve.
- Avoid unrelated refactors.

## Commits

- Use Conventional Commits.
- Use an imperative subject with a scope where useful, for example:

```text
feat(install): add uninstall mode
```

- Do not add co-author, generated-by, AI attribution, or similar trailers.
- Never commit secrets or local agent settings.

## Do not

- Do not turn a skill into a monolith. Split and compose instead.
- Do not hard-code absolute paths in skill instructions.
- Do not hard-code one agent runtime into portable skill instructions.
- Do not claim benchmark results unless they were actually measured.
