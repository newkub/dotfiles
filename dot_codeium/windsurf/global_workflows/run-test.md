---
title: Run Test
description: à¸£à¸±à¸™ test suite à¸•à¸£à¸§à¸ˆà¸«à¸² failures à¹à¸¥à¹‰à¸§ validate/review à¹€à¸žà¸·à¹ˆà¸­à¸£à¸°à¸šà¸¸à¸§à¹ˆà¸²à¸„à¸§à¸£à¹à¸à¹‰ source à¸«à¸£à¸·à¸­ test
auto_execution_mode: 3
related:
  - /run-lint
  - /run-typecheck
  - /write-test
  - /run-test-coverage
  - /validate
  - /validate-test
  - /review
  - /improve-testing
  - /deep-review
  - /report
  - /follow-code-quality
  - /debug-issue
---

## Goal

à¸£à¸±à¸™ test suite à¸­à¸¢à¹ˆà¸²à¸‡à¹€à¸›à¹‡à¸™à¸£à¸°à¸šà¸š à¸•à¸£à¸§à¸ˆà¸«à¸² failures à¹à¸¥à¹‰à¸§ validate/review à¹€à¸žà¸·à¹ˆà¸­à¸à¸³à¸«à¸™à¸”à¸§à¹ˆà¸²à¸„à¸§à¸£à¹à¸à¹‰ source à¸«à¸£à¸·à¸­ test à¹‚à¸”à¸¢à¹„à¸¡à¹ˆà¹à¸à¹‰à¹ƒà¸«à¹‰à¸œà¹ˆà¸²à¸™à¸­à¸±à¸•à¹‚à¸™à¸¡à¸±à¸•à¸´

## Scope

à¸„à¸£à¸­à¸šà¸„à¸¥à¸¸à¸¡ unit, integration, e2e, component, API, database, performance, security, accessibility, i18n, à¹à¸¥à¸° specialized tests à¸•à¸²à¸¡ project needs

## Execute

### 1. Run Lint And Typecheck

1. à¸—à¸³ `/run-lint` à¹€à¸žà¸·à¹ˆà¸­à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š code quality
2. à¸—à¸³ `/run-typecheck` à¹€à¸žà¸·à¹ˆà¸­à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š type safety
3. à¹à¸à¹‰à¹„à¸‚ lint/type errors à¸à¹ˆà¸­à¸™à¸£à¸±à¸™ tests (code quality à¹„à¸¡à¹ˆà¹ƒà¸Šà¹ˆ test failure)

### 2. Setup Test Structure

1. à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š test structure: `test/unit/`, `test/integration/`, `test/e2e/`, `test/fixtures/`, `test/mocks/`, `test/utils/`
2. à¸ªà¸£à¹‰à¸²à¸‡ directories à¸–à¹‰à¸²à¸¢à¸±à¸‡à¹„à¸¡à¹ˆà¸¡à¸µ
3. à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š test frameworks à¸•à¸´à¸”à¸•à¸±à¹‰à¸‡ (Vitest, Playwright)
4. à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š test config files (`vitest.config.ts`, `playwright.config.ts`)

### 3. Prepare Tests

1. à¸–à¹‰à¸² project à¸¢à¸±à¸‡à¹„à¸¡à¹ˆà¸¡à¸µ tests à¸«à¸£à¸·à¸­ coverage à¹„à¸¡à¹ˆà¸„à¸£à¸š à¹ƒà¸«à¹‰à¸—à¸³ `/write-test` à¹€à¸žà¸·à¹ˆà¸­à¸ªà¸£à¹‰à¸²à¸‡ tests à¸—à¸µà¹ˆà¸‚à¸²à¸”à¸«à¸²à¸¢à¹„à¸›
2. à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š test files à¸„à¸£à¸­à¸šà¸„à¸¥à¸¸à¸¡ happy path, edge cases, error cases
3. à¹„à¸¡à¹ˆà¹à¸à¹‰à¹„à¸‚ test assertions à¸«à¸£à¸·à¸­ source code à¹€à¸žà¸·à¹ˆà¸­à¹ƒà¸«à¹‰à¸œà¹ˆà¸²à¸™à¹ƒà¸™à¸‚à¸±à¹‰à¸™à¸•à¸­à¸™à¸™à¸µà¹‰

