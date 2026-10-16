# Global Rules

## 1. Refactor-To-SRP Always

- Whenever the user asks for something new (create/implement a feature, file, module, config, docs, skill) or asks to update/edit anything → always follow the `/refactor` file/SRP scope (`### 3. Refactor` bullet `file/SRP`)
- Every unit/file created or touched must have a single responsibility: 1 unit = 1 reason to change, file ≤250 lines (except barrel/index)
- Before writing → read `refactor/SKILL.md` `## Rules` + the `/refactor` file/SRP scope (`### 3. Refactor` bullet `file/SRP`); after writing/editing → run the `/refactor` file/SRP scope on the touched files before finishing. Never skip

## 2. Plan Before Bulk Work

- When the user asks for many new things at once (multiple features/files/tasks together) → always run `/create-plan-in-dot-devin` first, then implement per the plan

## 3. Test Usage Always

- Whenever the user asks for anything (create/implement a feature, file, module, config, docs, skill, or any edit) → always run `/deep-test usage` before finishing, to confirm that usage/examples/commands actually work. Never skip
- `/deep-test usage` can also pick an additional domain test that matches the domain — website → `/deep-test website`, CLI → `/deep-test cli`, API → `/deep-test api`, e2e → `/deep-test e2e`, multiple domains → `/deep-test all` (`/run-test` is a thin dispatcher that forwards here)
- If `/deep-test usage` is genuinely not applicable (e.g., research-only or report-only with no runnable usage) → state the reason in the report instead of silently skipping
