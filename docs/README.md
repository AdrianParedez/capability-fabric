# Documentation

Capability Fabric's documentation is ordered from research to implementation strategy.

## Index

- [Research report](research/01-research-report.md), primary findings behind the project.
- [Competitive analysis](research/02-competitive-analysis.md), adjacent agent skill and context
  systems.
- [Capability matrix](research/03-capability-matrix.md), mapped gaps and coverage.
- [Gap analysis](research/04-gap-analysis.md), unmet needs the library targets.
- [Skill taxonomy](design/05-skill-taxonomy.md), placement rules for new skills.
- [Dependency graph](design/06-dependency-graph.md), tiering and composition constraints.
- [Activation strategy](design/07-activation-strategy.md), routing and resting-context design.
- [Context optimization](design/08-context-optimization.md), budget and loading principles.
- [Changelog](release/CHANGELOG.md), public release history.
- [Roadmap](release/ROADMAP.md), current lane, planned work, and non-goals.
- [Sources](research/_sources.md), citations behind factual claims.

## Reading order

For project rationale, read `01` through `04`.

For maintenance work, read `05`, `06`, and `07`.

For context-management design, read `08`.

## Maintenance

Keep this directory focused on rationale, taxonomy, operating strategy, release history,
and planning. Skill bodies belong in `skills/`; installer behavior belongs in `install/`;
contributor procedure belongs in `.github/CONTRIBUTING.md`.
