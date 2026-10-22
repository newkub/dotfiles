---
name: global-rules
description: ลำดับการทำงานทุก task ให้ปลอดภัย ตรวจสอบได้ และส่งมอบครบ
---

## Goal

กำหนดลำดับการทำงานทุก task ให้ปลอดภัย ตรวจสอบได้ และส่งมอบครบ

## Scope

ใช้กับทุก task และทุก workspace โดยปรับ tools ตาม ecosystem ที่ตรวจพบ

## Execute

### 1. Prepare Workspace

เตรียม workspace, prompt, และขอบเขตงาน

> Goal: ระบุ workspace, prompt, ขอบเขต และ references ชัดเจน

**Triage ก่อนเริ่ม:** เลือกเส้นทางตามขนาดและความเสี่ยงของงาน
- **Fast path** — คำถาม/อธิบาย/แก้ไฟล์เดียวที่ไม่เสี่ยง: ตอบหรือแก้ได้เลย ไม่ต้อง `enhance-prompt`, plan, หรือ report เต็มรูป
- **Full path** — feature ใหม่, แก้หลายไฟล์, เปลี่ยน public API, หรืองานเสี่ยง: เดินครบทุก section

1. Full path: ทำ `enhance-prompt` สรุปเป็น numbered (single responsibility ต่อข้อ) → `deep-plan` (หรือ `create-plan-in-dot-devin` เมื่อต้อง publish plan) → `continue`; Fast path ข้ามขั้นนี้
2. อ่าน references ที่เกี่ยวข้องและยืนยันว่ามีจริงด้วย `check-reference` ก่อนแก้ไข (การอัปเดต references หลังแก้ให้ทำตามข้อ 5.8)
3. ถ้ายังไม่ชัดว่าต้องทำอะไรต่อ → `/suggest-next-action` (follow `/follow-enter-dot`); ถ้า user ระบุ action ชัดแล้วให้ทำตามนั้น
4. ใช้ "." เป็น trigger สำหรับ `/follow-enter-dot` — จะเลือก `/continue`, `/suggest-next-action`, `/ship`, หรือ `/ask-me` ตาม state ปัจจุบัน
5. ถ้า `AGENTS.md` ระบุ workflows → ใช้ `/follow-agents-md` แทนการทำเองโดยตรง
6. ถ้างานมี subtasks อิสระหลายด้าน → ใช้ `/update-devin-global-subagents` หรือ `/use-subagents` ตาม context
7. ห้ามเรียกใช้ skills หรือ subagents ที่ไม่เกี่ยวข้องกับ task
8. ถ้าเข้าถึง workspace ไม่ได้ → stop และ report โดยไม่แก้ไขไฟล์
9. ถ้า disk เต็มหรือใกล้เต็ม → ทำ `/cleanup-files-in-computer` ก่อนดำเนินการต่อ

### 2. Read References

อ่าน skills และ references ก่อนวิเคราะห์หรือเขียน

> Goal: ใช้ข้อกำหนดที่มีอยู่จริง ไม่ซ้ำซ้อน

1. ทำ `/search-skills` เพื่อเลือก skills ที่ตรงกับ task — action → CLI tool map อยู่ที่ `skills/check-my-global-cli/references/tool-map.md`; ถ้าไม่แน่ใจว่า tool ติดตั้งแล้วหรือไม่ → ทำ `/check-my-global-cli`
2. ทำ `follow-devin-global-skills` เพื่อเข้าใจ convention ของ global skills; ไม่ต้องอ่าน skill ทั้งหมดทุก task
3. ทำ `check-reference` เพื่อยืนยันว่า references มีอยู่จริง
4. ถ้า reference หรือ skill ที่จำเป็นไม่มีจริง → ใช้ตัวที่ใกล้ที่สุดใน family เดียวกันแล้วระบุใน report; ถ้าไม่มีตัวทดแทน → stop และ report

### 3. Research And Learn

ค้นคว้าเฉพาะเมื่อ task ต้องใช้ความรู้ใหม่หรือข้อมูลภายนอก

> Goal: ข้อมูลถูกต้อง ทันสมัย มีแหล่งอ้างอิง

