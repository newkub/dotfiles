---
name: sync-to-remote
description: Push local dotfiles checkpoints to github.com/newkub/dotfiles through the secret-scan gate
argument-hint: "[status|sync]"

---

## Goal

Get local dotfile changes onto the remote (`origin/main`) safely — every push passes the gitleaks gate first, and the result is verified on the remote

## Scope

- Windows machine; history repo at `~/.local/state/mise/history/repo.git`, remote `git@github.com:newkub/dotfiles.git` (`main`)
- The only approved push path is `mise run dotfiles:sync` (gitleaks scan of `origin/main..HEAD`, then `mise dot sync`)
- Bare `mise dot sync` / `git push` inside the history repo skips the gate — do not use them

## Execute

### 1. Check what would sync

> Goal: know the pending delta before pushing

1. `mise run dotfiles-status` — tracked files and sync state
2. `git --git-dir=$env:USERPROFILE\.local\state\mise\history\repo.git log origin/main..HEAD --oneline` — pending checkpoints (empty = nothing to push)
3. If the history watcher is disabled, run `mise dot save` first to checkpoint current edits

### 2. Sync through the gate

> Goal: push only after the secret scan passes

1. `mise run dotfiles:sync`
2. On `BLOCKED: possible secrets` — do not bypass; inspect the flagged checkpoint (`git show <sha>` in the history repo), remove the secret from the live file, `mise dot save` again, re-run
3. On success confirm: `git --git-dir=... log origin/main..HEAD --oneline` is empty and `git ls-remote origin main` matches local `HEAD`

### 3. Report

> Goal: leave a replayable trace

1. Report checkpoints pushed (count + range), gate result, and remote head sha
2. If `mise dot sync` reports enrollment/manifest conflict — stop and hand off to `apply-to-computer` conflict steps; never union `manifest.json` blindly

## Rules

- Never print secret values found by the gate — report file path and checkpoint sha only
- `config.local.toml` and machine-local state are never synced; if a diff shows them, stop and fix the `[dotfiles]` table instead
- WSL syncs over HTTPS with its own `config.local.toml` — do not copy the Windows SSH remote into WSL
