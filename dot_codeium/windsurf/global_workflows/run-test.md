---
title: Run Test
description: รัน test suite อย่างเป็นระบบ ครอบคลุม unit, integration, e2e และ specialized tests
auto_execution_mode: 3
related_workflows:
  - /write-test
  - /run-test-coverage
  - /improve-test-coverage
  - /review-test-result
  - /validate-test
  - /report
  - /follow-code-quality
---

## Goal

รัน test suite อย่างเป็นระบบ เขียน test ด้วย `/write-test` ตรวจสอบ coverage 100% และรัน specialized tests ตาม project needs

## Scope

ครอบคลุมการทดสอบทุกประเภท: unit, integration, e2e, component, API, performance, security, accessibility, i18n, และอื่นๆ

## Execute

### 1. Run Lint And Typecheck

1. ทำ `/run-lint` เพื่อตรวจสอบ code quality
2. ทำ `/run-typecheck` เพื่อตรวจสอบ type safety
3. แก้ไข errors ก่อนดำเนินการต่อ

### 2. Setup Test Structure

1. ตรวจสอบ test structure: `test/unit/`, `test/integration/`, `test/e2e/`, `test/fixtures/`, `test/mocks/`, `test/utils/`
2. สร้าง directories ถ้ายังไม่มี
3. ตรวจสอบ test frameworks ถูกติดตั้ง (Vitest, Playwright)
4. ตรวจสอบ test configuration files

### 3. Write Tests

1. ทำ `/write-test` เพื่อเขียน tests ที่ขาดหายไป
2. ตรวจสอบ test files ครบถ้วนตาม `SPEC.md`
3. ตรวจสอบครอบคลุม happy path, edge cases, error cases
4. ตรวจสอบ formal verification สำหรับ critical components

### 4. Run Core Tests

1. รัน `bun run test` หรือ `bun test`
2. บันทึกผลลัพธ์และระบุ tests ที่ fail
3. บันทึก duration ของแต่ละ test

### 5. Run Specialized Tests (Conditional)

1. รัน specialized tests ตาม project characteristics:
   - ถ้า project มี functions/business logic:
     - Unit tests: test pure functions, edge cases, parameterized tests
     - ใช้ `vitest run` สำหรับ fast unit testing
   - ถ้า project มี integrations ระหว่าง modules:
     - Integration tests: test module interactions, data flow, dependencies
     - ตรวจสอบ integration points และ error handling
   - ถ้า project มี UI:
     - Component tests: test rendering, props, events, slots ด้วย `@vue/test-utils` หรือ `@testing-library/react`
     - Accessibility tests: ตรวจสอบ WCAG compliance, ARIA labels, keyboard navigation, screen reader compatibility
   - ถ้า project มี web frontend:
     - E2E tests: test user flows บน real browser ด้วย `Playwright`
     - Compatibility tests: test browser/device/OS compatibility
     - Website tests: test บน real browser ด้วย agent-browser
   - ถ้า project มี API:
     - API tests: test endpoints, status codes, response format, error handling
     - Contract tests: test API contracts ระหว่าง services ด้วย consumer-driven contracts
   - ถ้า project มี database:
     - Database tests: test queries, migrations, transactions, data integrity, indexes
   - ถ้า project มี GraphQL:
     - GraphQL tests: test queries, mutations, subscriptions, schema validation, resolvers
   - ถ้า project มี WebSocket:
     - WebSocket tests: test connections, real-time messaging, reconnection, error handling
   - ถ้า project มี file operations:
     - File tests: test upload, download, validation (type/size/extension), large files, security
   - ถ้า project มี i18n:
     - I18n tests: test translation completeness, RTL languages, date/time/number formatting, locale switching, pluralization
   - ถ้า project มี caching:
     - Cache tests: test cache strategies, invalidation, TTL, CDN caching
   - ถ้า project มี network dependencies:
     - Network tests: test offline mode, retry mechanisms, timeout handling, slow connections
   - ถ้า project ต้องการ performance validation:
     - Performance tests: unit tests < 10ms, integration tests < 100ms, bottlenecks
     - Load tests: test scalability และ stability ภายใต้ load
   - ถ้า project ต้องการ resilience validation:
     - Chaos tests: test system resilience ด้วย chaos engineering
   - ถ้า project มี users:
     - Usage tests: test การใช้งานจริงใน production-like environment
   - ถ้า project มี critical components:
     - Formal verification: type systems, property-based testing, static analysis
     - Security tests: input validation, authentication/authorization, data sanitization, vulnerability scanning
     - Mutation tests: mutation score > 80%, killed mutants ครอบคลุม critical code

### 6. Review Test Results

1. ทำ `/review-test-result` เพื่อวิเคราะห์ผล test execution และหา root cause ของ failures

### 7. Check Coverage

1. ทำ `/run-test-coverage` เพื่อวิเคราะห์ coverage
2. ตรวจสอบ coverage 100% ทุก category (lines, branches, functions, statements)
3. ถ้าไม่ถึง 100% ให้ทำ `/write-test` เพิ่ม แล้วทำซ้ำขั้นตอน 4-7

### 8. Fix Failures

1. ทำ `/analyze-errors` เพื่อจัดลำดับ failures
2. ถ้า cascade issues → `/debug-issue` → `/resolve-errors`
3. ถ้า isolated errors → `/resolve-errors`
4. แก้ไข code, test assertions, หรือ mock data ตามความจำเป็น

### 9. Verify And Report

1. รัน tests อีกครั้งจนกว่าจะผ่าน 100%
2. ทำ `/validate-test` เพื่อตรวจสอบ test quality ครบวงจร
3. ทำ `/report` สรุปผลลัพธ์:
   - `/report-format-table` สำหรับ coverage metrics
   - `/report-format-table` สำหรับ test results
   - `/report-format-table` สำหรับสรุปผล

## Rules

### 1. Test Execution

- Test fail: วิเคราะห์ cause และแก้ไข
- Test error: ตรวจสอบ error message และ fix
- Test pass: continue ไป test ถัดไป
- Test timeout: ตรวจสอบ performance และ adjust

### 2. Specialized Test Selection

- รันเฉพาะ specialized tests ที่เกี่ยวข้องกับ project
- ใช้ "ถ้า project มี..." เพื่อกำหนด test types
- ไม่ต้องรันทุก test type ถ้า project ไม่มี component นั้น
- ถ้าไม่แน่ใจ ให้ถามผู้ใช้

### 3. Error Resolution

- อ่าน error message และระบุ root cause
- แก้ไข code หรือ test ตามความจำเป็น
- ทำซ้ำจนผ่าน ห้ามข้าม errors

### 4. Coverage

- ตรวจสอบ coverage ทุก category (line, branch, function, statement)
- เป้าหมาย 100% โดยไม่มีข้อยกเว้น
- พิจารณา criticality ของส่วนที่ไม่มี coverage

### 5. Performance

- ตรวจสอบ performance ของ tests
- ระบุ tests ที่ช้าและแนะนำการปรับปรุง
- พิจารณา impact ต่อ CI/CD pipeline

### 6. Reporting

- สร้างรายงานชัดเจนและ action-oriented
- ระบุ priority สำหรับการดำเนินการ
- ให้ข้อมูลเพียงพอสำหรับการตัดสินใจ

## Expected Outcome

- ทุก tests ผ่าน 100%
- Test coverage ถึง 100% ทุก category
- Specialized tests ผ่านตาม project needs
     Formal verification ผ่านสำหรับ critical components (ถ้ามี)
- รายงานสรุปผลลัพธ์ test ที่ครบถ้วน
