<div align="center">

# Capability Fabric

**A model-agnostic Agent Skills library for explicit routing, bounded context, and verifiable agent behaviour.**

Small skills over standing prompt weight. Composition over monolithic instructions.
Explicit routes over accidental activation.

<p>
  <a href="LICENSE"><img alt="License: Apache-2.0" src="https://img.shields.io/badge/license-Apache--2.0-blue"></a>
  <a href="docs/README.md"><img alt="Docs" src="https://img.shields.io/badge/docs-index-0078D4"></a>
  <a href="https://github.com/AdrianParedez/capability-fabric/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/AdrianParedez/capability-fabric/actions/workflows/ci.yml/badge.svg"></a>
  <a href="https://agentskills.io"><img alt="Agent Skills standard" src="https://img.shields.io/badge/standard-Agent%20Skills-000000"></a>
  <img alt="Skills" src="https://img.shields.io/badge/skills-10-2ea44f">
  <img alt="Runtime" src="https://img.shields.io/badge/runtime-model--agnostic-0078D4">
  <img alt="Status" src="https://img.shields.io/badge/status-experimental-6f42c1">
</p>

<p>
  <a href="#install">Install</a> ·
  <a href="#plugin">Plugin</a> ·
  <a href="#documentation">Documentation</a> ·
  <a href="#quick-start">Quick Start</a> ·
  <a href="#roadmap">Roadmap</a> ·
  <a href="#capabilities">Capabilities</a> ·
  <a href="#routing">Routing</a> ·
  <a href="#verification">Verification</a>
</p>

<p><em>Created by <a href="https://paredez.dev">Adrian Paredez</a>, with Sole as his sovereign cognitive work partner.</em></p>

</div>

Capability Fabric is an agent-improving skill layer for runtimes that support the open
Agent Skills standard. It gives an agent a small set of process skills for planning,
research, context budgeting, sustained execution, verification, code quality, autonomy,
and skill authoring.

The library is deliberately narrow. Each skill has one responsibility, a portable
`SKILL.md`, and supporting references loaded only when needed.

> [!IMPORTANT]
> Capability Fabric changes the agent's operating method, not a single task domain.
> Install it once, then state the task. The runtime selects matching skills from their
> names and descriptions, and loads the full body only when needed.

## Install

Install into every detected agent runtime:

```powershell
git clone https://github.com/AdrianParedez/capability-fabric.git
cd capability-fabric
./install/install.ps1
```

If PowerShell blocks the script, run it without changing your policy:

```powershell
pwsh -ExecutionPolicy Bypass -File ./install/install.ps1
```

macOS and Linux:

```bash
git clone https://github.com/AdrianParedez/capability-fabric.git
cd capability-fabric
./install/install.sh
```

Remove the installation:

```bash
./install/install.ps1 -Uninstall      # Windows
./install/install.sh --uninstall      # macOS / Linux
```

Installer options:

| Flag | Effect |
| --- | --- |
| `-All` / `--all` | Target every known agent location, detected or not. |
| `-Link` / `--link` | Symlink instead of copy. |
| `-NoDirective` / `--no-directive` | Install skills only. |
| `-Uninstall` / `--uninstall` | Remove installed skills and the routing block. |

## Plugin

Claude Code plugin install:

```text
/plugin marketplace add AdrianParedez/capability-fabric
/plugin install capability-fabric
```

The Claude Code plugin metadata is experimental. The skills and installers are the
supported distribution surface for the public release.

## Documentation

The public documentation is organized under [`docs/`](docs/). Start with
[`docs/README.md`](docs/README.md).

- [Research report](docs/research/01-research-report.md)
- [Competitive analysis](docs/research/02-competitive-analysis.md)
- [Capability matrix](docs/research/03-capability-matrix.md)
- [Gap analysis](docs/research/04-gap-analysis.md)
- [Skill taxonomy](docs/design/05-skill-taxonomy.md)
- [Dependency graph](docs/design/06-dependency-graph.md)
- [Activation strategy](docs/design/07-activation-strategy.md)
- [Context optimization](docs/design/08-context-optimization.md)
- [Sources](docs/research/_sources.md)

## Quick Start

Install the library, open an agent, and state the work in ordinary language:

```text
research the current Agent Skills standard and write a report
plan this repository migration and keep a durable ledger
review this feature branch for behavioural regressions
create a new portable skill for release-note drafting
```

The routing block points the agent at [`skills/REGISTRY.md`](skills/REGISTRY.md). The
registry defines the available capabilities and default composition paths.

Manual installation:

```text
skills/<name>/ -> ~/.agents/skills/<name>/
skills/<name>/ -> ~/.codex/skills/<name>/
skills/<name>/ -> ~/.claude/skills/<name>/
```

## Roadmap

See [docs/release/ROADMAP.md](docs/release/ROADMAP.md) for the current lane, planned work,
and non-goals.

## Capabilities

| Skill | Behaviour |
| --- | --- |
| `context-budgeting` | Controls context cost, offload points, and compaction pressure. |
| `progressive-research` | Finds external facts with bounded search, triage, and corroboration. |
| `decomposing-tasks` | Converts ambiguous work into a verifiable, risk-ordered plan. |
| `sustained-execution` | Keeps long runs resumable through an external task ledger. |
| `verifying-reasoning` | Seeks disconfirmation before conclusions are trusted. |
| `operating-autonomously` | Runs bounded unattended work with progress and stuck detection. |
| `guarding-code-quality` | Fits changes to the codebase and verifies behaviour before reporting done. |
| `composing-skills` | Selects the smallest matching skill set and sequences it. |
| `authoring-skills` | Generates spec-compliant portable skills. |
| `auditing-skills` | Scores and improves skills against a quality rubric. |

Skill directory shape:

```text
skills/<name>/
  SKILL.md
  references.md
  examples.md
  templates/
  checklists/
  benchmarks/
```

## Routing

Default routes:

```text
external information       progressive-research, verifying-reasoning
multi-step work            decomposing-tasks, sustained-execution, guarding-code-quality
unattended execution       operating-autonomously
skill creation             authoring-skills
skill improvement          auditing-skills
ambient control            context-budgeting
```

Routing constraints:

| Rule | Effect |
| --- | --- |
| Smallest match | Load only the skills needed for the task. |
| Tiered composition | Higher-tier skills may compose lower-tier skills. |
| Acyclic graph | Skills never depend upward. |
| Portable wording | Required steps name capabilities, not runtime tools. |
| Marker-delimited install | The routing block updates in place and is never duplicated. |

## Repository Layout

```text
capability-fabric/
  .github/
    ISSUE_TEMPLATE/
    workflows/
    CODE_OF_CONDUCT.md
    CONTRIBUTING.md
    pull_request_template.md
    SECURITY.md
  AGENTS.md
  README.md
  install/
    install.ps1
    install.sh
    routing-directive.md
  docs/
    README.md
    design/
    release/
    research/
  skills/
    REGISTRY.md
    <skill>/
  .claude-plugin/
```

## Verification

GitHub Actions runs `CI` on push and pull request. `Link Check` and `Release Check` are
manual workflows for public documentation and release-readiness checks.

Validate changed skills where the tool is available:

```bash
skills-ref validate ./skills/<name>
```

Installer syntax checks:

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

## Known Limitations

- Experimental library.
- Runtime support depends on Agent Skills compatibility.
- The installer writes to global agent configuration files.
- Claude Code plugin metadata remains experimental.
- Benchmarks describe methods and targets, not published execution results.
- Skills improve agent process, not domain expertise by themselves.

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).

<div align="center">
<sub>Built with assistance from Sole.</sub>
</div>
