#!/usr/bin/env bash
# Install (or uninstall) the Capability Fabric skill library across every detected AI agent
# runtime so any of them can route to the right skill. Idempotent; safe to re-run.
#
# Usage:
#   ./install/install.sh                # universal + detected agents, with routing block
#   ./install/install.sh --all          # every known agent location
#   ./install/install.sh --link         # symlink instead of copy
#   ./install/install.sh --no-directive # skills only, no routing block
#   ./install/install.sh --uninstall    # remove everything this installer added
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC="$ROOT/skills"
DIRECTIVE_FILE="$SCRIPT_DIR/routing-directive.md"
[ -d "$SRC" ] || { echo "skills/ not found at repository root"; exit 1; }

ALL=0; LINK=0; NO_DIRECTIVE=0; UNINSTALL=0
for arg in "$@"; do case "$arg" in
  --all) ALL=1;; --link) LINK=1;; --no-directive) NO_DIRECTIVE=1;; --uninstall) UNINSTALL=1;;
  *) echo "unknown arg: $arg"; exit 1;; esac; done

DIRECTIVE="$(cat "$DIRECTIVE_FILE")"
mapfile -t SKILLS < <(find "$SRC" -mindepth 1 -maxdepth 1 -type d -exec test -f '{}/SKILL.md' \; -print)

# name | skills dir | config file | detect marker | always(1/0)
AGENTS=(
  "Universal (.agents)|$HOME/.agents/skills|$HOME/.agents/AGENTS.md|$HOME/.agents|1"
  "Claude Code|$HOME/.claude/skills|$HOME/.claude/CLAUDE.md|$HOME/.claude|0"
  "Codex|$HOME/.codex/skills|$HOME/.codex/AGENTS.md|$HOME/.codex|0"
  "Gemini CLI|$HOME/.gemini/skills|$HOME/.gemini/GEMINI.md|$HOME/.gemini|0"
)

strip_block() {  # remove the marker-delimited block from stdin
  awk 'BEGIN{skip=0}
       /<!-- BEGIN capability-fabric/{skip=1}
       skip==0{print}
       /<!-- END capability-fabric -->/{skip=0}'
}

install_skills() {
  local dest="$1"; mkdir -p "$dest"
  for s in "${SKILLS[@]}"; do
    local name; name="$(basename "$s")"; local tgt="$dest/$name"
    rm -rf "$tgt"
    if [ "$LINK" = 1 ]; then ln -s "$s" "$tgt"; else cp -R "$s" "$tgt"; fi
  done
  cp -f "$SRC/REGISTRY.md" "$dest/REGISTRY.md" 2>/dev/null || true
}

uninstall_skills() {
  local dest="$1"; [ -d "$dest" ] || return 0
  for s in "${SKILLS[@]}"; do rm -rf "$dest/$(basename "$s")"; done
  rm -f "$dest/REGISTRY.md"
  rmdir "$dest" 2>/dev/null || true   # only if now empty
}

set_directive() {
  [ "$NO_DIRECTIVE" = 1 ] && return 0
  local file="$1"; mkdir -p "$(dirname "$file")"; touch "$file"
  local tmp; tmp="$(mktemp)"
  strip_block < "$file" > "$tmp"
  [ -s "$tmp" ] && printf '\n' >> "$tmp"
  printf '%s\n' "$DIRECTIVE" >> "$tmp"
  mv "$tmp" "$file"
}

remove_directive() {
  local file="$1"; [ -f "$file" ] || return 0
  local tmp; tmp="$(mktemp)"
  strip_block < "$file" | sed -e :a -e '/^\n*$/{$d;N;ba}' > "$tmp"   # drop trailing blank lines
  if [ -s "$tmp" ]; then mv "$tmp" "$file"; else rm -f "$tmp" "$file"; fi
}

touched=0
for row in "${AGENTS[@]}"; do
  IFS='|' read -r NAME SKILLS_DIR CONFIG MARKER ALWAYS <<< "$row"
  if [ "$ALWAYS" = 1 ] || [ -d "$MARKER" ] || [ "$ALL" = 1 ]; then
    if [ "$UNINSTALL" = 1 ]; then
      uninstall_skills "$SKILLS_DIR"; remove_directive "$CONFIG"
      echo "  - removed $NAME"
    else
      install_skills "$SKILLS_DIR"; set_directive "$CONFIG"
      echo "  + $NAME -> $SKILLS_DIR"
    fi
    touched=$((touched+1))
  else
    echo "  - skip $NAME (not detected)"
  fi
done

echo ""
if [ "$UNINSTALL" = 1 ]; then
  echo "Removed Capability Fabric from $touched location(s)."
else
  echo "Installed ${#SKILLS[@]} skills to $touched location(s)."
  [ "$NO_DIRECTIVE" = 0 ] && echo "Routing block written. Agents select per task; state the task and they route."
  echo "Re-run to update. --all targets every known agent; --uninstall removes everything."
fi
