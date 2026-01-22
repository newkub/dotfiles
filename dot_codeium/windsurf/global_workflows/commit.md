---
trigger: always_on
description: analyze changes และ split commits ไปเรื่อยๆ จนไม่มีอะไรให้ commit แล้ว
goal:
  - analyze changes ทั้งหมดใน working directory
  - จัดกลุ่ม changes ตามหัวข้อและความสัมพันธ์
  - split commits ไปเรื่อยๆ ตามหัวข้อที่แยกแล้ว
  - เขียน commit messages ที่มีคุณภาพสำหรับแต่ละ commit
  - commit ไปเรื่อยๆ จนไม่มีไฟล์เหลือ
  - ตรวจสอบว่าไม่มีอะไรให้ commit แล้ว
instruction:
  - analyze changes ทั้งหมดใน working directory
  - จัดกลุ่ม changes ตามหัวข้อและความสัมพันธ์
  - split commits ไปเรื่อยๆ ตามหัวข้อที่แยกแล้ว
  - เขียน commit messages ที่มีคุณภาพสำหรับแต่ละ commit
  - commit ไปเรื่อยๆ จนไม่มีไฟล์เหลือ
  - ตรวจสอบว่าไม่มีอะไรให้ commit แล้ว
condition:
  - ใช้เมื่อมีไฟล์ที่เปลี่ยนแปลงหลายไฟล์
  - ใช้เมื่อต้องการ split commits ตามหัวข้อ
  - ใช้เมื่อต้องการ commit ไฟล์ทั้งหมด
  - ใช้เมื่อต้องการจัดการ commits ให้เป็นระเบียบ
input:
  - ไฟล์ที่เปลี่ยนแปลงใน working directory
output:
  - commits ที่ split ตามหัวข้อ
  - commit messages ที่มีคุณภาพ
  - working directory ที่สะอาด (ไม่มีไฟล์เหลือให้ commit)
outcome:
  - ทุกไฟล์ถูก commit และไม่มีอะไรให้ commit แล้ว
  - commits ถูกจัดกลุ่มตามหัวข้ออย่างเป็นระบบ
  - commit messages มีคุณภาพและติดตามได้ง่าย
---

# Commit แยกตามหัวข้อและ Commit ไปเรื่อยๆ จนไม่มีเหลือ

## Phase 1: Analyze Changes

### 1. ตรวจสอบสถานะ Changes

#### 1.1 ดู changes ทั้งหมด
```bash
git status
```

#### 1.2 ดู diff ของไฟล์ที่แก้ไข
```bash
# ดู diff ที่ยังไม่ stage (unstaged changes)
git diff

# ดู diff ที่ stage แล้ว (staged changes)
git diff --staged
# หรือ
git diff --cached

# ดู diff ทั้งหมด (staged + unstaged) เทียบกับ HEAD
git diff HEAD

# ดู diff เฉพาะไฟล์ที่ระบุ
git diff <file_path>
git diff --staged <file_path>

# ดู stat เพื่อดูขนาดการเปลี่ยนแปลง
git diff --stat
git diff --staged --stat

# ดู diff เปรียบเทียบกับ commit ที่ระบุ
git diff <commit> HEAD
git diff <commit> <file_path>
```

**เคล็ดลับการดู diff:**
- เริ่มดู `git diff --stat` เพื่อดูภาพรวมขนาดการเปลี่ยนแปลง
- ดู `git diff HEAD --stat` เพื่อดู changes ทั้งหมดที่จะ commit
- ใช้ `git diff --staged` เพื่อตรวจสอบว่าไฟล์ที่จะถูก commit ถูกต้อง
- ดู diff แต่ละไฟล์เพื่อวิเคราะห์เนื้อหาการเปลี่ยนแปลงอย่างละเอียด

---

### 2. Analyze และจัดกลุ่ม Changes

#### 2.1 ระบุหัวข้อหลักของ changes
- ANALYZE รายการไฟล์ที่เปลี่ยนแปลง
- GROUP ไฟล์ตามหัวข้อหรือฟีเจอร์
- IDENTIFY ความสัมพันธ์ระหว่าง changes

#### 2.2 กำหนดหัวข้อแยก
แยก changes ตามประเภท:
- **Feature**: ฟีเจอร์ใหม่หรือการเพิ่มฟังก์ชัน
- **Fix**: แก้ไข bug หรือปัญหา
- **Refactor**: ปรับปรุงโครงสร้างโค้ดโดยไม่เปลี่ยนพฤติกรรม
- **Test**: เพิ่มหรือแก้ไข tests
- **Config**: การตั้งค่าหรือ configuration
- **Docs**: เอกสารหรือ comments
- **Chore**: งานทั่วไป เช่น อัปเดต dependencies