1. ทำ `follow-best-practice` สำหรับ topic, tool หรือ library ที่เกี่ยวข้อง
2. ทำ `/learn-from-web` โดยให้ official docs เป็นแหล่งหลัก (CLI → `/learn-from-cli`, API surface → `/learn-from-references` หรือ `/learn-from-codebase`) — ค้นหาและ scrape ด้วย `/web-search` (delegates กลไกให้ `/follow-tool-crw`; official docs มาก่อนเสมอ และบันทึก URL ที่ใช้จริง)
3. ทำ `deep-research` เมื่อต้อง cross-check หลายแหล่งหรือมีความเสี่ยงสูง
4. ถ้าตรวจสอบข้อมูลสำคัญไม่ได้ → ระบุความไม่แน่นอนและ stop ก่อนเปลี่ยนแปลงที่เสี่ยง

### 4. Analyze Plan And Search

วิเคราะห์ context วางแผน และค้นหา code ก่อนแก้ไข

> Goal: ระบุ root cause, impact, consumers และแผนแก้ไขที่เล็กที่สุด

1. ทำ `report-before-after` เฉพาะงานที่ต้องเทียบสถานะก่อน/หลัง แล้วดำเนินการตาม scope
2. ทำ `follow-deep` เพื่อพิจารณาและเรียก `deep-*` skills ที่เกี่ยวข้องกับ context ของ task
3. ใช้ `use-scripts` เมื่อต้องประมวลผลข้อมูลซับซ้อน
4. ทำ `deep-plan` ก่อนแก้ไขหลายไฟล์ และรายงานแผนในแชทก่อนลงมือ
5. เลือก skill ตาม prefix ของ filename: `analyze-` → `/deep-analyze`, `check-` → check skill, `review-` → review skill, `report-` → report skill
6. ทำ `scan-codebase` เพื่อค้นหา symbols, call sites, consumers — ค้นหาไฟล์/content/AST ด้วย `/code-search` (ripgrep + ast-grep, read-only), ค้นหา git history/commit/blame ด้วย `/git-search`, ค้นหา agent session history และ line attribution ด้วย `/follow-tool-ctx-rs` (`ctx blame`); เลือก skill ให้ตรง target และห้ามใช้แทนกัน
7. ทำ `follow-your-suggestion` เมื่อ task ให้ apply ข้อเสนอจากการวิเคราะห์ก่อนหน้า
8. ถ้าพบ error → ทำ `resolve-errors`; ถ้าต้องตัดสินใจเรื่องเสี่ยงสูงหรือคำตอบต้องมาจาก user → ใช้ `ask-me`

### 5. Write Code

เขียนหรือ refactor โดยรักษา architecture, references และ public API

> Goal: การเปลี่ยนแปลง minimal, runnable, สอดคล้องมาตรฐาน project

1. อ่าน `refactor` ก่อนเขียน code
2. ทำ `follow-architecture` และรักษา existing style; ถ้าเป็นการเปลี่ยนโครงสร้างสำคัญให้เพิ่ม `deep-review`
3. ถ้าแก้ >10 ไฟล์ → ทำ `use-scripts`; ถ้าไฟล์ยาว >250 บรรทัด → ทำ `refactor` หลังจบ task
4. mock ต้องอยู่ใน `mock/` และกำกับด้วย `// MOCK`; งานค้างใช้ `// TODO` เท่าที่จำเป็น
5. ถ้าแก้ skills หรือ `global_rules.md` → ทำ `/update-devin-global-skills` เสมอ และทำ `/use-related-skills` เพื่อตรวจสอบว่า skill อื่นใช้ร่วมหรือขยายได้ ไม่ซ้ำซ้อน; ถ้า `SKILL.md` เรียก skill อื่น → ทำตาม `update-devin-global-skills` (`## Conventions → Invoke Skills`)
6. ถ้าแก้ config → ทำ `follow-default-config`; ถ้าแก้ barrel export → ทำ `deep-review` หรือ `check-code-structure`
7. หลังเขียนหรือ refactor → ทำ `/refactor` structure scope
8. ถ้าแก้ไข ย้าย เปลี่ยนชื่อ หรือลบไฟล์ที่มี references → ทำ `/update-references` เสมอ
9. ถ้าแตะ config/credential → ห้าม hardcode secret; ใช้ env หรือ secret manager และตรวจด้วย `check-secrets` เมื่อเหมาะสม
10. ถ้าเป็น UI/frontend → รันแอปด้วย `run-dev` และตรวจ behavior ด้วย `run-verify`; ถ้าทดสอบ UI ไม่ได้ → ระบุชัดใน report
11. check = lint, typecheck และ scan ของ task นั้น; ถ้า check ไม่ผ่าน → ทำ `resolve-errors` และ recheck สูงสุด 3 รอบ; ถ้ายังไม่ผ่าน → stop และ report

### 6. Validate And Complete

