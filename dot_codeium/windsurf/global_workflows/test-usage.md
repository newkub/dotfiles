---
title: Test Usage
description: ทดสอบการใช้งานรูปแบบต่างๆ เช่น CLI, API, Browser, SDK, TUI อย่างเป็นระบบ
auto_execution_mode: 3
related:
  - /test-cli
  - /run-test
  - /run-test-browser
  - /run-test-coverage
  - /write-test
  - /deep-review
  - /validate-test
  - /record-terminal
  - /capture-terminal
  - /report
---

## Goal

ทดสอบการใช้งานรูปแบบต่างๆ ของ project อย่างเป็นระบบ ครอบคลุม CLI, API, Browser, SDK, TUI, Mobile, Extension, Bot

## Scope

ใช้สำหรับทดสอบการใช้งานจริงของผู้ใช้ผ่าน interface ต่างๆ ไม่ใช่ unit test แต่เป็น usage test ที่จำลองการใช้งานจริง

## Execute

### 1. Detect Test Targets

ตรวจสอบ project characteristics เพื่อระบุ test targets

1. ตรวจสอบ `package.json`, `Cargo.toml`, `go.mod` เพื่อระบุ project type และ entry points
2. ตรวจสอบ interface types ที่ project มี:
   - **CLI** — `bin/`, `src/cli/`, `src/index.ts` ที่รับ args
   - **API** — `src/server/`, `src/routes/`, HTTP/WebSocket endpoints
   - **Browser** — `src/routes/`, `index.html`, frontend framework
   - **SDK** — `src/index.ts` ที่ export functions สำหรับ developers
   - **TUI** — `ratatui`, `bubbletea`, `blessed`
   - **Mobile** — `capacitor`, `react-native`, `flutter`
   - **Extension** — `manifest.json`, `wxt.config.ts`
   - **Bot** — `bot.py`, webhook handlers
3. บันทึก test targets ที่ตรวจพบลงใน checklist

### 2. Test CLI Usage

ถ้า project มี CLI ให้ทำ `/test-cli` เพื่อทดสอบ commands, options, help documentation และ edge cases แบบครบถ้วน

### 3. Test API Usage

ทดสอบ API endpoints ทั้งหมด ถ้า project มี API

1. ทดสอบทุก endpoint และ HTTP methods (GET, POST, PUT, PATCH, DELETE) ด้วย valid requests
2. ทดสอบ authentication, authorization และ input validation (missing fields, invalid types, boundary values)
3. ทดสอบ error responses, rate limiting และ pagination
4. ใช้ `curl`, `httpie`, หรือ API client สำหรับ testing

### 4. Test Browser Usage

ทดสอบ browser interactions ถ้า project มี web frontend

1. ทำ `/run-test-browser` สำหรับ E2E tests
2. ทดสอบ user flows หลัก (login, navigation, forms, search) และ responsive design
3. ทดสอบ cross-browser compatibility และ accessibility (keyboard, screen reader, ARIA)
4. ทดสอบ real-time features (WebSocket, SSE, live updates)
5. ใช้ `agent-browser` หรือ `Playwright` สำหรับ automation

### 5. Test SDK Usage

ทดสอบ SDK/library usage ถ้า project มี exported API

1. สร้าง test project ที่ import และใช้งาน SDK จริง
2. ทดสอบ public API ทุก function พร้อม input validation และ error handling
3. ทดสอบ type compatibility และ bundler compatibility (Vite, Webpack, esbuild)
4. ทดสอบ tree-shaking และ side effects

### 6. Test TUI Usage

ทดสอบ terminal UI ถ้า project มี TUI

1. รัน TUI app และตรวจสอบ initial render และ keyboard navigation
2. ทดสอบ screens, menus, input forms และ validation
3. ทดสอบ resize behavior, color support และ terminal compatibility
4. ทดสอบ exit และ cleanup

### 7. Test Mobile Usage

ทดสอบ mobile app ถ้า project มี mobile

1. ทำ `cap:sync` หรือ build mobile app แล้วทดสอบบน emulator/simulator และ real device
2. ทดสอบ platform-specific features (camera, geolocation, biometrics)
3. ทดสอบ offline mode, data persistence และ push notifications
4. ทดสอบ app lifecycle (background, foreground, resume)

### 8. Test Extension Usage

ทดสอบ browser extension ถ้า project มี extension

1. โหลด extension ใน browser แล้วทดสอบ popup, options page, content scripts และ background scripts
2. ทดสอบ permissions, API access และ cross-origin requests
3. ทดสอบ storage และ state persistence

### 9. Test Bot Usage

ทดสอบ bot integration ถ้า project มี bot

1. ทดสอบ webhook endpoints และ command/message handlers
2. ทดสอบ authentication, token validation และ message formats (text, rich media, inline keyboards)
3. ทดสอบ rate limits, error handling และ conversation flows

### 10. Record And Report

1. ทำ `/record-terminal` และ `/capture-terminal` เพื่อบันทึก test execution และ screenshots
2. ทำ `/deep-review` เพื่อวิเคราะห์ผล test execution
3. ทำ `/report` สรุปผลลัพธ์ด้วย `/report-format-table` และ `/report-format-terminal`

## Rules

### 1. Test Target Selection

- รันเฉพาะ test targets ที่เกี่ยวข้องกับ project
- ใช้ "ถ้า project มี..." เพื่อกำหนด test types
- เริ่มจาก interface ที่ผู้ใช้ใช้บ่อยที่สุดก่อน

### 2. Test Coverage

- ทดสอบทุก command/endpoint/flow ที่มี ทั้ง success และ error cases
- ทดสอบ edge cases, boundary values และ integration ระหว่าง components

### 3. Output And Error Handling

- `stdout` สำหรับ output ปกติ, `stderr` สำหรับ error messages
- `exit codes` และ HTTP status codes ต้องถูกต้องตาม semantics
- Error messages ที่เข้าใจง่าย มี suggestions สำหรับแก้ไข
- ไม่ crash หรือ hang ในกรณีพิเศษ มี graceful degradation

### 4. Real Environment Testing

- จำลองการใช้งานจริงให้มากที่สุด ใช้ real data ที่เหมือน production
- บันทึก results สำหรับ regression testing

## Expected Outcome

- ทุก test targets ทำงานถูกต้องตามที่ออกแบบ
- Error handling ครอบคลุมทุกกรณี
- Test results บันทึกไว้สำหรับ regression testing
