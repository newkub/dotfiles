---
title: Improve Developer Experience
description: Enhance developer productivity with tooling, documentation และ development workflows
auto_execution_mode: 3
---

สร้าง development environment ที่ productive ด้วย tooling, documentation และ workflows ที่ดี

## Goal

เพิ่ม developer productivity และ happiness ด้วย tooling, documentation และ processes ที่ดี

## Execute

### 1. Prepare

1. รัน `/follow-principles` เพื่อดู principles มาตรฐาน
2. สำรวจ current developer pain points
3. กำหนด DX goals และ metrics
4. รวบรวม feedback จากทีม
5. ระบุ priority areas สำหรับ improvement

### 2. Development Environment

1. รัน `/follow-vite` หรือ framework setup ที่เหมาะสม
2. Fast hot reloading - HMR ที่ reliable
3. Consistent local development setup
4. Docker compose สำหรับ services
5. Environment variable management
6. Debugging tools ที่ setup ง่าย
7. IDE configuration - VSCode settings, extensions
8. Pre-configured linting และ formatting

### 3. Documentation

1. Architecture Decision Records (ADRs)
2. Development setup guide - ขั้นตอนการติดตั้ง
3. Coding standards และ conventions
4. API documentation ที่ up-to-date
5. Component documentation - Storybook หรือ similar
6. Troubleshooting guides
7. FAQ สำหรับ common issues
8. Onboarding guide สำหรับ new developers

### 4. Tooling & Automation

1. รัน `/follow-lefthook` สำหรับ Git hooks
2. Automated linting และ formatting
3. Pre-commit hooks สำหรับ quality checks
4. CI/CD pipelines ที่ fast และ reliable
5. Automated testing ใน CI
6. Dependency updates automation - Renovate
7. Security scanning ใน pipeline
8. Automated deployments

### 5. Code Quality Tools

1. รัน `/follow-code-quality` สำหรับ standards
2. Linting - ESLint, oxlint ที่ strict
3. Formatting - Prettier, dprint
4. Type checking - TypeScript strict mode
5. Static analysis - หา potential bugs
6. Complexity analysis - Cyclomatic complexity
7. Test coverage reporting
8. Code review automation

### 6. Maintainability Practices

1. Small functions - ไม่เกิน 20-30 บรรทัด
2. Descriptive names - บอกว่าทำอะไร
3. Consistent style ทั้งทีม
4. Refactoring อย่างต่อเนื่อง
5. Boy scout rule - ทิ้งให้สะอาดกว่าเจอ
6. Technical debt tracking
7. Architecture fitness functions
8. Knowledge sharing - brown bags, docs

### 7. Collaboration & Communication

1. Clear PR templates
2. Code review guidelines
3. Pair programming sessions
4. Team documentation
5. Decision records
6. Meeting notes
7. Async communication ที่ effective
8. Feedback loops ที่รวดเร็ว

## Rules

1. Local Development

- One-command setup - `bun install && bun dev`
- Hot reload ที่ reliable
- Same environment ทุกคน
- Mock data สำหรับ external services
- Local SSL ถ้าจำเป็น
- Debugging ที่ easy

2. Documentation Standards

- ADR สำหรับทุก significant decisions
- README ที่ครบถ้วนในทุก project
- Inline docs สำหรับ complex logic
- Living documentation - อัพเดทตาม code
- Diagrams สำหรับ architecture
- API docs ที่ auto-generated

3. Code Quality

- Pre-commit hooks บังคับ
- CI ที่ block ถ้า fail
- No warnings ใน production build
- 100% TypeScript coverage
- Strict lint rules
- Automated formatting

4. Testing

- Tests รันใน CI ทุก PR
- Coverage reporting
- Fast test suite
- Local test ที่ง่าย
- Test data factories
- Mocking ที่ consistent

5. Onboarding

- Setup ที่ finish ภายในวันแรก
- Onboarding buddy ระบบ
- Step-by-step guide
- Common issues และ solutions
- Codebase tour
- Architecture overview

6. Tooling

- IDE support ที่ดี
- CLI tools สำหรับ common tasks
- Scripts ใน package.json
- Automation ที่ลด manual work
- Monitoring ที่ actionable

## Expected Outcome

1. New developer onboarding ภายในวันแรก
2. Fast feedback loops
3. High code quality โดย default
4. Comprehensive documentation
5. Automated workflows
6. Happy developers
7. Reduced context switching
8. Consistent experiences