ตรวจสอบ implementation จนผ่านเกณฑ์และพร้อมส่งมอบ

> Goal: ไม่มี implementation gap, regression หรือ validation failure

1. ทบทวนแผนและทำ `loop-until-complete` เมื่อต้องตรวจซ้ำจนผ่าน
2. ทำ `implement-to-production` เฉพาะงาน code ที่มี TODO/MOCK/dead UI
3. ถ้า package manifest เปลี่ยน → ทำ `update-dot-devin`
4. Full path: ทำ `/deep-validate` ก่อนจบ task
5. งาน code: ทำ `run-check` (lint/typecheck/scan) หลังจบ task — test อยู่ใน `run-verify` แล้ว ไม่ต้องรัน `run-test` แยก
6. ทำ `git-commit` เมื่อจบ sub-task สำคัญ งานเสี่ยงสูง หรือเปลี่ยนแปลงจำนวนมาก
7. ทำ `ship` เมื่อ user ขอหรือเป็น Full path; ถ้า validation ไม่ผ่าน → report สถานะและห้ามอ้างว่างานเสร็จ
8. ทำ `/report-progress` ก่อนจบ task เพื่อรายงานความคืบหน้า งานเสร็จ งานค้าง และ next actions
9. ถาม (`ask-me`) เฉพาะเมื่อมี decision ที่ user ต้องเลือก; ถ้าไม่มี → สรุปและจบ

### 7. Report And Communicate

รายงานผลตาม evidence โดยกระชับและตรงสถานะจริง

> Goal: ผู้ใช้ทราบสิ่งที่เปลี่ยน ผลตรวจสอบ ข้อจำกัด และสถานะส่งมอบ

1. เลือกใช้ `report-*` skills ที่เหมาะสมตาม context และสื่อสารเป็นภาษาไทยด้วย bullet points สั้นๆ — เช่น `report`, `report-file-structure`, `report-architecture-diagram`, `report-public-api`, `report-progress`, `report-review`, `report-flow`, `report-before-after`, `report-usage`
2. ไม่เริ่มด้วย acknowledgment phrase และไม่กล่าวอ้างผลที่ยังไม่ตรวจสอบ
3. ถ้าตัดสินใจเรื่องเสี่ยงสูง → ใช้ `ask-me`; ถ้าผู้ใช้ขอ idea → ทำ `idea`
4. ถ้างานไม่สมบูรณ์ → ระบุสิ่งที่ค้าง สาเหตุ และขั้นตอนที่จำเป็น
5. ทุก report table ต้องมีคอลัมน์ "No." เป็นคอลัมน์แรก เรียงลำดับ 1, 2, 3, ... ตามลำดับของแถว โดยเริ่มจาก 1

## Rules

### 1. Structure And Consistency

- เรียง `## Goal` → `## Scope` → `## Execute` → `## Rules` → `## Expected Outcome` ไม่เกิน 250 บรรทัด
- Frontmatter ของ skill package: `name` ตรง directory name lowercase คั่นด้วย `-`, `description` ≤100 ตัวอักษร (ไฟล์ rules นี้ไม่ต้องมี directory ตรงชื่อ)
- Heading ภาษาอังกฤษ Title Case, รายการภาษาไทย, backticks สำหรับ `tools`, `commands`, paths และ skill references
- ทุก section ต้องสอดคล้องกันและให้ผลเหมือนเดิมเมื่อ input เหมือนเดิม
- ถ้า Rules ขัดกับ Execute → Rules ชนะ; ถ้า user สั่งชัดเจน → ทำตาม user เว้นแต่ขัด safety

### 2. Multi-Tool Compatibility

- ตรวจ ecosystem จาก `package.json`, `Cargo.toml`, `go.mod` ก่อนเลือก tools
- ใช้ relative references และแปลง command equivalents ตาม ecosystem ไม่ผูกกับ AI tool เดียว
- ถ้า workspace เป็น monorepo ให้ใช้ run command ของ monorepo (`moon run`, `turbo run`, `pnpm --recursive`, `bun run --filter` ตามที่ตรวจพบ) กับ skills `run-*` ต่างๆ แทนการรันผ่าน workspace เดี่ยว
- ใช้ `use-*` skills สำหรับ tools/libraries เฉพาะเจาะจง และใช้ official docs เป็นแหล่งหลัก
- ก่อนเลือก dependencies หรือ libraries ใหม่ ให้ทำ `/follow-my-techstack` (อ่าน canonical catalog ที่ `skills/follow-my-techstack/references/techstack-catalog.md`) เพื่อตรวจสอบว่าสอดคล้องกับ tech stack ที่กำหนดไว้ และทำ `/use-lib-effective` เพื่อใช้ dep ที่มีอยู่แทนการ reinvent
- ถ้าต้องติดตั้ง program แบบ global ให้พยายามใช้ `mise use -g <program>` ก่อน แล้วจึงพิจารณา package manager ของระบบ เช่น `scoop`, `brew`, `apt`, `winget`
- หลีกเลี่ยงการโหลด skill ทั้งหมดเข้าบริบท; โหลดเฉพาะที่ task ต้องใช้ (ดู `follow-context-engineering`)

