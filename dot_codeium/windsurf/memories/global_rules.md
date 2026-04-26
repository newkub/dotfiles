---
title: Global Rules
description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace
auto_execution_mode: 3
---

## Goal

กำหนดกฎและแนวทางการพัฒนาโปรเจกต์ที่ใช้กับทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Execute

### 1. Prepare

กฎการเตรียมความพร้อม

1. ใช้ `bun` แทน `npm` เสมอ
2. ใช้ `git` สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ `nu -c` (nushell)
3. รัน `/watch-browser` ทันทีเมื่อได้รับ URL
4. ทำ `/analyze-project` ก่อนเริ่มงานทุกครั้ง
5. เวลาจะ setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน
6. `"."` หมายถึงให้ทำ `/continue`

### 2. Analyze

กฎการวิเคราะห์

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. เมื่อได้รับ error ทำตาม `/fix-error`
3. เมื่อแก้ไขไม่ได้สักที ลอง `/learn-from-web`
4. วิเคราะห์ root cause ก่อนแก้ไข

### 3. Planning

กฎการวางแผน

1. ใช้ `/plan` สำหรับการวางแผนงานครอบคล้ว
2. เมื่อแก้ไขไฟล์ workflows ทำตาม `/follow-write-workflows`
3. เมื่อแก้ไขไฟล์ skills ทำตาม `/follow-write-skills`

### 4. Write

กฎการเขียนโค้ด

1. อ่าน `/do-not` ก่อนเขียน code ทุกครั้ง
2. เมื่อ execute ต้องเปิด web ให้รัน `/watch-browser`
3. ทำ `/update-reference` เสมอสำหรับ file operations
4. เมื่อเขียน code ทำตาม `/write-test` เสมอ
5. ถ้า mock ให้ comment `// MOCK` ชัดเจน ถ้ายังทำไม่เสร็จต้อง comment `// TODO`
6. mock data ห้ามเขียนในไฟล์เดียวกัน ต้องแยกไฟล์ไปในโฟลเดอร์ `mock/` แล้วนำไปใช้
7. ไม่ mock หรือ TODO โดย default ยกเว้นจำเป็นจริงๆ ต้อง comment ชัดเจน
8. ทุก global workflows ที่ขึ้นต้นด้วย `run-` ให้ใช้ `/loop-until-complete` เสมอ
9. ถ้า file operation หรือ analyze ไฟล์จำนวนมาก ให้ใช้ `/use-bun-scripts`

### 5. Reflex

กฎการตรวจสอบ

1. ทำ `/run-typecheck` เสมอหลังจาก execute เสร็จ
2. ใช้ `/loop-until-complete` เพื่อทำซ้ำจนกว่าจะผ่าน
3. กลับไป check planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมดแล้ว

### 6. Report

กฎการรายงาน

1. ทำตาม `/report`
2. เมื่อจบ task ให้รัน `/suggest-next-action` เสมอ
3. คุยกับผู้ใช้เป็นภาษาไทยเสมอในทุกการสื่อสาร
4. ให้คำตอบกระชับ ตรงประเด็น
5. หลีกเลี่ยงการใช้คำยืนยันที่ไม่จำเป็น

## Do Not

สิ่งที่ห้ามทำในการพัฒนาโปรเจกต์เพื่อป้องกันปัญหาที่เกิดซ้ำ รักษามาตรฐานคุณภาพ และสร้างความสม่ำเสมอในการทำงาน

### 1. Code Quality

สิ่งที่ห้ามทำเกี่ยวกับคุณภาพโค้ด

1. ห้ามใช้ `any` ใน TypeScript โดยไม่จำเป็นและไม่มีคำอธิบาย
2. ห้ามปล่อยให้มี `console.log` ใน production code ให้ใช้ logger ที่เหมาะสม
3. ห้ามใช้ magic numbers หรือ hardcoded strings โดยไม่มีคำอธิบายหรือ constants
4. ห้ามเขียนโค้ดซ้ำ (duplicate code) เกิน 2 ครั้งโดยไม่ extract เป็น shared function
5. ห้ามสร้างไฟล์ที่ยาวเกิน 200 บรรทัดโดยไม่แยกเป็น module
6. ห้ามใช้ var ให้ใช้ const หรือ let เสมอ
7. ห้ามใช้ == ให้ใช้ === เสมอ
8. ห้ามปล่อยให้มี unused variables หรือ unused imports

### 2. Dependencies

สิ่งที่ห้ามทำเกี่ยวกับ dependencies

