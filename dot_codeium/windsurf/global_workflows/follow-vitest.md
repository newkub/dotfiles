---
description: Vitest Best Practices - Comprehensive Rules
auto_execution_mode: 3
---

# Vitest Best Practices - Comprehensive Rules

## 1. Configuration

### 1.1 Basic Setup
**MUST** สร้าง `vitest.config.ts` ในทุก package ที่มี tests
- ตั้ง `globals: true` เพื่อไม่ต้อง import describe/it/expect
- ระบุ `environment` ให้ชัดเจน (node/jsdom/happy-dom)
- เปิด `coverage.provider: 'v8'` และ reporters: text, json, html
- exclude config files, type definitions, และ test folders จาก coverage

### 1.2 Monorepo Workspace
**MUST** สร้าง `vitest.workspace.ts` ที่ root สำหรับ monorepo
- กำหนด workspace patterns: `packages/*/vitest.config.ts`
- แยก test suites ตาม environment และ type (unit, integration, browser)
- ตั้ง unique name สำหรับแต่ละ project configuration
- **WHEN**: ใช้เมื่อมี multiple packages หรือ test environments

### 1.3 Coverage Thresholds
**MUST** กำหนด coverage thresholds ใน config
- branches: 80%, functions: 80%, lines: 80%, statements: 80%
- ปรับ threshold ตาม project complexity (critical = 90%+)
- **WHEN**: ตั้งแต่เริ่มโปรเจกต์เพื่อ enforce quality

## 2. Test Organization

### 2.1 File Structure
**MUST** วางไฟล์ test ใน `__tests__/` หรือ co-locate กับ source
- Pattern 1: `src/__tests__/*.test.ts` (แยก folder)
- Pattern 2: `src/*.test.ts` (co-located, ดีสำหรับ in-source testing)
- **NEVER** mix test code กับ production code ใน same file (ยกเว้น in-source testing ที่ใช้ `if (import.meta.vitest)`)

### 2.2 Naming Conventions
**MUST** ตั้งชื่อไฟล์เป็น `*.test.ts` หรือ `*.spec.ts`
- Browser tests: `*.browser.test.ts`
- Integration tests: `*.integration.test.ts`
- E2E tests: `*.e2e.test.ts`
- **WHEN**: ตั้งแต่สร้างไฟล์ test แรก

### 2.3 Test Names
**MUST** เขียน test descriptions ให้อ่านเข้าใจทันที
- Pattern: `should [expected behavior] when [condition]`
- Example: `should return null when input is empty`
- **NEVER** ใช้ชื่อคลุมเคลือ เช่น "test 1", "it works"

## 3. Test Structure & Patterns

### 3.1 Arrange-Act-Assert (AAA)
**MUST** เขียนทุก test ตาม AAA pattern
- Arrange: เตรียม test data, mocks, dependencies
- Act: เรียกใช้ function/method ที่ต้องการ test
- Assert: verify ผลลัพธ์
- แยกแต่ละ section ด้วย blank line เพื่อ readability

### 3.2 Test Grouping
**MUST** ใช้ `describe()` เพื่อจัดกลุ่ม related tests
- Nested describe สำหรับ sub-features หรือ different scenarios
- ตั้งชื่อ describe ตาม class/function/feature ที่ test
- **WHEN**: มี tests มากกว่า 3 อันสำหรับ feature เดียวกัน

### 3.3 Test Independence
**MUST** แต่ละ test ต้องรันได้อิสระ ไม่พึ่งพา test อื่น
- ใช้ `beforeEach()` สร้าง fresh state ทุกครั้ง
- **NEVER** share mutable state ระหว่าง tests
- **NEVER** พึ่งพา test execution order

### 3.4 Test Scope
**MUST** test เพียง 1 concept ต่อ 1 test case
- หาก test มี multiple assertions, ต้อง related กับ concept เดียวกัน
- **WHEN**: test case มี assertions มากกว่า 5 อัน → แยกเป็น multiple tests

## 4. Lifecycle Hooks

### 4.1 Setup & Teardown
**MUST** ใช้ hooks ที่เหมาะสมตาม scope
- `beforeEach/afterEach`: per-test setup/cleanup (ใช้บ่อยที่สุด)
- `beforeAll/afterAll`: per-suite setup/cleanup (ใช้สำหรับ expensive operations)
- **ALWAYS** cleanup ใน `afterEach()`: clear mocks, restore spies, reset state

