---
title: Improve Ux Writing
description: ปรับปรุง UX writing ให้ชัดเจน เข้าใจง่าย กระชับ และสนับสนุน user journey
auto_execution_mode: 3
related_workflows:
  - improve-uxui
  - improve-content
  - improve-error-messages
  - improve-form
  - improve-i18n
  - improve-notifications
  - follow-web-design
  - idea-uxui
---

## Goal

ปรับปรุง UX writing ให้ชัดเจน เข้าใจง่าย กระชับ และสนับสนุน user journey ครบทุกจุดสัมผัส

## Scope

ใช้สำหรับปรับปรุง UX writing ของ web applications, mobile apps, desktop apps, CLI tools, และ TUI applications เช่น microcopy, button labels, error messages, empty states, tooltips, onboarding copy, form labels, notifications, help text, status messages

## Execute

### 1. Audit Current Copy

ตรวจสอบ UX copy ที่มีอยู่ทั้งหมด

1. ทำ `/scan-codebase` เพื่อหา copy ทั้งหมดใน components, pages, และ routes
2. ระบุจุดสัมผัสของผู้ใช้ทั้งหมด (touchpoints) ที่มีข้อความ
3. จัดประเภท copy ตามฟังก์ชัน: navigation, action, feedback, guidance, error
4. บันทึก issues ที่พบ: คำกำกวม, ยาวเกินไป, ใช้ศัพท์เทคนิค, ไม่สอดคล้องกัน
5. ทำ `/idea-uxui` เพื่อวิเคราะห์และสร้างไอเดีย UX writing improvements

### 2. Define Voice And Tone

กำหนด voice และ tone ของผลิตภัณฑ์

1. กำหนด brand personality: friendly, professional, playful, authoritative
2. กำหนด tone ตาม context: success, error, warning, informational, onboarding
3. สร้าง voice guidelines: ใช้ active voice, พูดกับผู้ใช้โดยตรง, หลีกเลี่ยงศัพท์เทคนิค
4. สร้าง tone matrix: บอกว่าแต่ละ context ควรใช้ tone อะไร
5. เก็บ guidelines ไว้ในไฟล์อ้างอิง เช่น `docs/ux-writing-guidelines.md`

### 3. Improve Microcopy

ปรับปรุง microcopy สำหรับ interactive elements

1. ปรับปรุง button labels: ใช้ action verbs ชัดเจน (เช่น "สร้างการจอง" ไม่ใช่ "ตกลง")
2. ปรับปรุง link text: บอกปลายทางชัดเจน (เช่น "ดูรายละเอียดราคา" ไม่ใช่ "คลิกที่นี่")
3. ปรับปรุง menu items: กระชับ เข้าใจง่าย สอดคล้องกับฟังก์ชัน
4. ปรับปรุง tooltips: อธิบายสิ่งที่ผู้ใช้สงสัย ไม่ใช่สิ่งที่ชัดเจนอยู่แล้ว
5. ปรับปรุง placeholder text: แสดงตัวอย่างจริง ไม่ใช่คำอธิบายทั่วไป
6. ตรวจสอบความสม่ำเสมอของคำศัพท์ทั่วทั้งแอป

### 4. Improve Error Messages

ปรับปรุงข้อความแสดงข้อผิดพลาด

1. ทำ `/improve-error-messages` สำหรับ error message system ครบวงจร
2. เขียน error messages ที่บอกสาเหตุและวิธีแก้ (what + how to fix)
3. หลีกเลี่ยงคำว่า "Error", "Failed", "Invalid" โดยไม่มีบริบท
4. ใช้ human language ไม่ใช่ technical jargon หรือ error codes
5. แยก validation errors จาก system errors โดยใช้ tone ที่เหมาะสม

### 5. Improve Empty States

ปรับปรุง empty states ให้เป็นประโยชน์

1. อธิบายสิ่งที่จะปรากฏในพื้นที่นั้นเมื่อมีข้อมูล
2. บอกผู้ใช้ว่าต้องทำอะไรเพื่อเริ่มต้น (call-to-action)
3. ใช้ภาพประกอบหรือไอคอนที่สื่อความหมาย
4. ไม่ปล่อยพื้นที่ว่างโดยไม่มีคำอธิบาย
5. แยก empty states ตาม context: first-time, no results, no permission, no data

### 6. Improve Onboarding Copy

ปรับปรุงข้อความระหว่าง onboarding

1. เขียน welcome message ที่อบอุ่นและกระชับ
2. อธิบาย value proposition ใน 1-2 ประโยค
3. แบ่ง instructions เป็นขั้นตอนสั้นๆ ที่ทำได้จริง
4. ใช้ progressive disclosure: บอกเฉพาะสิ่งที่จำเป็นตอนนี้
5. หลีกเลี่ยง information overload ใน onboarding flow

### 7. Improve Forms And Validation

ปรับปรุงข้อความในฟอร์ม

