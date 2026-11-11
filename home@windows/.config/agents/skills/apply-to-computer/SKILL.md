---
name: apply-to-computer
description: Pull dotfiles from github.com/newkub/dotfiles onto this machine and verify the applied state
argument-hint: "[pull|conflicts|verify|rollback]"

---

## Goal

Bring a machine's tracked dotfiles up to date with `origin/main` — fetch, apply, resolve conflicts safely, and verify the result; rollback is one command away

## Scope

- Any machine with mise `[dotfiles]` entries + `[history.origin]` in `config.local.toml` (Windows and WSL keep separate `variants` streams at the same repo path)
- History repo: `~/.local/state/mise/history/repo.git`
- `mode = "track"` records history only — applying writes working files in place; nothing is symlinked or deployed

## Execute

### 1. Pull incoming changes

> Goal: fast-forward local history to origin without losing local edits

1. `mise dotfiles status` — baseline of tracked files
2. `mise dot save` — checkpoint local edits first so nothing is lost
3. `mise dot pull` — apply incoming changes
4. If pull reports conflicts: `mise dot conflicts` lists them; resolve per file, then `mise dot save` + `mise run dotfiles:sync` to publish the resolution

### 2. Verify applied state

> Goal: two independent signals that the apply worked

1. `mise dotfiles status` — no unexpected modified/missing entries
2. Spot-check one file that changed upstream (diff live file vs `git --git-dir=... show origin/main:<path>`)
3. `mise dot history` — confirm the applied checkpoint exists locally

### 3. Rollback when needed

> Goal: recover a bad apply in one step

1. `mise dot history` — pick the checkpoint before the bad apply
2. `mise dot rollback <checkpoint>` — restores previous version
3. Re-run verify; report what was rolled back and why

## Rules

- Never hand-edit files inside `~/.local/state/mise/history/repo.git` — resolve via `mise dot` commands only
- OS variants are isolated: a `windows` entry never overwrites `linux` content at the same repo path; a cross-OS diff means the `variants` list is wrong — fix `config.toml`, do not merge contents
- After pulling config changes, re-read `~/.config/mise/config.toml` before running tasks — a pulled config can change task definitions
- Fresh machine setup order: install mise → declare `[dotfiles]` + `[history.origin]` → `mise dot pull` → `mise bootstrap services apply`