### 4. Run Core Tests

1. à¸£à¸±à¸™ `bun run test` à¸«à¸£à¸·à¸­ `bun test`
2. à¸šà¸±à¸™à¸—à¸¶à¸à¸œà¸¥à¸¥à¸±à¸žà¸˜à¹Œ, duration, à¹à¸¥à¸°à¸£à¸²à¸¢à¸à¸²à¸£ tests à¸—à¸µà¹ˆ fail
3. à¸–à¹‰à¸²à¸¡à¸µ fail à¹ƒà¸«à¹‰à¹„à¸›à¸‚à¸±à¹‰à¸™à¸•à¸­à¸™ Validate/Review à¸—à¸±à¸™à¸—à¸µ à¹‚à¸”à¸¢à¹„à¸¡à¹ˆà¹à¸à¹‰à¹„à¸‚ code

### 5. Run Specialized Tests (Conditional)

à¸£à¸±à¸™à¹€à¸‰à¸žà¸²à¸° test types à¸—à¸µà¹ˆà¹€à¸à¸µà¹ˆà¸¢à¸§à¸‚à¹‰à¸­à¸‡à¸à¸±à¸š project:

- à¸–à¹‰à¸²à¸¡à¸µ functions/business logic: unit tests à¸ªà¸³à¸«à¸£à¸±à¸š pure functions, edge cases, parameterized tests
- à¸–à¹‰à¸²à¸¡à¸µ integrations à¸£à¸°à¸«à¸§à¹ˆà¸²à¸‡ modules: integration tests à¸ªà¸³à¸«à¸£à¸±à¸š data flow, integration points, error handling
- à¸–à¹‰à¸²à¸¡à¸µ UI: component tests à¹à¸¥à¸° accessibility tests (WCAG, ARIA, keyboard, screen reader)
- à¸–à¹‰à¸²à¸¡à¸µ web frontend: E2E tests à¸”à¹‰à¸§à¸¢ `Playwright`, compatibility tests, agent-browser tests
- à¸–à¹‰à¸²à¸¡à¸µ API: API tests à¹à¸¥à¸° contract tests
- à¸–à¹‰à¸²à¸¡à¸µ database: database tests à¸ªà¸³à¸«à¸£à¸±à¸š queries, migrations, transactions, data integrity, indexes
- à¸–à¹‰à¸²à¸¡à¸µ GraphQL: GraphQL tests à¸ªà¸³à¸«à¸£à¸±à¸š queries, mutations, subscriptions, schema validation, resolvers
- à¸–à¹‰à¸²à¸¡à¸µ WebSocket: WebSocket tests à¸ªà¸³à¸«à¸£à¸±à¸š connections, real-time messaging, reconnection, error handling
- à¸–à¹‰à¸²à¸¡à¸µ file operations: file tests à¸ªà¸³à¸«à¸£à¸±à¸š upload, download, validation, large files, security
- à¸–à¹‰à¸²à¸¡à¸µ i18n: i18n tests à¸ªà¸³à¸«à¸£à¸±à¸š translation completeness, RTL, formatting, locale switching, pluralization
- à¸–à¹‰à¸²à¸¡à¸µ caching: cache tests à¸ªà¸³à¸«à¸£à¸±à¸š invalidation, TTL, CDN caching
- à¸–à¹‰à¸²à¸¡à¸µ network dependencies: network tests à¸ªà¸³à¸«à¸£à¸±à¸š offline mode, retry, timeout, slow connections
- à¸–à¹‰à¸²à¸•à¹‰à¸­à¸‡à¸à¸²à¸£ performance validation: performance tests (unit < 10ms, integration < 100ms) à¹à¸¥à¸° load tests
- à¸–à¹‰à¸²à¸•à¹‰à¸­à¸‡à¸à¸²à¸£ resilience validation: chaos tests
- à¸–à¹‰à¸²à¸¡à¸µ users: usage tests à¹ƒà¸™ production-like environment
- à¸–à¹‰à¸²à¸¡à¸µ critical components: formal verification, security tests, mutation tests (score > 80%)