1. ทำ `/improve-form` สำหรับ form UX ครบวงจร
2. ปรับปรุง field labels: ชัดเจน กระชับ บอกหน่วยถ้ามี
3. ปรับปรุง helper text: อธิบาย format หรือข้อกำหนดก่อนกรอก
4. ปรับปรุง validation messages: บอกเกณฑ์ที่ต้องการ ไม่ใช่แค่ "ไม่ถูกต้อง"
5. ปรับปรุง required field indicators: ชัดเจน ไม่กำกวม
6. ใช้ inline validation พร้อม feedback ทันที

### 8. Improve Notifications And Alerts

ปรับปรุงข้อความแจ้งเตือน

1. ทำ `/improve-notifications` สำหรับ notification system ครบวงจร
2. ปรับปรุง toast messages: กระชับ บอกผลลัพธ์ ไม่หายเร็วเกินไป
3. ปรับปรุง banner messages: บอกความสำคัญและ action ที่ต้องทำ
4. ปรับปรุง confirmation dialogs: ถามชัดเจน บอกผลของการเลือก
5. ใช้ tone ที่เหมาะกับ severity: info, success, warning, error

### 9. Improve CLI And TUI Copy

ปรับปรุง UX writing สำหรับ CLI และ TUI

1. สำหรับ CLI: เขียน help messages ที่กระชับ มี examples และ usage patterns
2. สำหรับ CLI: ใช้ actionable error messages ที่บอกวิธีแก้ ไม่ใช่ error codes
3. สำหรับ CLI: ใช้ consistent flag naming และ option descriptions
4. สำหรับ TUI: ใช้ concise labels ที่อ่านง่ายใน terminal (กระชับ เพราะพื้นที่จำกัด)
5. สำหรับ TUI: เขียน status messages และ progress indicators ที่ชัดเจน
6. สำหรับ TUI: ใช้ color coding ที่สื่อความหมาย ไม่ใช่ decoration อย่างเดียว

### 10. Localize And Internationalize

เตรียม UX writing สำหรับการแปล

1. ทำ `/improve-i18n` สำหรับ i18n ครบวงจร
2. หลีกเลี่ยง idioms และ cultural references เฉพาะภาษา
3. เขียน copy ที่ยืดหยุ่นต่อความยาวของข้อความ (text length varies by language)
4. ใช้ placeholders ที่ชัดเจน เช่น `{name}` ไม่ใช่ `{}`
5. เก็บ copy ทั้งหมดใน translation files ไม่ hardcode ใน components

## Rules

### 1. Clarity Over Cleverness

- เขียนให้เข้าใจง่ายก่อน แล้วค่อยคิดเรื่องความเฉลียวฉลาด
- หลีกเลี่ยง wordplay ที่อาจกำกวม
- ผู้ใช้ใหม่ต้องเข้าใจได้ในครั้งแรกที่อ่าน
- ไม่สมมติว่าผู้ใช้รู้ context

### 2. Action-Oriented Language

- ใช้ action verbs นำหน้า (เช่น "สร้าง", "ดาวน์โหลด", "เชิญ")
- บอกผู้ใช้ว่าต้องทำอะไร ไม่ใช่แค่บอกสถานะ
- ใช้ active voice แทน passive voice
- ปุ่มบอก action ไม่ใช่สถานะ

### 3. Consistent Terminology

- ใช้คำเดียวกันสำหรับฟังก์ชันเดียวกันทั่วทั้งแอป
- สร้าง glossary ของคำศัพท์ที่ใช้
- ไม่สลับคำที่มีความหมายเดียวกัน (เช่น "ลบ" กับ "นำออก")
- ตรวจสอบความสม่ำเสมอในทุกจุดสัมผัส

### 4. Concise And Scannable

- เขียนสั้นที่สุดเท่าที่จะยังเข้าใจได้
- ใช้ short sentences (ไม่เกิน 20 คำต่อประโยค)
- แบ่งย่อหน้ายาวเป็น bullet points ถ้าทำได้
- ผู้ใช้ scan ไม่ได้อ่านทุกคำ

### 5. User-Centric Voice

- พูดกับผู้ใช้โดยตรง ใช้ "คุณ" แทน "ผู้ใช้" หรือ "ท่าน"
- หลีกเลี่ยงศัพท์เทคนิคที่ไม่จำเป็น
- ใช้ภาษาเป็นมิตร ไม่เป็นทางการเกินไป
- เคารพผู้ใช้ ไม่ตำหนิหรือดูถูก

### 6. Error Recovery Focus

- ทุก error message ต้องบอกวิธีแก้
- ไม่ตำหนิผู้ใช้ (เช่น "คุณกรอกผิด" → "รูปแบบไม่ถูกต้อง ลองอีกครั้ง")
- ให้ทางออกหรือทางเลือกถ้าทำได้
- แยก user errors จาก system errors

## Expected Outcome

- UX writing ชัดเจน เข้าใจง่าย กระชับ
- Voice และ tone สม่ำเสมอทั่วทั้งแอป
- Error messages บอกสาเหตุและวิธีแก้
- Empty states มีประโยชน์และชี้แนะผู้ใช้
- Onboarding copy ลด friction สำหรับผู้ใช้ใหม่
- คำศัพท์สม่ำเสมอ ไม่กำกวม
- พร้อมสำหรับการแปลและ localization
