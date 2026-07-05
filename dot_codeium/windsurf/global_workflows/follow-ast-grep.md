---
title: Follow Ast Grep
description: ตั้งค่าและใช้งาน ast-grep สำหรับ code search, lint และ transformation ด้วย AST patterns
auto_execution_mode: 3
url: https://ast-grep.github.io/
related_workflows:
  - /follow-best-practice
  - /deep-research
  - /write-windsurf-global-workflows
---

## Goal

ตั้งค่าและใช้งาน ast-grep สำหรับ code search, lint และ refactoring ด้วย AST-based patterns ที่แม่นยำกว่า regex

## Scope

ครอบคลุมการตั้งค่า `sgconfig.yml`, การเขียน rules, การ scan, test, และใช้งาน CLI commands ของ ast-grep

## Execute

### 1. Install Or Use ast-grep

1. ถ้า project มี `@ast-grep/cli` ใน `devDependencies` ให้ใช้ `bunx ast-grep`
2. ถ้าไม่มี ใช้ `bunx ast-grep` ได้โดยตรงโดยไม่ต้องติดตั้ง
3. ถ้าต้องการใช้งานประจำ แนะนำให้เพิ่ม `@ast-grep/cli` ใน `devDependencies`

### 2. Configure sgconfig.yml

1. สร้างไฟล์ `sgconfig.yml` ที่ root directory ด้วยเนื้อหาตาม ## Rules ข้อ 2
2. ถ้า project มีหลาย workspace ให้เพิ่ม `devPaths` สำหรับแต่ละ workspace
3. ถ้า project มี custom file extensions ให้เพิ่ม `languageGlobs`
4. ถ้าต้องการ test rules ให้เพิ่ม `testConfigs`
5. ถ้าต้องการ reusable patterns ให้เพิ่ม `utilDirs`
6. ตรวจสอบว่า config ถูกต้องด้วย `bunx ast-grep scan --inspect summary`

### 3. Setup Project Structure

1. สร้าง directory `rules/` สำหรับเก็บ ast-grep rules
2. ถ้ามี `testConfigs` ให้สร้าง directory `rule-tests/`
3. ถ้ามี `utilDirs` ให้สร้าง directory `utils/`
4. ใช้ `bunx ast-grep new` สำหรับ scaffold project ใหม่ได้

### 4. Write Rules

1. ใช้ `bunx ast-grep new rule` สำหรับสร้าง rule ใหม่
2. เขียน rule ตาม structure ใน ## Rules ข้อ 3
3. ใช้ `pattern` สำหรับ simple matching, `kind` สำหรับ AST node type matching
4. ใช้ `constraints` สำหรับ filter meta variables เพิ่มเติม
5. ใช้ `any`, `all`, `not` สำหรับ combinator patterns
6. ระบุ `severity` เป็น `error`, `warning`, `info`, `hint` หรือ `off`
7. เขียน `message` กระชับและชัดเจน
8. ถ้าต้องการ auto-fix ให้เพิ่ม `fix` ใน rule

### 5. Add Scan Script

1. เพิ่ม script ใน `package.json`:

```json
{
  "scripts": {
    "scan": "bunx ast-grep scan"
  }
}
```

2. ถ้ามี `@ast-grep/cli` ติดตั้งแล้ว ใช้ `ast-grep scan` แทน `bunx ast-grep scan`

### 6. Scan And Test Rules

1. รัน `bun run scan` สำหรับ scan ทั้ง project
2. รัน `bunx ast-grep test` สำหรับ test rules ถ้ามี `testConfigs`
3. รัน `bunx ast-grep run --pattern 'PATTERN'` สำหรับ ad-hoc search
4. รัน `bunx ast-grep scan --json pretty` สำหรับ structured output
5. รัน `bunx ast-grep scan --filter 'RULE_ID'` สำหรับ filter rules
6. ใช้ `--interactive` สำหรับ interactive edit session

## Rules

### 1. CLI Commands

- `bunx ast-grep new` สำหรับ scaffold project ใหม่
- `bunx ast-grep new rule` สำหรับสร้าง rule ใหม่
- `bunx ast-grep scan` สำหรับ scan ทั้ง project ด้วย rules ที่กำหนด
- `bunx ast-grep run --pattern 'PATTERN'` สำหรับ ad-hoc search
- `bunx ast-grep test` สำหรับ test rules
- `--config <path>` สำหรับระบุ config path
- `--json pretty` สำหรับ structured JSON output
- `--filter 'REGEX'` สำหรับ filter rules by id
- `--interactive` สำหรับ interactive edit session
- `--update-all` สำหรับ apply all rewrites
- `--format github` สำหรับ GitHub Action format output