### 4.2 Mock Cleanup
**MUST** ใส่ `vi.clearAllMocks()` ใน `afterEach()` เสมอ
- ป้องกัน mock pollution ระหว่าง tests
- หาก test suite ไม่มี mocks ก็ยัง safe ที่จะใส่
- **WHEN**: ทุก describe block ที่ใช้ mocks

## 5. Async Testing

### 5.1 Async/Await
**MUST** ใช้ async/await สำหรับ async tests, **NEVER** ใช้ callbacks
- Mark test function เป็น `async`
- `await` promises ทั้งหมดก่อน assertions
- ใช้ `expect(promise).rejects.toThrow()` สำหรับ testing promise rejections

### 5.2 Timeouts & Retries
**MUST** กำหนด timeout สำหรับ async tests ที่อาจช้า
- Default timeout: 5000ms, ปรับด้วย `{ timeout: 10000 }`
- ใช้ `retry` option สำหรับ flaky tests (แต่ควร fix root cause แทน)
- **WHEN**: test ต้องรอ external resources (database, API)

### 5.3 Testing Race Conditions
**MUST** test concurrent operations ด้วย `Promise.all()` หรือ `test.concurrent()`
- Verify behavior เมื่อมี multiple async operations พร้อมกัน
- **WHEN**: code มี concurrent logic หรือ shared state

## 6. Mocking Strategies

### 6.1 Module Mocking
**MUST** mock external dependencies เสมอ (filesystem, network, databases)
- ใช้ `vi.mock('module-path')` ที่ top-level (ก่อน imports อื่น)
- Provide mock implementation ที่สมจริง
- **NEVER** mock code ที่กำลัง test (system under test)

### 6.2 Function Mocking
**MUST** ใช้ `vi.fn()` สำหรับ tracking function calls
- Verify call count: `expect(mockFn).toHaveBeenCalledTimes(1)`
- Verify arguments: `expect(mockFn).toHaveBeenCalledWith(expectedArgs)`
- Mock return values: `mockFn.mockReturnValue(value)`

### 6.3 Spy Pattern
**MUST** ใช้ `vi.spyOn()` เมื่อต้องการ observe method โดยไม่ replace implementation
- Useful สำหรับ testing method calls บน objects
- **ALWAYS** restore spies: `spy.mockRestore()` หรือ `vi.restoreAllMocks()`

### 6.4 Timer Mocking
**MUST** mock timers เมื่อ test code ที่ใช้ setTimeout/setInterval
- `vi.useFakeTimers()` ก่อน test
- `vi.advanceTimersByTime(ms)` เพื่อ fast-forward
- `vi.useRealTimers()` ใน afterEach()
- **WHEN**: test ที่มี delays, debounce, throttle

### 6.5 Date Mocking
**MUST** mock Date เมื่อ test time-dependent logic
- `vi.setSystemTime(new Date('2024-01-01'))`
- **ALWAYS** reset: `vi.useRealTimers()` ใน afterEach()
- **WHEN**: logic ขึ้นกับ current date/time

### 6.6 Partial Mocks
**MUST** ใช้ partial mocks เมื่อต้องการ mock บาง exports เท่านั้น
- Pattern: `vi.mock('module', async () => ({ ...await vi.importActual('module'), specificFn: vi.fn() }))`
- **WHEN**: ต้องการ mock เฉพาะส่วน แต่ใช้ implementation จริงส่วนอื่น

## 7. Assertions & Matchers

### 7.1 Specific Matchers
**MUST** ใช้ matcher ที่เฉพาะเจาะจงที่สุด
- ใช้ `toBe()` สำหรับ primitives, `toEqual()` สำหรับ objects/arrays
- ใช้ `toBeNull()`, `toBeUndefined()`, `toBeTruthy()` แทน `toBe(null)` etc.
- ใช้ `toHaveLength()`, `toContain()`, `toMatch()` สำหรับ collections/strings

### 7.2 Custom Matchers
**MUST** สร้าง custom matchers สำหรับ domain-specific assertions ที่ใช้บ่อย
- Define ใน test setup file
- Export และ reuse ข้าม test files
- **WHEN**: มี assertion pattern ที่ซ้ำมากกว่า 3 ครั้ง

### 7.3 Error Testing
**MUST** test error cases อย่างละเอียด
- `expect(() => fn()).toThrow(ErrorClass)`
- Verify error messages: `toThrow('expected message')`
- Test async errors: `await expect(promise).rejects.toThrow()`

