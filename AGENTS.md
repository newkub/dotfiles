---
name: dotfiles-agents
description: Working agreements for the dotfiles repo
---

## Goal

Keep personal dotfiles consistent — tracked in place by mise `[dotfiles]` (`mise dot`), no chezmoi, no symlinks.

## Architecture

- `config@windows`, `config@linux`, `home@windows`, `home@linux` — per-OS file trees mise tracks
- `mise.toml` — global tool + dotfiles declarations
- Files stay at their real paths; mise saves checkpoints into a local bare repo synced to `github:newkub/dotfiles`

## Commands

- Status/diff: `mise dot` status per mise docs
- Sync: `mise dotfiles` commands per `README.md`

## Rules

- Never commit secrets — `.env`, tokens, credentials stay local or go through `/config` secrets flow
- Machine-specific overrides marked per-OS dirs, not mixed into shared files
- README.md documents the restore flow — keep it accurate

## Verification

- `git status` clean per OS tree after edits; `mise dot` round-trip preserves file contents
