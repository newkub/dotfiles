---
description: รัน watch browser และแก้ไข error แบบ continuous loop
title: watch-browser-and-fix
---

## Objective

รัน development server พร้อม monitor browser และแก้ไข error อัตโนมัติแบบต่อเนื่อง

## Scope

- รัน dev server และเปิด browser
- Monitor terminal และ browser แบบ continuous
- ตรวจจับ error และ fix ทันที
- รีโหลดและ verify หลังแก้ไข
- ทำงานวน loop ไม่สิ้นสุด

## Preconditions

- มี Bun และ dependencies ติดตั้งแล้ว
- มี agent-browser ติดตั้งแล้ว
- รู้ว่าเป็น project ประเภทไหน
- เข้าใจ error patterns ที่พบบ่อย

## Execution

### 1. Start Infrastructure

1. รัน `/run-dev` และรอ dev server พร้อม
2. เปิด browser ด้วย `agent-browser open <url>`
3. รอ page โหลดสมบูรณ์ (`agent-browser wait --load networkidle`)
4. ทดสอบด้วย `agent-browser snapshot`

### 2. Continuous Fix Loop

5. เริ่ม continuous monitor
   - ดู terminal output
   - ดู browser state (`agent-browser snapshot`)
   - ดู browser rendering (screenshot ถ้าจำเป็น)

### 3. Error Detection

6. ตรวจจับ error
   - Terminal: build, type, runtime errors
   - Browser: ดูจาก snapshot หรือ page state
   - UX: broken layout, interaction fail

### 4. Fix Process

7. ถ้าพบ error
   - บันทึก error details (screenshot: `agent-browser screenshot`)
   - Analyze root cause
   - Fix error ตาม `/fix-error`
   - รอ terminal stable
   - รีโหลด browser (`agent-browser reload`)
   - Verify error หาย (`agent-browser snapshot`)

### 5. Loop Continue

8. กลับไป step 5 ทำต่อเนื่อง
   - loop ไม่มี break
   - ไม่ exit จนกว่าจะ stop

## Validation

- Error ถูก fix จนหมด
- Dev server รันต่อเนื่อง
- Browser ตอบสนองดี
- Loop ทำงานไม่หยุด

## Exclusions

- ไม่รวมการ improve UX/UI (ใช้ `/watch-browser-and-improve-uxui`)
- ไม่รวมการ test (ใช้ `/watch-browser-and-test`)
- ไม่รวมการ stop dev server