1. ห้ามใช้ `npm` หรือ `npx` ให้ใช้ `bun` แทนเสมอ
2. ห้ามติดตั้ง dependencies โดยไม่ตรวจสอบขนาดและความจำเป็น
3. ห้าม import ทั้ง library โดยไม่ใช้ tree-shaking (เช่น `import _ from 'lodash'`)
4. ห้ามใช้ dependencies ที่ไม่ maintained หรือ deprecated
5. ห้ามมี circular dependencies ระหว่าง modules

### 3. File Operations

สิ่งที่ห้ามทำเกี่ยวกับการจัดการไฟล์

1. ห้ามใช้ `cd` ใน commands ให้ใช้ `cwd` parameter แทน
2. ห้ามสร้างไฟล์ใหม่โดยไม่ตรวจสอบว่ามีอยู่แล้วหรือไม่
3. ห้ามลบไฟล์โดยไม่สำรองหรือตรวจสอบ references ทั้งหมด
4. ห้ามย้ายไฟล์โดยไม่ update references ทั้งหมด
5. ห้ามแก้ไขไฟล์โดยไม่ read ก่อนทุกครั้ง
6. ห้ามสร้างไฟล์ที่ไม่จำเป็นโดยไม่ถามผู้ใช้ก่อน

### 4. Git Operations

สิ่งที่ห้ามทำเกี่ยวกับ git

1. ห้าม commit โดยไม่ตรวจสอบ git status
2. ห้าม commit ไฟล์ที่ไม่เกี่ยวข้องกับงานที่ทำ (เช่น node_modules, .env)
3. ห้ามใช้ commit message ที่ไม่ชัดเจนหรือไม่ follow conventional commits
4. ห้าม force push โดยไม่แจ้งให้ทีมทราบ

### 5. Testing

สิ่งที่ห้ามทำเกี่ยวกับการทดสอบ

1. ห้าม skip tests โดยไม่มีเหตุผลที่ documented
2. ห้ามเขียน tests ที่ไม่มี assertions หรือ expectations ที่ชัดเจน
3. ห้ามใช้ real API/database ใน unit tests ให้ใช้ mocks
4. ห้ามปล่อยให้มี flaky tests ที่ fail แบบสุ่ม

### 6. Documentation

สิ่งที่ห้ามทำเกี่ยวกับเอกสาร

1. ห้ามลบหรือแก้ไข TODO.md โดยไม่แจ้งให้ผู้ใช้ทราบ
2. ห้ามทิ้ง placeholder text หรือ "Lorem ipsum" ใน production
3. ห้ามเขียน comment ที่อธิบายสิ่งที่โค้ดทำอยู่แล้ว (self-explanatory)
4. ห้ามปล่อยให้มี dead code หรือ commented-out code โดยไม่มีเหตุผล
5. ห้ามใช้ภาษาไทยในชื่อไฟล์หรือโฟลเดอร์
6. ห้ามใช้ชื่อไฟล์หรือโฟลเดอร์ที่มีช่องว่างหรืออักขระพิเศษ

### 7. Security

สิ่งที่ห้ามทำเกี่ยวกับความปลอดภัย

1. ห้าม hardcode secrets, API keys, passwords ในโค้ด
2. ห้ามเก็บ .env files ใน git โดยไม่มี .gitignore
3. ห้ามใช้ eval() หรือ new Function() กับ user input
4. ห้ามใช้ innerHTML กับ unsanitized data
5. ห้ามปล่อยให้มี SQL injection หรือ XSS vulnerabilities
6. ห้าม disable security headers โดยไม่จำเป็น

### 8. Performance

สิ่งที่ห้ามทำเกี่ยวกับประสิทธิภาพ

1. ห้ามทำ API calls ใน loops โดยไม่ batch หรือ optimize
2. ห้ามใช้ setState ใน loops หรือ render methods
3. ห้าม import ทั้ง library โดยไม่ใช้ tree-shaking
4. ห้ามใช้ large images โดยไม่ optimize
5. ห้าม blocking the main thread ด้วย heavy computations
6. ห้ามใช้ unnecessary re-renders ใน React/Vue components

### 9. AI Operations

สิ่งที่ห้ามทำเกี่ยวกับการใช้ AI

