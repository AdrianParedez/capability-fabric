# Security

## Trust model

Capability Fabric is data, not a service. Skills are plain Markdown and supporting files
that your agent reads on demand. The library makes no network calls and collects no
telemetry.

The installer runs locally and does two things: it copies the skill folders into each
agent's skills directory, and it writes one marker-delimited block into each agent's global
config (`~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md`, `~/.agents/AGENTS.md`). It changes
nothing else. `-Uninstall` / `--uninstall` reverses both and leaves other content intact.

Skills can instruct an agent to run commands. Review a skill's `SKILL.md` and any
`scripts/` before installing it, the same way you would review any code you run. Treat
third-party skills with the same caution as third-party code.

## Reporting a vulnerability

Report privately. Do not open a public issue for a security problem.

- Preferred: GitHub private vulnerability reporting, the **Security** tab on this
  repository, then **Report a vulnerability**.
- Include: what you found, how to reproduce it, and the impact.

You will get an acknowledgement within a few days. Fixes are released as soon as a
verified report is confirmed, with credit to the reporter unless you prefer otherwise.

## Scope

In scope: the installer scripts, the routing block, and any bundled `scripts/`.
Out of scope: behaviour of the host agent runtime itself, and skills you author or install
from elsewhere.
