---
name: check-config
description: Audit that every CLI's config file is covered by mise [dotfiles] tracking, and that no secrets would be captured before sync
argument-hint: "[audit|secrets|sync]"

---

## Goal

Keep the mise `[dotfiles]` table in `~/.config/mise/config.toml` covering every CLI config on the machine — find untracked config files, flag secret-bearing files that must stay excluded, and gate every sync behind a secret scan

## Scope

- Windows machine (`variants = [{ os = "windows" }]` entries); WSL has its own `[dotfiles]` table in the WSL `config.toml`
- Tracking is `mode = "track"` — files stay in place, mise snapshots them into `~/.local/state/mise/history/repo.git` and syncs to `git@github.com:newkub/dotfiles.git` (`main`)
- Not a dotfiles manager migration tool — chezmoi is archived (`chezmoi-archive` branch); this skill only audits mise coverage

## Execute

### 1. Audit coverage

> Goal: every CLI config path on disk is either tracked or explicitly excluded

1. List tracked entries: `mise dotfiles status --verbose` (or parse the `[dotfiles]` table in `~/.config/mise/config.toml`)
2. List candidate config locations and diff against the tracked set:
   - `~/.config/<tool>/` — one dir per CLI (`atuin`, `crush`, `wezterm`, `starship`, ...)
   - `~/.*` dotfiles and dot-dirs (`.codex`, `.gemini`, `.continue`, `.grok`, `.gitconfig`, ...)
   - `~/AppData/Roaming/<tool>/` and `~/AppData/Local/<tool>/` for Windows-native CLIs (alacritty, helix, yazi, rio, devin, Zed, ...)
3. For each untracked candidate decide: **track** (real config), **exclude** (state/cache/logs/sessions), or **skip** (empty dir, nested git repo, junction to another store)
4. Junction check before tracking a dir: `cmd /c "dir /AL /B <path>"` — junctions to `D:\dot-agents` (skills dirs) must not be recursed; mise stores the link itself, which is fine
5. Report the gap table: path → verdict → reason

### 2. Secret gate

> Goal: nothing secret-bearing enters the history repo or reaches origin

Known secret-bearing paths — never track, never remove the exclusion:

| Path | Why |
|------|-----|
| `~/.ssh`, `~/.aws`, `~/.mcp-auth`, `~/.gnupg` | keys/credentials |
| `~/.config/context7/credentials.json` | API credentials |
| `~/.config/thclaws/secrets.json` | already excluded |
| `~/.config/opencode/service.json` | already excluded |
| `~/.continue/auth.json` | auth token |
| `~/.cline/data/secrets.json` | secrets store |
| `~/.mmx/config.json` | contains live `api_key` |
| `~/.config/crush/crush.json`, `~/AppData/Local/crush/crush.json`, `providers.json` | contains live `sk-cp-*` key |
| `~/.zeroclaw/config.toml` | `paired_tokens` blob |
| `~/.phase/secrets`, `~/.portless/*.pem`, `~/.mcpjam/*.pem` | key material |
| `~/.dsh/.credentials.yaml`, `~/.webmcp/.env`, `~/.kenv/.env` | env credentials |
| `~/AppData/Roaming/devin/credentials.toml` | Devin credentials |
| `~/AppData/Roaming/com.vercel.cli/Data/auth.json` | Vercel token |
| `~/AppData/Roaming/GitHub CLI/hosts.yml` | gh OAuth token |
| `~/.codex/auth.json`, `~/.claude.json`, `~/.gemini/oauth*` | agent auth |
| `~/.atuin` (root) | atuin encryption key — only `~/.config/atuin` is tracked |

Patterns that always exclude inside a tracked dir: `auth.json`, `credentials*`, `*secret*`, `*.pem`, `*.key`, `*.sqlite*`, `sessions/`, `logs/`, `history*`, `state/`, `cache/`, `node_modules/`, `.git/`

Keyword hits are not proof — `${VAR}` env references (e.g. `~/.gemini/settings.json`, `~/AppData/Roaming/devin/mcp_config.json`) are safe; a literal `sk-`, `ghp_`, `enc2:` blob is not. Verify before deciding.

### 3. Sync

> Goal: secrets are scanned before anything leaves the machine

1. Capture pending changes: `mise dot save`
2. Sync ONLY through the gate: `mise run dotfiles:sync` — runs `gitleaks git` on `origin/main..HEAD` in `~/.local/state/mise/history/repo.git`, blocks on findings, then `mise dot sync`
3. Never run bare `mise dot sync` / `mise dot push` — the gate is the only approved path
4. If gitleaks blocks: inspect with `gitleaks git <repo> --log-opts="origin/main..HEAD" --redact`, remove the file from `[dotfiles]` (or add an `exclude`), `mise dot save` a cleanup checkpoint, re-run the gate
5. Watcher note: `mise dot` auto-capture is declared but the watcher is not running — run `mise bootstrap services apply` to enable it, or `mise dot save` manually before syncing

## Verify

- `mise dotfiles status` → entries count matches `[dotfiles]` table; no unexpected "omitted" files
- `mise run dotfiles:sync` → gitleaks clean, sync completes, `↑ Last published` timestamp advances
- Spot-check: `git --git-dir=$env:USERPROFILE\.local\state\mise\history\repo.git grep -n "sk-" origin/main -- "home@windows"` returns nothing