### 6. Validate And Classify Failures

1. à¸—à¸³ `/validate` à¸à¸±à¸š source code à¸—à¸µà¹ˆà¹€à¸à¸µà¹ˆà¸¢à¸§à¸‚à¹‰à¸­à¸‡à¹€à¸žà¸·à¹ˆà¸­à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸šà¸„à¸§à¸²à¸¡à¸–à¸¹à¸à¸•à¹‰à¸­à¸‡
2. à¸—à¸³ `/validate-test` à¹€à¸žà¸·à¹ˆà¸­à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š test quality, assertions, mocks
3. à¸—à¸³ `/review` à¸«à¸£à¸·à¸­ `/improve-testing` à¹€à¸žà¸·à¹ˆà¸­ review à¸—à¸±à¹‰à¸‡ source à¹à¸¥à¸° test files
4. à¸ˆà¸³à¹à¸™à¸à¸œà¸¥:
   - à¸–à¹‰à¸² source à¸œà¸´à¸” â†’ à¸£à¸°à¸šà¸¸à¹„à¸Ÿà¸¥à¹Œ source à¸—à¸µà¹ˆà¸•à¹‰à¸­à¸‡à¹à¸à¹‰ à¹à¸™à¸°à¸™à¸³ `/fix` à¸«à¸£à¸·à¸­ `/resolve-errors`
   - à¸–à¹‰à¸² test à¸œà¸´à¸” (assertion, mock, expectation) â†’ à¸£à¸°à¸šà¸¸à¹„à¸Ÿà¸¥à¹Œ test à¸—à¸µà¹ˆà¸•à¹‰à¸­à¸‡à¹à¸à¹‰ à¹à¸™à¸°à¸™à¸³ `/write-test` à¸«à¸£à¸·à¸­ `/edit`
   - à¸–à¹‰à¸²à¹„à¸¡à¹ˆà¸Šà¸±à¸”à¹€à¸ˆà¸™ â†’ à¸—à¸³ `/deep-review` à¹à¸¥à¹‰à¸§ report à¸à¹ˆà¸­à¸™à¸”à¸³à¹€à¸™à¸´à¸™à¸à¸²à¸£
5. à¸«à¹‰à¸²à¸¡à¹à¸à¹‰ source à¸«à¸£à¸·à¸­ test à¹‚à¸”à¸¢à¹„à¸¡à¹ˆà¸¡à¸µ evidence à¸ˆà¸²à¸ validate/review

### 7. Fix Based On Classification

1. à¸–à¹‰à¸²à¹„à¸”à¹‰à¸£à¸±à¸šà¸à¸²à¸£à¸¢à¸·à¸™à¸¢à¸±à¸™à¹à¸¥à¸°à¸œà¸¥ validate/review à¸Šà¸±à¸”à¹€à¸ˆà¸™:
   - à¸–à¹‰à¸² source à¸œà¸´à¸” â†’ à¸—à¸³ `/fix` à¸«à¸£à¸·à¸­ `/resolve-errors` à¸à¸±à¸š source
   - à¸–à¹‰à¸² test à¸œà¸´à¸” â†’ à¸—à¸³ `/write-test` à¸«à¸£à¸·à¸­ `/edit` à¸à¸±à¸š test