#### 2.3 สร้างรายการ commits ย่อย
สำหรับแต่ละหัวข้อ:
- ระบุไฟล์ที่เกี่ยวข้อง
- กำหนด commit message ที่ชัดเจน
- ตรวจสอบ dependencies ระหว่าง commits

---

## Phase 2: Split Commits ไปเรื่อยๆ

### 3. Commit ทีละกลุ่ม

#### 3.1 กำหนดลำดับการ commit
เรียงลำดับการ commit ตามลำดับความสำคัญ:
1. **Config files** → commit ก่อนเสมอ (เพราะเป็น foundation)
2. **Dependencies** → commit หลังจาก config
3. **Source code** → commit ตามฟีเจอร์หรือ module
4. **Tests** → commit ตาม source code ที่เกี่ยวข้อง
5. **Documentation** → commit สุดท้าย

#### 3.2 Commit กลุ่มแรก
```bash
git add <ไฟล์หรือโฟลเดอร์>
git commit -m "<commit message>"
```

#### 3.3 เขียน commit message ที่มีคุณภาพ

##### รูปแบบ Conventional Commit
```
<type>(<scope>): <subject>

<body>

<footer>
```

##### Type ที่ใช้
**Type ที่ใช้บ่อย:**
- `feat` - ฟีเจอร์ใหม่
- `fix` - แก้ไข bug
- `refactor` - refactor โค้ด
- `chore` - งานทั่วไป

**Type อื่นๆ:**
- `docs` - เอกสาร
- `style` - การจัดรูปแบบ
- `test` - เพิ่มหรือแก้ไข test
- `perf` - ปรับปรุงประสิทธิภาพ
- `ci` - CI/CD configuration
- `build` - build system หรือ dependencies
- `revert` - ย้อนกลับ commit

##### Scope
- ระบุ package/module ที่เกี่ยวข้อง
- ใช้ lowercase และ kebab-case
- ถ้าไม่มี scope ที่ชัดเจน ให้ข้าม

**ตัวอย่าง scope:**
- `terminal` - terminal emulator
- `rust-utils` - utility functions package
- `editor` - code editor
- `command-palette` - command palette feature
- `workspace` - workspace configuration

##### Subject
- เขียนด้วย present tense ("add" ไม่ใช่ "added")
- ขึ้นต้นด้วยตัวพิมพ์เล็ก
- ไม่ต้องมีจุดท้ายประโยค
- กระชับและชัดเจน (ไม่เกิน 50 ตัวอักษร)

**ตัวอย่างที่ถูกต้อง:**
- `add PTY session management`
- `resolve memory leak in cache`
- `split long files into smaller modules`
- `update git2 dependency to v0.20.3`

##### Body
- อธิบายรายละเอียดเพิ่มเติม
- ใช้ bullet points แสดงรายการ
- อธิบาย "ทำไม" และ "อย่างไร" ไม่ใช่เพียง "อะไร"
- แต่ละบรรทัดไม่เกิน 72 ตัวอักษร

##### Footer
- อ้างอิง issues: `Closes #123`, `Fixes #456`
- Breaking changes: `BREAKING CHANGE: ...`
- Co-authored: `Co-authored-by: ...`

##### ตัวอย่าง Commit Message ที่ดี

**Feature:**
```
feat(terminal): add PTY session management

- Implement session lifecycle management
- Add session state tracking
- Support multiple concurrent sessions
- Add session persistence

Closes #123
```

**Fix:**
```
fix(rust-utils): resolve memory leak in memoization cache

- Fix cache eviction logic
- Add proper cleanup on drop
- Add unit tests for cache lifecycle

Fixes #456
```

**Refactor:**
```
refactor(command-palette): split long files into smaller modules

- Extract item_card from item_list (311 → 54 lines)
- Extract detail_sections from detail_panel (340 → 25 lines)
- Extract plugin_loader from bun_extension_provider (162 → 86 lines)
- Update module exports and imports

Improves maintainability and testability
```

**Chore:**
```
chore(workspace): update git2 dependency to v0.20.3

- Update git2 to resolve libgit2-sys conflict
- Update git-workflow to use compatible version
- Update Cargo.lock

Resolves workspace-level dependency conflict
```

##### กฏสำคัญ
- ใช้ภาษาอังกฤษเสมอ
- ใช้ imperative mood (เช่น "add", "fix", "update" ไม่ใช่ "added", "fixed")
- อธิบายสิ่งที่ทำและทำไม
- โฟกัสที่หัวข้อเดียวต่อ commit
- ใช้ type ที่เหมาะสม

##### แก้ไข commit message ถ้าผิด
```bash
# ยังไม่ได้ push
git commit --amend -m "<corrected message>"

# แก้ commit ที่เก่ากว่า (interactive rebase)
git rebase -i HEAD~<n>
```

---

#### 3.4 ทำซ้ำจนครบทุกกลุ่ม
- เลือกกลุ่มถัดไป
- Add → Commit
- ทำซ้ำจนกว่าจะไม่มีไฟล์เหลือ