### 3. Safety And Deterministic Execution

- การลบ ย้าย overwrite หรือ action เสี่ยงสูงต้องมี dry run และ user confirmation ก่อนดำเนินการ
- push, สร้าง/ปิด PR หรือ issue, deploy, ส่งข้อความ และการเปลี่ยน shared state ต้องขอ confirmation และระบุ scope ก่อนทำ
- ห้าม hardcode หรือ commit secret; ใช้ env/secret manager และตรวจด้วย `check-secrets` เมื่อแตะ config
- เรียง Foundation → Dependencies → High impact → Critical path → High risk เพื่อ fail fast ลด rework
- ใช้เงื่อนไข "ถ้ามี..." เฉพาะ steps ที่ไม่จำเป็นทุก task และระบุเกณฑ์ผ่าน/ไม่ผ่านที่วัดผลได้
- รันซ้ำด้วย input/state เดิมต้องได้ output เดิม ไม่สร้าง side effects ซ้ำ

### 4. High Impact Content

- เก็บเฉพาะข้อกำหนดที่ทำให้ผลลัพธ์เปลี่ยนอย่างมีนัยสำคัญ ครอบคลุม impact สำคัญทั้งหมด
- ทุก instruction ต้องระบุ action, condition หรือ expected result ที่ตีความได้ทางเดียว
- ห้ามใช้ placeholder, generic filler, mock หรือ TODO ที่ไม่จำเป็น

### 5. Skill And Subagent Discipline

- พยายามเรียกใช้งานผ่าน `/follow-agents-md` ก่อน ถ้า `AGENTS.md` ระบุ workflow
- ถ้างานมี subtasks อิสระหลายด้าน → ใช้ `/update-devin-global-subagents` หรือ `/use-subagents` ตาม context
- ห้ามเรียกใช้ skills หรือ subagents ที่ไม่เกี่ยวข้องกับ task
- ถ้าไม่แน่ใจว่าควรใช้ skill ใด → ทำ `/ask-me`
- ก่อนเรียก runner ที่รัน app/test (`run-dev`, `run-verify`, `deep-test`) → ทำ `review-*` หรือ `check-*` ที่ตรง domain ก่อนเสมอ; กฎนี้ไม่ครอบคลุม `run-check` ซึ่งเป็น gate ตรวจสอบ
- ถ้า skill ที่อ้างถึงไม่มีจริง → ใช้ตัวที่ใกล้ที่สุดใน family เดียวกันและระบุใน report; ห้ามเดาชื่อ skill ใหม่

### 6. Reference Discipline

- ถ้าแก้ไข ย้าย เปลี่ยนชื่อ หรือลบไฟล์/ skill → ทำ `/update-references` เสมอ แล้ว verify ว่าไม่มี references เก่าเหลือ
- ถ้าไฟล์ที่แก้ไม่มี references → ไม่ต้องทำ `/update-references`
- หลัง rename skill หรือ workflow → อัปเดต `AGENTS.md`, `related`, และ `global_rules.md` ทันที

### 7. Prompt Question Handling

- ถ้า prompt มีคำถามที่ต้องให้ user ตัดสินใจก่อนจึงจะเริ่มงานได้ → ใช้ `/ask-me` เป็น prompt ให้ user เลือก/ตอบ ไม่ใช่ตอบแทน user
- ถ้าคำตอบอยู่ในไฟล์/repo/บทสนทนา → ตอบก่อนโดยไม่ต้องถาม
- ต้องตอบคำถามทั้งหมดให้ครบก่อนจึงจะเริ่มทำงาน
- ถ้า prompt มีทั้งคำถามและคำสั่งงาน ให้ถามเฉพาะข้อที่จำเป็น แล้วค่อยลงมือ
- ถ้า session เปิด `/dont-ask-me` mode → ทุก `/ask-me` และ `ask_user_question` ใน rules และ skills ทั้งหมดถูก override ด้วย `/follow-your-suggestion` + safe default จนจบ session — ทำงานค่อยเป็นค่อยไปทีละ step แบบ safe ห้ามข้าม และวนด้วย `/loop-until-complete`

