# Dotfiles

Personal dotfiles tracked in place by [mise](https://mise.jdx.dev) `[dotfiles]`
(`mise dot` / `mise dotfiles`) — no chezmoi, no symlinks. Files are saved as
checkpoints into a local bare repo and synced to this repository.

## Machines

| Machine | OS | Tracked entries |
|---------|----|-----------------|
| Windows (`Veerapong`) | Windows 11 | `~/.config/*` app configs, shell rc files, tool configs |
| WSL (`ArchLinux`) | Arch Linux | `~/.bashrc`, `~/.config/starship*`, `ghostty`, `carapace` |

Each machine declares its own `[dotfiles]` table in `~/.config/mise/config.toml`
and its origin in `~/.config/mise/config.local.toml`:

```toml
[history.origin]
url = "git@github.com:newkub/dotfiles.git"   # Windows (SSH)
# url = "https://github.com/newkub/dotfiles.git"  # WSL (HTTPS + credential.helper store)
branch = "main"
```

## Layout

- `home/` — snapshots of tracked files, mirroring `$HOME` (`home/.config/...`)
- `.mise-history/` — mise history metadata (`format.toml`, `manifest.json`)
- `README.md` — this file

## Usage

```bash
mise dot status     # state of tracked files and sync
mise dot save       # save a checkpoint now
mise dot sync       # push checkpoints + fetch incoming
mise dot pull       # apply incoming changes from other machines
mise dot conflicts  # inspect merge conflicts
mise dot history    # browse saved versions
mise dot rollback   # restore a previous version
```

Windows notes: `history-watch` auto-saves on change via
`[bootstrap.services.mise-history]`. On mise for Windows, `mise dot status`/`sync`
may hit a known NUL-path bug (mise 2026.11.5); the underlying bare repo at
`~/.local/state/mise/history/repo.git` can be driven with plain `git` as a
workaround.

## License

Private — all rights reserved.
