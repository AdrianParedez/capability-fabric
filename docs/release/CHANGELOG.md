# Changelog

All notable changes to Capability Fabric are recorded here.

This project uses Conventional Commits for commit messages and version-oriented release
notes for public milestones.

## Unreleased

### Changed

- Adjusted GitHub Linguist attributes so template files do not appear as Go Template in
  repository language statistics.
- Updated public documentation to reflect the launched release and workflow surface.

## [1.0.0] - 2026-06-05

Public release tag: `v1.0.0`.

### Added

- Initial Capability Fabric skill library with 10 agent-improving skills.
- Cross-runtime installers for Windows, macOS, and Linux.
- Routing directive for agent configuration.
- Claude Code plugin metadata.
- Documentation set covering research, taxonomy, dependency graph, activation strategy,
  and context optimization.
- Public contributor, security, citation, and agent-maintainer guidance.

### Validation

- All bundled skills pass `skills-ref validate`.
- Installer syntax checks pass for PowerShell and Bash.