---

## Phase 3: ตรวจสอบและทำซ้ำ

### 5. ตรวจสอบความสมบูรณ์

#### 5.1 ตรวจสอบว่าไม่มีไฟล์เหลือ
```bash
git status
```
ต้องได้ผลลัพธ์: `nothing to commit, working tree clean`

#### 5.2 ถ้ายังมีไฟล์เหลือ
- กลับไขวน Phase 1
- Analyze ไฟล์ที่เหลือ
- Split commits ต่อจนครบ

---

### 6. การจัดการกรณีพิเศษ

#### 6.1 ไฟล์ที่ไม่ควร commit
ถ้าพบไฟล์ที่ไม่ควร commit:
- เพิ่มเข้า `.gitignore`
- รัน `git rm --cached <ไฟล์>` (ถ้าถูก track อยู่แล้ว)
- Commit การแก้ไข `.gitignore`

#### 6.2 ไฟล์ที่เปลี่ยนแปลงเยอะมาก
ถ้าไฟล์เปลี่ยนแปลงเยอะมาก:
- พิจารณาแยกเป็นหลาย commits ตามลำดับการเปลี่ยนแปลง
- ใช้ `git add -p` เพื่อ add ทีละ hunk
- Commit ทีละส่วนที่มีความหมาย

#### 6.3 ไฟล์ที่เกี่ยวข้องกับหลายฟีเจอร์
ถ้าไฟล์เดียวเกี่ยวข้องกับหลายฟีเจอร์:
- ใช้ `git add -p` เพื่อแยกส่วนที่เกี่ยวข้องกับแต่ละฟีเจอร์
- Commit แต่ละส่วนเป็น commit แยกกัน

---

## Phase 4: การเสร็จสิ้น (Completion)

### 7. ตรวจสอบผลลัพธ์สุดท้าย

#### 7.1 ตรวจสอบ commits ใหม่
```bash
git log origin/main..HEAD --oneline
```

#### 7.2 ตรวจสอบแต่ละ commit
```bash
git show HEAD
git show HEAD~1
git show HEAD~2
```

#### 7.3 ตรวจสอบว่าครบทุกหัวข้อ
- VERIFY ว่าทุกหัวข้อถูกแยกเป็น commit แยก
- CHECK ว่า commit messages มีคุณภาพ
- ENSURE ว่าไม่มี changes ที่ถูกลืม

#### 7.4 ตรวจสอบว่าไม่มีอะไรให้ commit แล้ว
```bash
git status
```
ต้องได้ผลลัพธ์: `nothing to commit, working tree clean`

---

### 8. สรุปผลลัพธ์

#### 8.1 รายงานจำนวน commits
- รายงานจำนวน commits ที่สร้าง
- รายงานจำนวนไฟล์ที่ถูก commit
- รายงานหัวข้อของแต่ละ commit

#### 8.2 ตัวอย่างผลลัพธ์
```
✅ สร้าง 5 commits:
  1. chore: update dependencies
  2. feat(command-palette): add keyboard navigation
  3. refactor(command-palette): extract provider macros
  4. test(command-palette): add unit tests
  5. docs(readme): update installation instructions

✅ Commit ไฟล์ทั้งหมด 12 ไฟล์
✅ ไม่มีอะไรให้ commit แล้ว
```

---

## ตัวอย่างการใช้งาน

### สถานการณ์: มีไฟล์เปลี่ยนแปลงหลายไฟล์

```
git status
# Modified: src/auth.ts, src/login.vue
# Modified: package.json
# Modified: README.md
```

**ขั้นตอน:**
1. Analyze ไฟล์ทั้งหมด → แยกเป็น 3 กลุ่ม:
   - Config: package.json
   - Feature: src/auth.ts, src/login.vue
   - Docs: README.md

2. Commit `package.json` ก่อน:
   ```
   git add package.json
   git commit -m "chore: update dependencies"
   ```

3. Commit ไฟล์ auth รวมกัน:
   ```
   git add src/auth.ts src/login.vue
   git commit -m "feat: add login functionality"
   ```

4. Commit README:
   ```
   git add README.md
   git commit -m "docs: update documentation"
   ```

5. ตรวจสอบ:
   ```
   git status
   # nothing to commit, working tree clean
   ```

---

## หมายเหตุ

- **ห้าม commit ไฟล์ทั้งหมดใน commit เดียว** ถ้าไม่เกี่ยวข้องกัน
- **ใช้ commit message ที่ชัดเจน** เพื่อให้ติดตามประวัติได้ง่าย
- **commit ทีละกลุ่ม** ที่มีความหมายเดียวกัน
- **ตรวจสอบทุกครั้ง** ก่อน commit ว่าไฟล์ถูกต้อง
- **ทำซ้ำจนไม่มีอะไรให้ commit แล้ว** ก่อนจบงาน