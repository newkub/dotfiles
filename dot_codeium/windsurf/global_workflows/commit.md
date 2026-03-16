---
title: Commit
description: Commit โค้ดด้วย conventional commits format พร้อม validation
auto_execution_mode: 3
file-patterns:
  - "**/*"
follow:
  skills:
    - "@git"
  workflows:
    - "/validate"
  files:
    - "guidelines/conventional-commits.md"
---

## Purpose

Commit โค้ดที่แก้ไขด้วย conventional commits format ที่ถูกต้อง พร้อม validation ก่อน commit

## Scope

- ใช้กับการ commit โค้ดทุกประเภทใน repository
- รองรับการ commit แบบ conventional commits
- รวมถึง validation ก่อน commit (linter, tests)
- ไม่รวมการ push หรือ merge

## Inputs

| Input | รายละเอียด |
|-------|-----------|
| Staged Changes | ไฟล์ที่ถูก `git add` แล้ว |
| Commit Type | feat, fix, refactor, perf, test, chore, docs |
| Commit Message | คำอธิบายสั้นๆ ที่สื่อความหมาย |
| Scope | (optional) ส่วนของโค้ดที่เปลี่ยนแปลง |

## Rules

### Commit Message Standards

| หมวด | ข้อกำหนด |
|------|---------|
| **Type** | ต้องเป็นหนึ่งใน: feat, fix, refactor, perf, test, chore, docs |
| **Scope** | (optional) ระบุส่วนของโค้ด เช่น api, ui, core |
| **Description** | สั้น กระชับ สื่อความหมาย ไม่เกิน 72 ตัวอักษร |
| **Body** | (optional) อธิบายเพิ่มเติมเมื่อจำเป็น |
| **Footer** | (optional) ใช้สำหรับ breaking changes หรือ issue references |

### Validation Standards

| หมวด | ข้อกำหนด |
|------|---------|
| **Linter** | ต้องผ่านก่อน commit (ถ้ามี linter ในโปรเจกต์) |
| **Tests** | ต้องผ่านก่อน commit (ถ้ามี tests ที่เกี่ยวข้อง) |
| **Clean Code** | ไม่มี console.log หรือ debug code ที่ลืมลบ |

### Quality Standards

| หมวด | ข้อกำหนด |
|------|---------|
| **Atomic** | แต่ละ commit ควรทำสิ่งเดียว |
| **Reversible** | Commit ต้องสามารถ revert ได้ |
| **Meaningful** | Message ต้องสื่อให้เข้าใจว่าทำอะไร |

## Structure

### Conventional Commits Format