1. ห้ามแก้ไขไฟล์โดยไม่ read ก่อนทุกครั้ง
2. ห้ามสร้างไฟล์ที่ไม่จำเป็นโดยไม่ถามผู้ใช้ก่อน
3. ห้ามลบหรือแก้ไข TODO.md โดยไม่แจ้งให้ผู้ใช้ทราบ
4. ห้ามใช้ emoji ใน code หรือ comments โดยไม่ได้รับการขอให้ใช้
5. ห้ามทำสิ่งใดที่ไม่ได้อยู่ใน scope ของงานที่ได้รับมอบหมาย
6. ห้าม assume ความต้องการของผู้ใช้โดยไม่ถามก่อน

### 10. Error Handling

สิ่งที่ห้ามทำเกี่ยวกับการจัดการ error

1. ห้ามใช้ try-catch ที่กว้างเกินไปโดยไม่ handle error เฉพาะ
2. ห้ามปล่อยให้มี silent errors โดยไม่ log
3. ห้ามใช้ empty catch blocks
4. ห้าม throw generic errors โดยไม่มี context
5. ห้ามใช้ error messages ที่ไม่ชัดเจน

### 11. API Design

สิ่งที่ห้ามทำเกี่ยวกับการออกแบบ API

1. ห้ามใช้ API endpoints ที่ไม่ follow RESTful conventions
2. ห้าม return ข้อมูลที่ไม่ consistent กัน
3. ห้ามไม่มี error responses ที่ standard
4. ห้ามใช้ HTTP methods ที่ไม่ถูกต้อง
5. ห้ามไม่มี API documentation

### 12. Database Operations

สิ่งที่ห้ามทำเกี่ยวกับ database

1. ห้ามใช้ N+1 queries
2. ห้าม query ข้อมูลที่ไม่จำเป็นโดยไม่ select เฉพาะ field
3. ห้ามไม่มี database indexes ที่จำเป็น
4. ห้ามใช้ raw SQL โดยไม่ sanitize
5. ห้ามไม่มี database migrations

### 13. UI/UX

สิ่งที่ห้ามทำเกี่ยวกับ UI/UX

1. ห้ามใช้ hardcode colors หรือ spacing โดยไม่มี design system
2. ห้ามไม่ responsive design
3. ห้ามไม่มี accessibility features
4. ห้ามใช้ loading states ที่ไม่ชัดเจน
5. ห้ามไม่มี error states ใน UI

### 14. Architecture

สิ่งที่ห้ามทำเกี่ยวกับ architecture

1. ห้ามใช้ tight coupling ระหว่าง modules
2. ห้ามไม่มี separation of concerns
3. ห้ามใช้ global state โดยไม่จำเป็น
4. ห้ามไม่มี clear layering
5. ห้าม violate SOLID principles

### 15. State Management

สิ่งที่ห้ามทำเกี่ยวกับ state management

1. ห้ามใช้ prop drilling ลึกเกินไป
2. ห้าม mutate state โดยตรงใน React/Vue
3. ห้ามใช้ state ในที่ที่ควรใช้ props
4. ห้ามไม่มี clear data flow
5. ห้ามใช้ side effects ใน render

### 16. Refactoring

สิ่งที่ห้ามทำเกี่ยวกับการ refactor

1. ห้าม refactor โดยไม่มี tests
2. ห้าม refactor ทั้งหมดพร้อมกันโดยไม่ step-by-step
3. ห้าม change public API โดยไม่ version
4. ห้าม refactor เพราะ style ไม่ชอบโดยไม่มีเหตุผล
5. ห้ามไม่ update documentation หลัง refactor

### 17. Deployment

สิ่งที่ห้ามทำเกี่ยวกับการ deploy

1. ห้าม deploy โดยไม่ทดสอบบน staging ก่อน
2. ห้าม deploy โดยไม่มี rollback plan
3. ห้าม deploy โดยไม่ monitor
4. ห้าม deploy โดยไม่ backup database
5. ห้าม deploy ในช่วง high traffic โดยไม่จำเป็น

### 18. CI/CD

สิ่งที่ห้ามทำเกี่ยวกับ CI/CD

1. ห้าม skip CI checks โดยไม่จำเป็น
2. ห้ามใช้ secrets ใน CI config โดยไม่ secure
3. ห้ามไม่มี automated tests ใน CI
4. ห้าม cache dependencies ที่ไม่ควร
5. ห้าม run CI บน resources ที่ไม่เพียงพอ

### 19. Monitoring

สิ่งที่ห้ามทำเกี่ยวกับการ monitoring

1. ห้ามไม่มี logging ใน production
2. ห้าม log sensitive data
3. ห้ามไม่มี error tracking
4. ห้ามไม่มี performance monitoring
5. ห้ามไม่มี alerts สำคัญ
