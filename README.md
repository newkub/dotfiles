# Dotfiles

Personal dotfiles tracked in place by [mise](https://mise.jdx.dev) `[dotfiles]`
(`mise dot` / `mise dotfiles`) - no chezmoi, no symlinks. Files stay where they
are; mise saves checkpoints into a local bare repo and syncs them to this
repository.

## Machines

| Machine | OS | Tracked entries |
|---------|----|-----------------|
| Windows (`Veerapong`) | Windows 11 | `~/.config/*` app configs, agent CLIs (`.codex`, `.gemini`, `.continue`, `.copilot`, `.grok`, `.kiro`, ...), terminal/editor configs (alacritty, helix, yazi, rio, wezterm, Windows Terminal, Zed), `~/AppData/{Roaming,Local}` CLI configs, `~/.bashrc`, `~/.gitconfig`, `~/Documents/PowerShell`, mise config, `~/.config/agents/skills/` |
| WSL (`ArchLinux`) | Arch Linux | `~/.bashrc`, `~/.bash_profile`, `~/.config/starship*`, `ghostty`, `carapace`, `devin`, mise config |

Each machine declares its own `[dotfiles]` table in `~/.config/mise/config.toml`.
Every entry is scoped with an OS variant so Windows and WSL keep **separate
content streams at the same repo path**:

```toml
"~/.bashrc" = { mode = "track", variants = [{ os = "windows" }] }   # Windows only
"~/.bashrc" = { mode = "track", variants = [{ os = "linux" }] }     # WSL only
```

Files never cross OS boundaries - Windows configs are not written into WSL and
vice versa. Entries can also set `exclude = [...]` or `include = [...]` globs.

The origin is declared per-machine in `~/.config/mise/config.local.toml`
(machine-local, never synced):

```toml
[history.origin]
url = "git@github.com:newkub/dotfiles.git"   # Windows (SSH)
# url = "https://github.com:newkub/dotfiles.git"  # WSL (HTTPS + credential.helper store)
branch = "main"
```

## Layout

- `home@windows/` - Windows snapshots, mirroring `$HOME`
- `home@linux/` - WSL/Linux snapshots, mirroring `$HOME`
- `config@windows/`, `config@linux/` - per-OS `~/.config/mise` contents
- `.mise-history/` - mise history metadata (`format.toml`, `manifest.json`)
- `home@windows/.config/agents/skills/` - synced agent skills (`check-config`, `sync-to-remote`, `apply-to-computer`, ...)
- `README.md` - this file

`manifest.json` is the shared enrollment: each path lists every OS variant
that has claimed it. Conflicts in it are reconciled by unioning the `variants`
lists of both sides.

## Usage

```bash
mise run sync             # global task: `dot save` + `dot sync` in one shot
mise run dotfiles:sync    # gated sync: gitleaks scan of pending checkpoints, then `dot sync`
mise run dotfiles-status
mise dot status        # state of tracked files and sync
mise dot save          # save a checkpoint now
mise dot sync          # push checkpoints + fetch incoming
mise dot pull          # apply incoming changes from other machines
mise dot conflicts     # inspect merge conflicts
mise dot history       # browse saved versions
mise dot rollback      # restore a previous version
mise dot track <path>  # start tracking a new file/dir in place
```

## Secret gate

`mise run dotfiles:sync` is the only approved way to push. It runs
`gitleaks git` over `origin/main..HEAD` in the local history repo and aborts
before `mise dot sync` when it finds a leak. Bare `mise dot sync`/`push` skips
the gate - do not use them.

`~/.config/agents/skills/check-config/SKILL.md` (synced into this repo) holds
the audit procedure: how to diff CLI config locations against `[dotfiles]`,
the list of known secret-bearing paths that must stay untracked, and the
exclude patterns for tracked directories.

## Synced skills

`~/.config/agents/skills/` is tracked, so the workflow skills travel with the
dotfiles:

| Skill | Purpose |
|-------|---------|
| `check-config` | audit `[dotfiles]` coverage + secret-bearing paths before sync |
| `sync-to-remote` | push checkpoints to origin through the gitleaks gate |
| `apply-to-computer` | pull incoming changes, resolve conflicts, verify, rollback |

## Automatic capture

Both machines run the history watcher, so edits are checkpointed automatically:

```toml
[bootstrap.services.mise-history]
builtin = "history-watch"
```

Apply once per machine with `mise bootstrap services apply` (Windows scheduled
task / Linux systemd user service). `config.local.toml` is always omitted from
capture as machine-local.

If the watcher is disabled on a machine, run `mise dot save` manually before
`mise run dotfiles:sync` or `mise run sync` - checkpoints are not automatic.

## Adding a new machine

1. Install mise, then in `~/.config/mise/config.toml` declare `[dotfiles]`
   entries with the matching `os` variant and `[history.origin]` in
   `config.local.toml` pointing at this repo, `branch = "main"`.
2. Track `~/.config/mise` itself so the config travels.
3. `mise dot sync` to pull, then `mise bootstrap services apply`.

## Notes

- Never track secrets (`*.env`, `auth.json`, `credentials*`, `secrets.json`,
  `hosts.yml` with tokens, `.git-credentials`, `*.pem`, `*.key`) - use
  `exclude` or keep them untracked. Known secret-bearing paths are listed in
  the `check-config` skill.
- `mode = "track"` records history only; it does not deploy/symlink files.
- If `mise dot sync` reports an enrollment or manifest conflict, reconcile
  `manifest.json` by unioning both sides' `variants` lists, commit in the
  history repo (`~/.local/state/mise/history/repo.git`), and push.

## License

Private - all rights reserved.