```text
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**ตัวอย่าง:**

- `feat(auth): add JWT token validation`
- `fix(api): resolve null pointer in user endpoint`
- `refactor(core): extract database layer`
- `test(utils): add unit tests for helpers`

### Phase Definitions

| Phase | คำอธิบาย | กิจกรรมหลัก |
|-------|---------|------------|
| **Setup** | เตรียม context | ตรวจสอบ staged changes |
| **Research** | ศึกษา changes | ดู diff ที่จะ commit |
| **Analyze** | วิเคราะห์ | กำหนด type และ scope |
| **Plan** | วางแผน | เตรียม commit message |
| **Execute** | ลงมือทำ | รัน validation และ commit |
| **Verify** | ตรวจสอบ | ยืนยัน commit สำเร็จ |
| **Review** | ประเมิน | ตรวจสอบ commit log |
| **Finalize** | ปิดงาน | สรุปผล |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Staged Changes**
  - รัน `git status` เพื่อดูสถานะ
  - ยืนยันว่ามีไฟล์ที่ `git add` แล้ว
  - ยืนยันว่าอยู่ใน git repository

- 0.2 **เข้าใจ Conventional Commits**
  - รู้จัก type: feat, fix, refactor, perf, test, chore, docs
  - เข้าใจ format: `type(scope): description`
  - เข้าใจ breaking changes format

### Phase 1: Setup

- 1.1 **ตรวจสอบ Staged Changes**
  - รัน `git status` เพื่อดูสถานะ
  - รัน `git diff --cached --stat` เพื่อดู changes ที่จะ commit
  - ยืนยันว่า staged changes ถูกต้อง

### Phase 2: Research

- 2.1 **ศึกษา Changes**
  - อ่าน diff ที่จะ commit เพื่อเข้าใจสิ่งที่เปลี่ยนแปลง
  - ระบุไฟล์หลักที่ถูกแก้ไข
  - ทำความเข้าใจ impact ของ changes

### Phase 3: Analyze

- 3.1 **กำหนด Commit Type**
  - `feat`: เพิ่ม feature ใหม่
  - `fix`: แก้ไข bug
  - `refactor`: เปลี่ยนโครงสร้างโค้ด ไม่เปลี่ยน behavior
  - `perf`: ปรับปรุง performance
  - `test`: เพิ่ม/แก้ไข tests
  - `chore`: งาน maintenance, dependencies
  - `docs`: แก้ไข documentation

- 3.2 **กำหนด Scope**
  - ระบุส่วนของโค้ดที่เปลี่ยนแปลง (เช่น api, ui, core, utils)
  - ใช้ scope ที่สื่อความหมาย
  - ถ้าไม่แน่ใจ อาจข้าม scope ได้

### Phase 4: Plan

- 4.1 **เตรียม Commit Message**
  - เขียน description ที่กระชับและสื่อความหมาย
  - ตรวจสอบความยาวไม่เกิน 72 ตัวอักษร
  - เตรียม body ถ้าจำเป็นต้องอธิบายเพิ่มเติม

- 4.2 **ระบุ Breaking Changes**
  - ตรวจสอบว่ามี breaking changes หรือไม่
  - ถ้ามี เตรียม footer `BREAKING CHANGE:`
  - ระบุสิ่งที่ต้องเปลี่ยนแปลงสำหรับผู้ใช้

### Phase 5: Execute

- 5.1 **รัน Validation**
  - รัน linter: `bun run lint` (ถ้ามี)
  - รัน tests ที่เกี่ยวข้อง: `bun test` (ถ้ามี)
  - ตรวจสอบว่าไม่มี console.log ที่ลืมลบ
  - แก้ไขปัญหาที่พบก่อน commit

- 5.2 **สร้าง Commit**
  - ใช้ format: `type(scope): description`
  - ถ้ามี breaking changes เพิ่ม footer
  - ตัวอย่าง:

    ```powershell
    git commit -m "refactor(api): split hot reload into separate module"

    # ถ้ามี breaking changes
    git commit -m "refactor(api): restructure api module

    BREAKING CHANGE: API endpoints moved to /api/v2/"
    ```

### Phase 6: Verify

- 6.1 **ยืนยัน Commit สำเร็จ**
  - รัน `git log -1 --oneline` เพื่อดู commit ล่าสุด
  - รัน `git show --stat HEAD` เพื่อดูรายละเอียด commit
  - ยืนยันว่า message ถูกต้องและครบถ้วน

### Phase 7: Review

- 7.1 **ตรวจสอบ Commit Log**
  - รัน `git log --oneline -5` เพื่อดู commit ล่าสุด 5 รายการ
  - ตรวจสอบว่า commit มีความสม่ำเสมอ
  - ยืนยันว่า message สื่อความหมายชัดเจน

### Phase 8: Finalize

- 8.1 **สรุปผล**
  - แจ้งว่า commit เสร็จสิ้น
  - แสดง commit hash และ message
  - ยืนยันว่าพร้อมสำหรับ push (ถ้าจำเป็น)

## Outputs

| Output | รายละเอียด |
|--------|-----------|
| Commit | Git commit ที่สร้างสำเร็จ |
| Commit Hash | รหัสอ้างอิงของ commit |
| Commit Log | ประวัติ commit ล่าสุด |

## Expected Outcome

- Commit ถูกสร้างด้วย conventional commits format
- Message สื่อความหมายชัดเจน
- Linter ผ่านก่อน commit (ถ้ามี)
- Tests ผ่านก่อน commit (ถ้ามี)
- `git log` แสดง commit ที่สร้าง
- ไม่มี console.log หรือ debug code ที่ลืมลบ

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `@git` - Skill สำหรับการใช้งาน Git
- [Conventional Commits Specification](https://www.conventionalcommits.org/)
