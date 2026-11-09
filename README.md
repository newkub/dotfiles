# Dotfiles

Personal dotfiles tracked in place by [mise](https://mise.jdx.dev) `[dotfiles]`
(`mise dot` / `mise dotfiles`) - no chezmoi, no symlinks. Files are saved as
checkpoints into a local bare repo and synced to this repository.

## Machines

| Machine | OS | Tracked entries |
|---------|----|-----------------|
| Windows (`Veerapong`) | Windows 11 | `~/.config/*` app configs, `~/.bashrc`, `~/.gitconfig`, wezterm, Windows Terminal `settings.json`, PowerShell profile, mise config |
| WSL (`ArchLinux`) | Arch Linux | `~/.bashrc`, `~/.bash_profile`, `~/.config/starship*`, `ghostty`, `carapace`, `devin`, mise config |

Each machine declares its own `[dotfiles]` table in `~/.config/mise/config.toml`.
Every entry is scoped with `variants = [{ os = "windows" }]` or
`variants = [{ os = "linux" }]` so the two operating systems keep **separate
content streams at the same repo path** - Windows files are never applied to
WSL and vice versa.

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
mise run sync        # global task: `dot save` + `dot sync` in one shot
mise dot status      # state of tracked files and sync
mise dot save        # save a checkpoint now
mise dot sync        # push checkpoints + fetch incoming
mise dot pull        # apply incoming changes from other machines
mise dot conflicts   # inspect merge conflicts
mise dot history     # browse saved versions
mise dot rollback    # restore a previous version
```

Automatic capture runs on both machines via
`[bootstrap.services.mise-history] builtin = "history-watch"` +
`mise bootstrap services apply`.

## License

Private - all rights reserved.
