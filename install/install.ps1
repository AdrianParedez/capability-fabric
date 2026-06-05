#!/usr/bin/env pwsh
<#
.SYNOPSIS
  Install (or uninstall) the Capability Fabric skill library across every detected AI
  agent runtime so any of them can route to the right skill. Idempotent; safe to re-run.

.DESCRIPTION
  Install copies all skills/ (each dir with a SKILL.md) into:
    - the universal cross-client dir  ~/.agents/skills/   (scanned by many runtimes)
    - each detected agent's own skills dir (Claude Code, Codex, Gemini)
  and writes one marker-delimited routing block into each agent's global config
  (~/.claude/CLAUDE.md, ~/.codex/AGENTS.md, ~/.agents/AGENTS.md). The block is updated in
  place on re-run, never duplicated. Uninstall removes both, leaving any other skills and
  config untouched.

.PARAMETER All
  Target ALL known agent locations even if the agent is not detected.

.PARAMETER Link
  Use directory symlinks instead of copying (needs Developer Mode or admin on Windows).

.PARAMETER NoDirective
  Skip the routing block (install skills only).

.PARAMETER Uninstall
  Remove the skills this library ships and the routing block from every target.

.EXAMPLE
  ./install/install.ps1                 # universal + detected agents, with routing block
  ./install/install.ps1 -All            # every known agent location
  ./install/install.ps1 -Uninstall      # remove everything this installer added
#>
[CmdletBinding()]
param(
  [switch]$All,
  [switch]$Link,
  [switch]$NoDirective,
  [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'
$scriptDir = $PSScriptRoot
$root      = Split-Path $scriptDir -Parent
$srcSkills = Join-Path $root 'skills'
if (-not (Test-Path $srcSkills)) { throw "skills/ not found at repository root ($srcSkills)" }
$directive = Get-Content (Join-Path $scriptDir 'routing-directive.md') -Raw
$home_     = [Environment]::GetFolderPath('UserProfile')

# Skills = subdirs of skills/ that contain a SKILL.md
$skillDirs = Get-ChildItem $srcSkills -Directory | Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }

# Agent targets: display name, skills dir, global-config file for the routing block, detect marker
$agents = @(
  @{ Name='Universal (.agents)'; Skills="$home_/.agents/skills"; Config="$home_/.agents/AGENTS.md"; Marker="$home_/.agents"; Always=$true }
  @{ Name='Claude Code';         Skills="$home_/.claude/skills";  Config="$home_/.claude/CLAUDE.md"; Marker="$home_/.claude"; Always=$false }
  @{ Name='Codex';               Skills="$home_/.codex/skills";   Config="$home_/.codex/AGENTS.md";  Marker="$home_/.codex";  Always=$false }
  @{ Name='Gemini CLI';          Skills="$home_/.gemini/skills";  Config="$home_/.gemini/GEMINI.md"; Marker="$home_/.gemini"; Always=$false }
)

$blockPattern = '(?s)\r?\n*<!-- BEGIN capability-fabric.*?<!-- END capability-fabric -->\r?\n?'

function Install-Skills([string]$dest) {
  New-Item -ItemType Directory -Force -Path $dest | Out-Null
  foreach ($s in $skillDirs) {
    $target = Join-Path $dest $s.Name
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    if ($Link) { New-Item -ItemType SymbolicLink -Path $target -Target $s.FullName | Out-Null }
    else       { Copy-Item $s.FullName $target -Recurse -Force }
  }
  Copy-Item (Join-Path $srcSkills 'REGISTRY.md') (Join-Path $dest 'REGISTRY.md') -Force -ErrorAction SilentlyContinue
}

function Uninstall-Skills([string]$dest) {
  if (-not (Test-Path $dest)) { return }
  foreach ($s in $skillDirs) {
    $target = Join-Path $dest $s.Name
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
  }
  Remove-Item (Join-Path $dest 'REGISTRY.md') -Force -ErrorAction SilentlyContinue
  if (-not (Get-ChildItem $dest -Force -ErrorAction SilentlyContinue)) { Remove-Item $dest -Force }
}

function Set-Directive([string]$file) {
  if ($NoDirective) { return }
  New-Item -ItemType Directory -Force -Path (Split-Path $file -Parent) | Out-Null
  $existing = (Test-Path $file) ? (Get-Content $file -Raw) : ''
  if ($existing -match $blockPattern) {
    $updated = [regex]::Replace($existing, $blockPattern, "`n$directive")
  } else {
    $sep = ($existing.Length -gt 0 -and -not $existing.EndsWith("`n")) ? "`n`n" : "`n"
    $updated = $existing + $sep + $directive
  }
  Set-Content -Path $file -Value $updated -NoNewline -Encoding utf8
}

function Remove-Directive([string]$file) {
  if (-not (Test-Path $file)) { return }
  $existing = Get-Content $file -Raw
  if ($existing -match $blockPattern) {
    $updated = [regex]::Replace($existing, $blockPattern, '').TrimEnd()
    if ($updated.Length -gt 0) { Set-Content -Path $file -Value ($updated + "`n") -NoNewline -Encoding utf8 }
    else { Remove-Item $file -Force }
  }
}

$touched = 0
foreach ($a in $agents) {
  $detected = $a.Always -or (Test-Path $a.Marker)
  if (-not ($detected -or $All)) { Write-Host "  - skip $($a.Name) (not detected)" -ForegroundColor DarkGray; continue }
  if ($Uninstall) {
    Uninstall-Skills $a.Skills
    Remove-Directive $a.Config
    Write-Host "  - removed $($a.Name)" -ForegroundColor Yellow
  } else {
    Install-Skills $a.Skills
    Set-Directive $a.Config
    Write-Host "  + $($a.Name) -> $($a.Skills)" -ForegroundColor Green
  }
  $touched++
}

Write-Host ""
if ($Uninstall) {
  Write-Host "Removed Capability Fabric from $touched location(s)." -ForegroundColor Cyan
} else {
  Write-Host "Installed $($skillDirs.Count) skills to $touched location(s)." -ForegroundColor Cyan
  if (-not $NoDirective) { Write-Host "Routing block written. Agents select per task; state the task and they route." -ForegroundColor Cyan }
  Write-Host "Re-run to update. -All targets every known agent; -Uninstall removes everything." -ForegroundColor DarkGray
}