### 8. In-Chat Answers And Report Skills

- เมื่อตอบคำถามหรืออธิบายผลในแชท ให้ระบุ `report-*` skills ที่ user สามารถใช้ดูผลลัพธ์อย่างเป็นระบบ
- สั้นๆ ตอบสาระสำคัญ แล้วชี้ไปยัง `/report-file-structure`, `/deep-plan` ฯลฯ ตาม context
- ไม่ตอบยาวเกินจำเป็นในแชทถ้ามี report skill ที่รองรับ
- ถ้าผู้ใช้ถามหรือต้องการคำตอบโดยยังไม่ลงมือทำ ให้ใช้ `/report-todo` ตอบในรูปแบบตาราง No., Action, Before, After, Why, File Change, Risk พร้อมสรุป `/report numbered` ด้านล่าง

### 9. New Request While Old Work Is Pending

- ถ้างานเดิมยังไม่เสร็จ และมี request ใหม่เข้ามา ให้ทำงานเดิมให้เสร็จก่อน แล้วจึงทำงานใหม่
- ยกเว้น request ใหม่หักล้างหรือทำให้งานเดิมไม่มีความจำเป็นอีกต่อไป → ให้ใช้ `/rethink` แล้วทำงานใหม่แทน
- ถ้าไม่แน่ใจว่า request ใหม่หักล้างงานเดิมหรือไม่ → ใช้ `/ask-me` ถาม user ก่อน

### 10. User Intent For Features

- เมื่อผู้ใช้บอกว่าอยากทำอะไร หรืออยากได้ features อะไร → ใช้ `/suggest-next-action` หรือ `/ask-me` เพื่อถามความต้องการก่อน
- ถามคำถามเหมือนกับ `/idea-features` แต่ไม่ต้องสร้าง report files
- ไม่เริ่ม implement หรือสร้าง plan ทันที จนกว่าผู้ใช้จะยืนยัน
- ถ้าผู้ใช้ยืนยันแล้ว → ส่งต่อไปยัง `/idea-features`, `/implement-to-production` หรือ `/create-github-issue` ตาม context

### 11. Link/URL Handling

- ถ้าผู้ใช้ส่ง link หรือ URL มา และไม่แน่ใจว่าคือ project หรือไฟล์อะไร → ใช้ `/search-project-in-drive-d` เพื่อหา project ที่ตรงกับ link ใน `D:\` หรือ workspace ปัจจุบัน
- ถ้าไม่พบใน `D:\` → ใช้ `/search-skills` หรือค้นหาใน `devin-skills` เพื่อหา references ที่เกี่ยวข้อง
- ถ้ายังไม่ชัดเจน → ใช้ `/ask-me` ถาม user ก่อนตอบ

### 12. Global Skills Standards

- ถ้าแก้ไข สร้าง ย้าย merge หรือลบ skill ใน `%APPDATA%\devin\skills` → ทำ `/update-devin-global-skills` เสมอ และอัปเดต root `AGENTS.md` ของ repo ให้ sync ทันที (skill counts, family lists, related, merged notes) — `AGENTS.md` คือ root skill descriptor ของ `devin-global-skills`
- skill ใน global skills ใช้ภาษาไทยสำหรับเนื้อหา แต่คงคำศัพท์เทคนิค เช่น `git`, `lint`, `AST`, `CLI`, `JSON`, skill names, tool names, commands, paths ไว้เป็นภาษาอังกฤษ
- project-local skills ใช้ภาษาอังกฤษทั้งหมด
- ถ้า skill ใน global skills มีเนื้อหาเป็นภาษาอังกฤษทั้งหมด ให้แปลเป็นภาษาไทยโดยรักษาคำศัพท์เทคนิค
- canonical copy ของไฟล์ rules นี้อยู่ที่ `D:/wrikka-harness/global-rules/AGENTS.md`; หลังแก้ต้อง sync ไปยัง client copy ทันที

## Expected Outcome

- ลำดับ prepare → read → research → analyze → write → validate → report อย่างชัดเจน
- ทุก task ใช้ references ที่มีอยู่จริง แก้ไขปลอดภัย ตรวจสอบผลได้ รายงานตาม evidence
- รองรับหลาย workspace, ecosystems และ AI tools โดยไม่ทำลาย backward compatibility
