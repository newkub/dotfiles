---
title: Run Test
description: รัน test suite ตรวจหา failures แล้ว validate/review เพื่อระบุว่าควรแก้ source หรือ test
auto_execution_mode: 3
related:
  - /run-lint
  - /run-typecheck
  - /write-test
  - /run-test-coverage
  - /validate
  - /validate-test
  - /review
  - /review-testing
  - /deep-review
  - /report
  - /follow-code-quality
---

## Goal

รัน test suite อย่างเป็นระบบ ตรวจหา failures แล้ว validate/review เพื่อกำหนดว่าควรแก้ source หรือ test โดยไม่แก้ให้ผ่านอัตโนมัติ

## Scope

ครอบคลุม unit, integration, e2e, component, API, database, performance, security, accessibility, i18n, และ specialized tests ตาม project needs

## Execute

### 1. Run Lint And Typecheck

1. ทำ `/run-lint` เพื่อตรวจสอบ code quality
2. ทำ `/run-typecheck` เพื่อตรวจสอบ type safety
3. แก้ไข lint/type errors ก่อนรัน tests (code quality ไม่ใช่ test failure)

### 2. Setup Test Structure

1. ตรวจสอบ test structure: `test/unit/`, `test/integration/`, `test/e2e/`, `test/fixtures/`, `test/mocks/`, `test/utils/`
2. สร้าง directories ถ้ายังไม่มี
3. ตรวจสอบ test frameworks ติดตั้ง (Vitest, Playwright)
4. ตรวจสอบ test config files (`vitest.config.ts`, `playwright.config.ts`)

### 3. Prepare Tests

1. ถ้า project ยังไม่มี tests หรือ coverage ไม่ครบ ให้ทำ `/write-test` เพื่อสร้าง tests ที่ขาดหายไป
2. ตรวจสอบ test files ครอบคลุม happy path, edge cases, error cases
3. ไม่แก้ไข test assertions หรือ source code เพื่อให้ผ่านในขั้นตอนนี้

### 4. Run Core Tests

1. รัน `bun run test` หรือ `bun test`
2. บันทึกผลลัพธ์, duration, และรายการ tests ที่ fail
3. ถ้ามี fail ให้ไปขั้นตอน Validate/Review ทันที โดยไม่แก้ไข code

### 5. Run Specialized Tests (Conditional)

รันเฉพาะ test types ที่เกี่ยวข้องกับ project:

- ถ้ามี functions/business logic: unit tests สำหรับ pure functions, edge cases, parameterized tests
- ถ้ามี integrations ระหว่าง modules: integration tests สำหรับ data flow, integration points, error handling
- ถ้ามี UI: component tests และ accessibility tests (WCAG, ARIA, keyboard, screen reader)
- ถ้ามี web frontend: E2E tests ด้วย `Playwright`, compatibility tests, agent-browser tests
- ถ้ามี API: API tests และ contract tests
- ถ้ามี database: database tests สำหรับ queries, migrations, transactions, data integrity, indexes
- ถ้ามี GraphQL: GraphQL tests สำหรับ queries, mutations, subscriptions, schema validation, resolvers
- ถ้ามี WebSocket: WebSocket tests สำหรับ connections, real-time messaging, reconnection, error handling
- ถ้ามี file operations: file tests สำหรับ upload, download, validation, large files, security
- ถ้ามี i18n: i18n tests สำหรับ translation completeness, RTL, formatting, locale switching, pluralization
- ถ้ามี caching: cache tests สำหรับ invalidation, TTL, CDN caching
- ถ้ามี network dependencies: network tests สำหรับ offline mode, retry, timeout, slow connections
- ถ้าต้องการ performance validation: performance tests (unit < 10ms, integration < 100ms) และ load tests
- ถ้าต้องการ resilience validation: chaos tests
- ถ้ามี users: usage tests ใน production-like environment
- ถ้ามี critical components: formal verification, security tests, mutation tests (score > 80%)

### 6. Validate And Classify Failures

