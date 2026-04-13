title: Follow Vitest
description: ตั้งค่าและใช้งาน Vitest สำหรับ unit testing ในโปรเจกต์ TypeScript และ JavaScript
auto_execution_mode: 3
## Purpose

ตั้งค่า Vitest เป็น testing framework หลักสำหรับโปรเจกต์ TypeScript/JavaScript ด้วยความเร็วสูงและ feature ครบครัน

## Scope

- ติดตั้ง Vitest และ dependencies ที่จำเป็น
- ตั้งค่า configuration สำหรับ single repo และ monorepo
- รองรับ Vitest Projects สำหรับหลาย packages
- Best practices สำหรับการเขียน tests

## Inputs

| Input | Details |
|-------|-----------|
| Runtime | Bun |
| Project Type | Single repo หรือ monorepo |
| Test Pattern | `**/*.test.ts` หรือ `**/*.spec.ts` |

## Rules

| Category | Requirements |
|------|---------|
| **Installation** | ใช้ `bun add -D vitest` |
| **Config File** | ใช้ `vitest.config.ts` (TypeScript) |
| **Globals** | Enable globals เพื่อลดการ import |
| **Monorepo** | ใช้ Vitest Projects สำหรับหลาย packages |
| **Compatibility** | ตรวจสอบ Node.js และ Bun version |

## Structure

### Directory Structure

```text
project/
├── vitest.config.ts      # Root config
├── package.json          # Test scripts
└── src/
    └── utils/
        └── helper.test.ts
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้งและ config | Install Vitest, create config |
| Projects | Monorepo setup | Vitest Projects config |
| Write | เขียน tests | Test files |
| Best Practices | ปรับปรุงคุณภาพ | Follow best practices |
| Verify | ตรวจสอบ | Run tests, check compatibility |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - Node.js version compatible
  - มี `package.json` อยู่แล้ว

### Phase 1: Setup

- 1.1 **ทำ /follow-vitest-config**
  - ติดตั้ง Vitest และ dependencies
  - ตั้งค่า package.json scripts
  - สร้าง `vitest.config.ts` พื้นฐาน

### Phase 2: Projects Configuration (ถ้าเป็น monorepo)

- 2.1 **ทำ /follow-vitest-projects**
  - ตรวจสอบความเหมาะสมของ Vitest Projects
  - กำหนด glob patterns สำหรับ projects
  - ตั้งค่า extends จาก root config

### Phase 3: Write Tests

- 3.1 **ทำ /follow-vitest-write-tests**
  - วิเคราะห์โครงสร้างและระบุไฟล์ที่ต้อง test
  - เขียน test files สำหรับ source code
  - รัน tests เพื่อตรวจสอบ

### Phase 4: Best Practices

- 4.1 **ทำ /follow-vitest-best-practices**
  - ใช้ globals เพื่อลดการ import
  - จัดระเบียบ test files
  - ใช้ mocking และ stubbing อย่างเหมาะสม

### Phase 5: Compatibility Check

- 5.1 **ทำ /check-compatibility**
  - ตรวจสอบความเข้ากันได้ของ dependencies
  - ตรวจสอบเวอร์ชันของ Node.js และ Bun

## Outputs

| Output | Details |
|--------|-----------|
| vitest.config.ts | Root configuration |
| Test files | `**/*.test.ts` files |
| Updated package.json | Test scripts |

## Expected Outcome

- Vitest ติดตั้งและทำงานได้
- Config รองรับ globals และ monorepo (ถ้ามี)
- Tests รันได้ทั้งหมด
- เป็นไปตาม best practices

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/follow-vitest-config` - ตั้งค่า Vitest พื้นฐาน
- `/follow-vitest-projects` - ตั้งค่า Vitest Projects
- `/follow-vitest-best-practices` - Best practices
- `/connect-workflows` - เชื่อมโยง workflows