### 2. sgconfig.yml Configuration

- `ruleDirs`: list ของ directories สำหรับเก็บ rules (required)
- `testConfigs`: list ของ test config objects มี `testDir` และ `snapshotDir`
- `utilDirs`: list ของ directories สำหรับ reusable utility rules
- `languageGlobs`: mapping ภาษากับ custom file extensions
- `languageAliases`: mapping file extension กับภาษา
- `devPaths`: list ของ source directories สำหรับ development
- `customLanguages`: mapping สำหรับ custom tree-sitter languages
- ทุก paths ใน config จะถูก resolve โดย relative กับ `sgconfig.yml`

### 3. Rule File Structure

- `id`: unique identifier เช่น `no-console-log` (required)
- `language`: ภาษาของ code เช่น `TypeScript`, `JavaScript`, `Tsx` (required)
- `rule`: pattern object สำหรับ matching (required)
  - `pattern`: code pattern พร้อม meta variables เช่น `console.log($$$ARGS)`
  - `kind`: AST node type เช่น `function_declaration`
  - `regex`: regex pattern สำหรับ string matching
  - `any`: list ของ rules ที่ match อย่างน้อย 1 rule
  - `all`: list ของ rules ที่ต้อง match ทั้งหมด
  - `not`: rule ที่ต้องไม่ match
- `constraints`: filter meta variables เพิ่มเติม ใช้กับ `$ARG` ไม่ใช่ `$$$ARGS`
- `utils`: dictionary ของ local utility rules
- `severity`: `error`, `warning`, `info`, `hint`, `off`
- `message`: ข้อความกระชับอธิบายปัญหา
- `note`: คำอธิบายเพิ่มเติม สามารถใช้ markdown ได้
- `fix`: pattern สำหรับ auto-fix
- `files`: glob patterns สำหรับระบุไฟล์ที่ rule ใช้
- `ignores`: glob patterns สำหรับยกเว้นไฟล์
- ใช้ `$ARG` สำหรับ single meta variable, `$$$ARGS` สำหรับ multiple
- ใช้ `---` สำหรับแยกหลาย rules ในไฟล์เดียว

### 4. Pattern Syntax

- `$ARG`: จับ single node
- `$$$ARGS`: จับ multiple nodes
- `pattern`: ใช้ code snippet พร้อม meta variables
- `kind`: ใช้ AST node type name
- `regex`: ใช้ regex บน source text
- `any`/`all`/`not`: combinator สำหรับ complex matching
- `constraints`: filter หลังจาก match `rule` แล้ว

### 5. Project Structure

- สร้าง `rules/` directory สำหรับเก็บ rule files
- ถ้ามี `testConfigs` สร้าง `rule-tests/` directory
- ถ้ามี `utilDirs` สร้าง `utils/` directory
- rule files ใช้ `kebab-case` filename
- ไฟล์ที่ไม่ใช่ rule ใน `rules/` จะถูก ignore

### 6. Scan Script

- มี `scan` script ใน `package.json`
- ใช้ `bunx ast-grep scan` หรือ `ast-grep scan` ถ้าติดตั้งแล้ว
- ถ้า project มี `@ast-grep/cli` ใน `devDependencies` ให้ใช้ `ast-grep scan` โดยตรง

### 7. Integration With Biome

- ใช้ `ast-grep` สำหรับ structural patterns ที่ `Biome` ไม่สามารถ express ได้
- `ast-grep`  complements `Biome` ไม่ใช่ replace
- ใช้ `ast-grep` สำหรับ custom lint rules เฉพาะ project
- ใช้ `Biome` สำหรับ standard lint และ format

## Expected Outcome

- `sgconfig.yml` ตั้งค่าเรียบร้อยครบทุก fields ที่จำเป็น
- Project structure สร้างเรียบร้อย (`rules/`, `rule-tests/`, `utils/`)
- Rules เขียนตาม structure มาตรฐานและมี test cases
- Scan script เพิ่มใน `package.json` และทำงานได้
- `ast-grep scan` ทำงานได้ถูกต้องและ report ผลลัพธ์
- ใช้ร่วมกับ `Biome` ได้โดยไม่ขัดแย้ง