2. à¸£à¸±à¸™ tests à¸­à¸µà¸à¸„à¸£à¸±à¹‰à¸‡à¸«à¸¥à¸±à¸‡à¹à¸à¹‰à¹„à¸‚
3. à¸–à¹‰à¸²à¸¢à¸±à¸‡ fail à¹ƒà¸«à¹‰à¸à¸¥à¸±à¸šà¹„à¸›à¸‚à¸±à¹‰à¸™à¸•à¸­à¸™ Validate/Review à¹„à¸¡à¹ˆà¹à¸à¹‰à¹ƒà¸«à¹‰à¸œà¹ˆà¸²à¸™à¹à¸šà¸šà¸­à¸±à¸•à¹‚à¸™à¸¡à¸±à¸•à¸´

### 8. Check Coverage

1. à¸—à¸³ `/run-test-coverage` à¹€à¸žà¸·à¹ˆà¸­à¸§à¸´à¹€à¸„à¸£à¸²à¸°à¸«à¹Œ coverage
2. à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š coverage à¸—à¸¸à¸ category (lines, branches, functions, statements)
3. à¸–à¹‰à¸²à¹„à¸¡à¹ˆà¸–à¸¶à¸‡à¹€à¸›à¹‰à¸²à¸«à¸¡à¸²à¸¢ à¹ƒà¸«à¹‰à¸—à¸³ `/write-test` à¹€à¸žà¸´à¹ˆà¸¡ à¹à¸¥à¹‰à¸§à¸£à¸±à¸™ tests à¹ƒà¸«à¸¡à¹ˆ

### 9. Report

1. à¸—à¸³ `/report` à¸ªà¸£à¸¸à¸›à¸œà¸¥à¸¥à¸±à¸žà¸˜à¹Œ
2. à¹ƒà¸Šà¹‰ `/report-format-table` à¸ªà¸³à¸«à¸£à¸±à¸š test results, coverage metrics, à¹à¸¥à¸° action items
3. à¸—à¸³ `/suggest-next-action` à¸«à¸²à¸à¸¢à¸±à¸‡à¸¡à¸µ issues

## Rules

### 1. Test Failure Handling

- Test fail: à¸«à¹‰à¸²à¸¡à¹à¸à¹‰à¹ƒà¸«à¹‰à¸œà¹ˆà¸²à¸™à¹‚à¸”à¸¢à¹„à¸¡à¹ˆ validate/review à¸à¹ˆà¸­à¸™
- Test error: à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š error message à¹à¸¥à¹‰à¸§ classify
- Test pass: continue à¹„à¸› test à¸–à¸±à¸”à¹„à¸›
- Test timeout: à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š performance
- à¸à¹ˆà¸­à¸™à¹à¸à¹‰à¹„à¸‚à¸•à¹‰à¸­à¸‡à¸¡à¸µ evidence à¸§à¹ˆà¸² source à¸«à¸£à¸·à¸­ test à¸œà¸´à¸”

### 2. Validation And Review

- à¸—à¸³ `/validate` à¸à¸±à¸š source à¸—à¸¸à¸à¸„à¸£à¸±à¹‰à¸‡à¹€à¸¡à¸·à¹ˆà¸­ test fail
- à¸—à¸³ `/validate-test` à¸à¸±à¸š test à¸—à¸¸à¸à¸„à¸£à¸±à¹‰à¸‡à¹€à¸¡à¸·à¹ˆà¸­ test fail
- à¸—à¸³ `/review` à¸«à¸£à¸·à¸­ `/improve-testing` à¹€à¸žà¸·à¹ˆà¸­à¸«à¸²à¸•à¹‰à¸™à¹€à¸«à¸•à¸¸
- à¸–à¹‰à¸²à¹„à¸¡à¹ˆà¸Šà¸±à¸”à¹€à¸ˆà¸™ â†’ à¸—à¸³ `/deep-review` à¹à¸¥à¹‰à¸§ report

### 3. Fix Direction

