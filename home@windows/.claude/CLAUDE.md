---
name: global-rules
description: Working principles that govern every task in every workspace
---

## Goal

Define how the agent works on every task so results are correct, proactive, and easy to maintain. This file is the trigger layer — mechanics live in the owner skills it routes to.

## Lifecycle

| When | Do | Owner | Verify |
|---|---|---|---|
| Request | clarify intent; ideas → evidence tables, never prose | `/ask-me`, `/idea-new-features`, `/review`, `/refactor` | table has real citations, not prose |
| Start | snapshot state; learn codebase before planning; present plan, wait for ok, then persist `.agents/plans/` | `/deep-report status`, `/deep-learn codebase`, `/plan` | plan file exists + user approved |
| Plan | refactor before adding behavior | `/refactor` | green before and after |
| Build | watch→wait→resolve; git-first debugging; ast-grep for codemods; git ops for file moves; package manager first; open ports → open the page; browser → `/use-agent-browser`; scripts prefer bun/OS shell | `/use-agents-terminal watch`, `/commit`, `/push`, `/list-global-cli`, `/setup-task`, `/open-browser` | `/deep-report run` on the build command |
| Test | validate intent after green — passing tests ≠ delivered | `/ship verify`, `/improve-test-coverage` | verify green + intent check |
| Review | review diff/PR before calling done | `/review`, `/review-pr` | findings table + verdict |
| Done | verify gate; close with `/deep-report status`; suggest next via `/continue`; leave trace | `/ship verify`, `/deep-report`, `/continue` | `/deep-report status` + journal entry |
| Ship | install hooks; verify → push → PR → merge | `/setup-githooks`, `/ship` | `/deep-report run ship` — merged or blocked |
| Release `on-demand` | staging→prod promote, canary, flags | `/ship promote`, `/ship deploy`, `/ship canary` | `/deep-report run deploy` — live URL verified |
| Operate `on-demand` | health/deploy checks on running targets | `/ship verify health`, `/ship verify deploy`, `/use-agents-terminal watch` | health evidence, not assumption |
| Maintain `on-demand` | cleanup, dep refresh, activity sync | `/cleanup-scan` `/cleanup-*`, `/update-project deps`, `/update-project activity` | dry-run + confirm before delete |
| Secrets `on-demand` | values via temp file → secrets manager/deploy target; never printed or committed | `/setup-env` | presence check only — value never echoed |
| Learn | turn the session into rules/skills/journal | `/dot`, `/dot mine`, `/maintain-harness` | cited findings persisted |
## Always

- Follow these rules first — they override habit and convenience.
- Verify before claiming done — run the real check, show its evidence, never fabricate results.
- Plan before building — every non-trivial task starts with `/deep-plan` (research + analyze + thinking → persisted plan + ask-me gate) unless the user explicitly says skip; trivial one-step fixes may go direct but say so.
- Never end a task on your own — every close: `/report-task-on-complete` (= `/deep-report status` + `/report-files-change` + open threads), then `/dot ask-me` with clickable options (`Done`, `Continue`, `Suggest another`, situational picks); keep asking until the user picks Done or says the work can end.
- Ask the user with options, not open questions — whenever a decision or confirmation is needed, use `/ask-me` (clickable prompt with a recommendation); plain-text questions only when options genuinely can't be enumerated.
- Ask only when genuinely ambiguous — destructive, shared-state, or irreversible actions need stated scope and explicit confirmation (`/ask-me consent`).
- When the user asks to list anything → Markdown table, one row per item.
- Answer before acting — a question or request for options gets a reply first (table or numbered list), never silent work; numbered proposals must be pickable per item or as `ทั้งหมด`.
- In `ask_user_question`/`/ask-me`, emoji goes on the recommended option only (`✨ Recommended: <name>`) — every other option is a plain label with no emoji; always include `Done`/`Skip` and `Suggest another` options.
- Anything unfinished gets a `TODO` or `MOCK` comment in `/comment-code` contract format (marker + owner + route) — never silent stubs or dead code.
- Use the latest stable dependencies — check versions, pick maintained options, never `latest`/`*` (`/compare`, `/list-dependencies`).
- Weigh architecture and code quality — simplest readable solution wins; follow project conventions, formatters, linters, specs.
- Be proactive — do every doable step yourself; payments, account/security settings, and external sends are described step-by-step for the user.
- When the user must act on a page — API key, login, dashboard, secret entry → open it yourself via `/open-browser <target>` in the same turn; never just print a URL and wait.
- Bench before tuning — measure before and after, never tune blind (`/optimize all`).
- Edit routing first — structural code changes (rename/move/pattern rewrite/codemod) go through `/astgrep`; literal find/replace across files → `/edit-relative-files`; then `bun` scripts or POSIX shell for the rest, never Python heredocs; Python is last resort when neither skill nor shell can express the transform.
- Spend context wisely — search before reading whole files, batch reads, ground repo claims in a real check.
- After editing files, run `/update-references` — generated surfaces (`index/`, plugin manifests, client links) refresh from sources on every edit; generated files are never hand-edited.
- Domain-specific work (config, data, docs, incident, onboarding) routes via the skill catalog — `skills/AGENTS.md` + `index/skills.json`; this table covers lifecycle moments only.

## Expected Outcome

Every task follows the lifecycle table: the right owner at the right moment, non-trivial work planned via `/deep-plan` first, verified before claimed done, questions go through `/ask-me` options, and closes end with `/report-task-on-complete` + ask-me next-action.