1. ทำ `/validate` กับ source code ที่เกี่ยวข้องเพื่อตรวจสอบความถูกต้อง
2. ทำ `/validate-test` เพื่อตรวจสอบ test quality, assertions, mocks
3. ทำ `/review` หรือ `/review-testing` เพื่อ review ทั้ง source และ test files
4. จำแนกผล:
   - ถ้า source ผิด → ระบุไฟล์ source ที่ต้องแก้ แนะนำ `/fix` หรือ `/resolve-errors`
   - ถ้า test ผิด (assertion, mock, expectation) → ระบุไฟล์ test ที่ต้องแก้ แนะนำ `/write-test` หรือ `/edit`
   - ถ้าไม่ชัดเจน → ทำ `/deep-review` แล้ว report ก่อนดำเนินการ
5. ห้ามแก้ source หรือ test โดยไม่มี evidence จาก validate/review

### 7. Fix Based On Classification

1. ถ้าได้รับการยืนยันและผล validate/review ชัดเจน:
   - ถ้า source ผิด → ทำ `/fix` หรือ `/resolve-errors` กับ source
   - ถ้า test ผิด → ทำ `/write-test` หรือ `/edit` กับ test
2. รัน tests อีกครั้งหลังแก้ไข
3. ถ้ายัง fail ให้กลับไปขั้นตอน Validate/Review ไม่แก้ให้ผ่านแบบอัตโนมัติ

### 8. Check Coverage

1. ทำ `/run-test-coverage` เพื่อวิเคราะห์ coverage
2. ตรวจสอบ coverage ทุก category (lines, branches, functions, statements)
3. ถ้าไม่ถึงเป้าหมาย ให้ทำ `/write-test` เพิ่ม แล้วรัน tests ใหม่

### 9. Report

1. ทำ `/report` สรุปผลลัพธ์
2. ใช้ `/report-format-table` สำหรับ test results, coverage metrics, และ action items
3. ทำ `/suggest-next-action` หากยังมี issues

## Rules

### 1. Test Failure Handling

- Test fail: ห้ามแก้ให้ผ่านโดยไม่ validate/review ก่อน
- Test error: ตรวจสอบ error message แล้ว classify
- Test pass: continue ไป test ถัดไป
- Test timeout: ตรวจสอบ performance
- ก่อนแก้ไขต้องมี evidence ว่า source หรือ test ผิด

### 2. Validation And Review

- ทำ `/validate` กับ source ทุกครั้งเมื่อ test fail
- ทำ `/validate-test` กับ test ทุกครั้งเมื่อ test fail
- ทำ `/review` หรือ `/review-testing` เพื่อหาต้นเหตุ
- ถ้าไม่ชัดเจน → ทำ `/deep-review` แล้ว report

### 3. Fix Direction

- ถ้า source ผิด → แก้ source ไม่ใช่ test
- ถ้า test ผิด (outdated, assertion ผิด, mock ผิด) → แก้ test
- ห้ามแก้ assertion ให้อ่อนลงเพื่อให้ผ่าน
- ห้ามแก้ source ให้เข้ากับ test ที่ผิด

### 4. Specialized Test Selection

- รันเฉพาะ test types ที่เกี่ยวข้องกับ project
- ไม่ต้องรันทุก type
- ถ้าไม่แน่ใจ ถามผู้ใช้

### 5. Coverage

- ตรวจสอบ coverage ทุก category (line, branch, function, statement)
- เป้าหมาย 100% ถ้า project กำหนด
- ถ้ายังไม่ถึง ให้เพิ่ม tests ไม่ใช่ลด coverage target

### 6. Reporting

- รายงานชัดเจนและ action-oriented
- ระบุ priority
- แยกผลเป็น source issue กับ test issue

## Expected Outcome

- Tests รันเสร็จสมบูรณ์
- Test failures ได้รับการ validate/review และจำแนกว่าเป็น source หรือ test issue
- ไม่มีการแก้ไขโดยไม่มี evidence
- Coverage ผ่านเป้าหมาย (ถ้ามี)
- รายงานผล test results, coverage, และ action items ชัดเจน