- à¸–à¹‰à¸² source à¸œà¸´à¸” â†’ à¹à¸à¹‰ source à¹„à¸¡à¹ˆà¹ƒà¸Šà¹ˆ test
- à¸–à¹‰à¸² test à¸œà¸´à¸” (outdated, assertion à¸œà¸´à¸”, mock à¸œà¸´à¸”) â†’ à¹à¸à¹‰ test
- à¸«à¹‰à¸²à¸¡à¹à¸à¹‰ assertion à¹ƒà¸«à¹‰à¸­à¹ˆà¸­à¸™à¸¥à¸‡à¹€à¸žà¸·à¹ˆà¸­à¹ƒà¸«à¹‰à¸œà¹ˆà¸²à¸™
- à¸«à¹‰à¸²à¸¡à¹à¸à¹‰ source à¹ƒà¸«à¹‰à¹€à¸‚à¹‰à¸²à¸à¸±à¸š test à¸—à¸µà¹ˆà¸œà¸´à¸”

### 4. Specialized Test Selection

- à¸£à¸±à¸™à¹€à¸‰à¸žà¸²à¸° test types à¸—à¸µà¹ˆà¹€à¸à¸µà¹ˆà¸¢à¸§à¸‚à¹‰à¸­à¸‡à¸à¸±à¸š project
- à¹„à¸¡à¹ˆà¸•à¹‰à¸­à¸‡à¸£à¸±à¸™à¸—à¸¸à¸ type
- à¸–à¹‰à¸²à¹„à¸¡à¹ˆà¹à¸™à¹ˆà¹ƒà¸ˆ à¸–à¸²à¸¡à¸œà¸¹à¹‰à¹ƒà¸Šà¹‰

### 5. Coverage

- à¸•à¸£à¸§à¸ˆà¸ªà¸­à¸š coverage à¸—à¸¸à¸ category (line, branch, function, statement)
- à¹€à¸›à¹‰à¸²à¸«à¸¡à¸²à¸¢ 100% à¸–à¹‰à¸² project à¸à¸³à¸«à¸™à¸”
- à¸–à¹‰à¸²à¸¢à¸±à¸‡à¹„à¸¡à¹ˆà¸–à¸¶à¸‡ à¹ƒà¸«à¹‰à¹€à¸žà¸´à¹ˆà¸¡ tests à¹„à¸¡à¹ˆà¹ƒà¸Šà¹ˆà¸¥à¸” coverage target

### 6. Reporting

- à¸£à¸²à¸¢à¸‡à¸²à¸™à¸Šà¸±à¸”à¹€à¸ˆà¸™à¹à¸¥à¸° action-oriented
- à¸£à¸°à¸šà¸¸ priority
- à¹à¸¢à¸à¸œà¸¥à¹€à¸›à¹‡à¸™ source issue à¸à¸±à¸š test issue

## Expected Outcome

- Tests à¸£à¸±à¸™à¹€à¸ªà¸£à¹‡à¸ˆà¸ªà¸¡à¸šà¸¹à¸£à¸“à¹Œ
- Test failures à¹„à¸”à¹‰à¸£à¸±à¸šà¸à¸²à¸£ validate/review à¹à¸¥à¸°à¸ˆà¸³à¹à¸™à¸à¸§à¹ˆà¸²à¹€à¸›à¹‡à¸™ source à¸«à¸£à¸·à¸­ test issue
- à¹„à¸¡à¹ˆà¸¡à¸µà¸à¸²à¸£à¹à¸à¹‰à¹„à¸‚à¹‚à¸”à¸¢à¹„à¸¡à¹ˆà¸¡à¸µ evidence
- Coverage à¸œà¹ˆà¸²à¸™à¹€à¸›à¹‰à¸²à¸«à¸¡à¸²à¸¢ (à¸–à¹‰à¸²à¸¡à¸µ)
- à¸£à¸²à¸¢à¸‡à¸²à¸™à¸œà¸¥ test results, coverage, à¹à¸¥à¸° action items à¸Šà¸±à¸”à¹€à¸ˆà¸™