## 8. Parameterized Testing

### 8.1 test.each()
**MUST** ใช้ `test.each()` เมื่อ test logic เหมือนกันแต่ inputs/outputs ต่างกัน
- Array syntax: `test.each([[input1, expected1], [input2, expected2]])`
- Object syntax: `test.each([{ input, expected }])`
- **WHEN**: มี test cases ซ้ำมากกว่า 3 อัน

### 8.2 Data-Driven Tests
**MUST** แยก test data ออกเป็น constants/fixtures
- สร้าง test data factories สำหรับ complex objects
- **WHEN**: test data มีความซับซ้อนหรือใช้ซ้ำหลาย tests

## 9. TypeScript Integration

### 9.1 Type-Safe Tests
**MUST** enable TypeScript strict mode สำหรับ test files
- Type test parameters และ return values
- ใช้ generics สำหรับ reusable test utilities

### 9.2 Type Testing
**MUST** test types ด้วย `expectTypeOf` และ `assertType` เมื่อสร้าง libraries/APIs
- Verify return types, parameter types, generic constraints
- **WHEN**: สร้าง public APIs หรือ utility types

## 10. Coverage Management

### 10.1 Coverage Targets
**MUST** maintain minimum coverage: branches 80%, lines 80%
- Critical paths: 95%+ (auth, payment, security)
- Utility functions: 90%+
- Configuration/setup: 60%+ (acceptable)

### 10.2 Coverage Exclusions
**MUST** exclude files ที่ไม่ควร test จาก coverage
- Config files: `*.config.ts`
- Type definitions: `*.d.ts`
- Test utilities: `__tests__/helpers/*`
- Generated code

### 10.3 Coverage Reports
**MUST** review coverage reports ใน CI/CD
- Fail build ถ้า coverage ต่ำกว่า threshold
- Track coverage trends ใน PR comments
- **WHEN**: ทุก PR ที่เปลี่ยนแปลง production code

## 11. Performance Testing

### 11.1 Benchmarking
**MUST** ใช้ `bench()` สำหรับ performance-critical code
- Compare implementations, algorithms
- Set realistic iterations และ time limits
- **WHEN**: optimize performance หรือ compare algorithms

### 11.2 Performance Regression
**MUST** track performance metrics ใน CI
- Fail ถ้า performance degraded มากกว่า threshold (เช่น 20%)
- **WHEN**: มี performance-critical features

## 12. Integration & E2E Testing

### 12.1 Integration Tests
**MUST** แยก integration tests จาก unit tests
- Naming: `*.integration.test.ts`
- Test real dependencies (databases, APIs) ใน isolated environment
- **WHEN**: test interaction ระหว่าง multiple components/services

### 12.2 Test Containers
**MUST** ใช้ test containers สำหรับ testing กับ real databases/services
- Start/stop containers ใน beforeAll/afterAll
- **WHEN**: integration tests ต้องการ real infrastructure

### 12.3 API Contract Testing
**MUST** test API contracts (request/response schemas)
- Verify request validation, response structure
- **WHEN**: สร้างหรือ consume external APIs

## 13. Browser Testing

### 13.1 Browser Mode
**MUST** ใช้ `environment: 'jsdom'` สำหรับ DOM testing
- หรือ `@vitest/browser` สำหรับ real browser testing
- **WHEN**: test UI components, DOM manipulation

### 13.2 DOM Testing
**MUST** cleanup DOM ใน afterEach()
- Reset `document.body.innerHTML = ''`
- **WHEN**: test manipulates DOM

## 14. Test Utilities & Fixtures

### 14.1 Test Factories
**MUST** สร้าง factory functions สำหรับ test data
- Pattern: `createUser(overrides?: Partial<User>): User`
- Provide sensible defaults
- **WHEN**: มี complex objects ที่ใช้ซ้ำ

### 14.2 Setup Files
**MUST** สร้าง `setupTests.ts` สำหรับ global test configuration
- Register custom matchers
- Configure global mocks
- Setup test environment

## 15. CI/CD Integration

### 15.1 Parallel Execution
**MUST** รัน tests แบบ parallel ใน CI
- Config: `test.poolOptions.threads.maxThreads` หรือ `--pool=forks`
- **WHEN**: มี tests มากกว่า 50 ไฟล์

### 15.2 Test Sharding
**MUST** ใช้ sharding สำหรับ large test suites
- `--shard=1/3`, `--shard=2/3`, `--shard=3/3`
- **WHEN**: test suite รันนานกว่า 5 นาที

