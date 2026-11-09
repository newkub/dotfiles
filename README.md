# Dotfiles

Personal dotfiles tracked in place by [mise](https://mise.jdx.dev) `[dotfiles]`
(`mise dot` / `mise dotfiles`) - no chezmoi, no symlinks. Files stay where they
are; mise saves checkpoints into a local bare repo and syncs them to this
repository.

## Machines

| Machine | OS | Tracked entries |
|---------|----|-----------------|
| Windows (`Veerapong`) | Windows 11 | `~/.config/*` app configs, `~/.bashrc`, `~/.bash_profile`, `~/.gitconfig`, wezterm, Windows Terminal `settings.json`/`state.json`, `~/Documents/PowerShell`, mise config |
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
- `README.md` - this file

`manifest.json` is the shared enrollment: each path lists every OS variant
that has claimed it. Conflicts in it are reconciled by unioning the `variants`
lists of both sides.

## Usage

```bash
mise run sync          # global task: `dot save` + `dot sync` in one shot
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

## Automatic capture

Both machines run the history watcher, so edits are checkpointed automatically:

```toml
[bootstrap.services.mise-history]
builtin = "history-watch"
```

Apply once per machine with `mise bootstrap services apply` (Windows scheduled
task / Linux systemd user service). `config.local.toml` is always omitted from
capture as machine-local.

## Adding a new machine

1. Install mise, then in `~/.config/mise/config.toml` declare `[dotfiles]`
   entries with the matching `os` variant and `[history.origin]` in
   `config.local.toml` pointing at this repo, `branch = "main"`.
2. Track `~/.config/mise` itself so the config travels.
3. `mise dot sync` to pull, then `mise bootstrap services apply`.

## Notes

- Never track secrets (`*.env`, `secrets.json`, `hosts.yml` with tokens,
  `.git-credentials`) - use `exclude` or keep them untracked.
- `mode = "track"` records history only; it does not deploy/symlink files.
- If `mise dot sync` reports an enrollment or manifest conflict, reconcile
  `manifest.json` by unioning both sides' `variants` lists, commit in the
  history repo (`~/.local/state/mise/history/repo.git`), and push.

## License

Private - all rights reserved.
