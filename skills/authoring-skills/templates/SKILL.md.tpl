---
name: <dir-name-must-match; lowercase-hyphen; <=64; gerund preferred>
description: <What it does AND when to use it. Third person. Lead with trigger keywords. Disambiguate neighbors ("for X use Y"). <=1024 chars, aim <=200.>
license: Apache-2.0
metadata:
  author: <you>
  version: "1.0"
  tier: "<0-4>"
  layer: <domain|meta>/<knowledge|procedure|tooling|control|quality>
# compatibility: <only if real env requirements, <=500 chars>
# allowed-tools: <space-separated, experimental: only if needed>
---

# <Title>

<One or two sentences: the core idea / why this skill exists.>

## Use this when
- <trigger 1>
- <trigger 2>
- **Do NOT** use for <neighbor case>, use <other-skill> instead.

## <The method / workflow>
```
- [ ] 1 <step>
- [ ] 2 <step>
- [ ] ...
```

## Principles
1. **<name>.** <rule, match freedom to fragility>
2. ...

## <Quick reference / decision table>
| Situation | Do |
|---|---|
| <...> | <...> |

## Runtime adaptation
- **Minimum:** <capabilities required, e.g. filesystem read + shell>.
- If <richer mechanism> is absent: <graceful fallback>.
- Reference capabilities, never specific tool names, for cross-runtime portability.

## Files
- `references.md`, <depth>.
- `examples.md`, <concrete pairs>.
- `templates/`, <artifacts>.
- `checklists/`, <gates>.
- `benchmarks/`, <evals + metrics>.