### 15.3 Flaky Tests
**MUST** fix flaky tests ทันทีที่เจอ, **NEVER** ignore
- Investigate root cause: timing issues, shared state, external dependencies
- ใช้ `--retry` เป็น temporary workaround เท่านั้น

## 16. Developer Experience

### 16.1 Watch Mode
**MUST** ใช้ watch mode ระหว่าง development: `vitest --watch`
- Tests รันอัตโนมัติเมื่อมีการเปลี่ยนแปลง
- **WHEN**: active development

### 16.2 UI Mode
**MUST** ใช้ UI mode สำหรับ debugging: `vitest --ui`
- Visualize test structure, results, coverage
- **WHEN**: debug failing tests หรือ explore test suite

### 16.3 Test Filtering
**MUST** ใช้ filters เพื่อรัน subset ของ tests
- `test.only()`, `test.skip()` ระหว่าง development
- **NEVER** commit `.only()` หรือ `.skip()` (ใช้ git hooks ตรวจ)

### 16.4 Debugging
**MUST** setup debugger สำหรับ tests
- VSCode: launch config สำหรับ Vitest
- Chrome DevTools: `--inspect-brk`
- **WHEN**: test มี complex logic ที่ต้อง step through

## 17. Edge Cases & Error Handling

### 17.1 Input Validation
**MUST** test boundary conditions และ invalid inputs
- Empty values: `null`, `undefined`, `''`, `[]`, `{}`
- Edge values: `0`, `-1`, `Infinity`, `NaN`
- Invalid types: strings when expecting numbers, etc.

### 17.2 Error Scenarios
**MUST** test error paths เท่ากับ happy paths
- Network failures, timeouts
- Database errors
- Permission denied
- **COVERAGE**: error paths ต้อง covered 80%+

## 18. Security Testing

### 18.1 Sensitive Data
**MUST** mock sensitive data ใน tests, **NEVER** hardcode
- ใช้ environment variables หรือ test fixtures
- **NEVER** commit real API keys, passwords, tokens

### 18.2 Security Features
**MUST** test security features อย่างละเอียด
- Authentication, authorization
- Input sanitization, validation
- XSS, CSRF protection
- **WHEN**: implement security-critical features

## 19. Test Maintenance

### 19.1 Test Hygiene
**MUST** review และ refactor tests เหมือนกับ production code
- Remove duplicate tests
- Update obsolete tests
- Improve test names และ structure
- **WHEN**: code review หรือ quarterly maintenance

### 19.2 Test Documentation
**MUST** document complex test setups และ non-obvious behaviors
- ใช้ comments อธิบาย why, not what
- Document test data meanings
- **WHEN**: test logic ซับซ้อนหรือ setup ยาก

## 20. Snapshot Testing

### 20.1 When to Use
**MUST** ใช้ snapshots สำหรับ testing stable outputs เท่านั้น
- Serialized data structures
- Generated code/markup
- **NEVER** snapshot volatile data (timestamps, random IDs)

### 20.2 Snapshot Review
**MUST** review snapshot changes อย่างละเอียดใน PR
- Verify changes เป็น intentional
- Update snapshots: `vitest -u`
- **WHEN**: snapshot tests fail

## Scripts Requirements

**MUST** มี scripts เหล่านี้ใน package.json:
```json
{
  "test": "vitest run",
  "test:watch": "vitest",
  "test:ui": "vitest --ui",
  "test:coverage": "vitest run --coverage",
  "test:ci": "vitest run --coverage --reporter=verbose"
}
```

## Summary: Golden Rules

1. **Isolation**: ทุก test ต้องรันได้อิสระ ไม่พึ่งพา test อื่น
2. **Deterministic**: test ต้องให้ผลลัพธ์เดิมทุกครั้ง ไม่มี flakiness
3. **Fast**: unit tests ควรรันเร็ว (<1s per test), ใช้ mocks สำหรับ slow operations
4. **Readable**: test names และ structure ต้องอ่านเข้าใจทันที
5. **Maintainable**: tests คือ documentation, ต้อง maintain เหมือน production code
6. **Comprehensive**: test happy paths, error paths, edge cases, boundaries
7. **Coverage**: maintain 80%+ overall, 95%+ for critical paths
8. **No Pollution**: cleanup mocks, spies, timers, DOM ใน afterEach() เสมอ


