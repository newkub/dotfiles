---
trigger: always_on
description: ตั้งค่าและใช้งาน Knip สำหรับตรวจสอบ unused code
instruction:
  - ติดตั้ง Knip และ dependencies ที่จำเป็อง
  - ตั้งค่า .knip.json พื้นฐาน
  - กำหนด project structure และ include/exclude patterns
  - รัน knip เพื่อตรวจสอบ unused code
condition:
  - ใช้เมื่อต้องการตรวจสอบ unused code ในโปรเจกต์
  - ใช้เมื่อต้องการลดขนาด bundle และปรับปรุง performance
  - ใช้เมื่อต้องการ clean up dependencies ที่ไม่ได้ใช้
---

# Knip Configuration

## 1. Installation (ใช้เสมอ)

```bash
bun add -D knip
```

---

## 2. Basic Configuration (ใช้เสมอ)

สร้าง `.knip.json` ที่ root:

```json
{
  "$schema": "https://unpkg.com/knip@latest/schema.json",
  "entry": ["apps/*/app.ts", "packages/*/src/index.ts"],
  "project": ["apps/*/package.json", "packages/*/package.json"],
  "ignore": [
    "**/*.config.*",
    "**/*.d.ts",
    "**/dist/**",
    "**/node_modules/**",
    "**/.next/**",
    "**/.nuxt/**",
    "**/.turbo/**"
  ],
  "ignoreDependencies": [
    "@types/*",
    "typescript",
    "bun-types"
  ]
}
```

---

## 3. Project Structure (ใช้เมื่อมี monorepo)

### 3.1. Turborepo Monorepo

```json
{
  "$schema": "https://unpkg.com/knip@latest/schema.json",
  "entry": [
    "apps/*/app.ts",
    "apps/*/app.vue",
    "packages/*/src/index.ts"
  ],
  "project": [
    "apps/*/package.json",
    "packages/*/package.json"
  ],
  "ignoreWorkspaces": false
}
```

---

## 4. Scripts (ใช้เสมอ)

เพิ่มใน `package.json`:

```json
{
  "scripts": {
    "knip": "knip",
    "knip:fix": "knip --fix"
  }
}
```

---

## 5. Integration with Turborepo (ใช้เมื่อมี Turborepo)

เพิ่มใน `turbo.json`:

```json
{
  "tasks": {
    "knip": {
      "dependsOn": ["^build"],
      "cache": false
    }
  }
}
```

---

## 6. Best Practices (ใช้เสมอ)

- **Run Regularly**: รัน knip ก่อน commit
- **Fix Issues**: ใช้ `--fix` flag เพื่อ auto-fix ที่เป็นไปได้
- **Review Exports**: ตรวจสอบ exports ที่ไม่ได้ใช้จริง
- **Keep Updated**: อัปเดต knip เป็น version ล่าสุดอย่างสม่ำเสมอ

---

## 7. Common Patterns (ใช้เมื่อจำเป็น)

### 7.1. Ignore Test Files

```json
{
  "ignore": [
    "**/*.test.ts",
    "**/*.spec.ts",
    "**/__tests__/**"
  ]
}
```

### 7.2. Ignore Config Files

```json
{
  "ignore": [
    "**/*.config.ts",
    "**/*.config.js",
    "**/vite.config.*",
    "**/vitest.config.*"
  ]
}
```

### 7.3. Ignore Dynamic Imports

```json
{
  "ignoreExportsUsedInFile": [
    "**/routes/**",
    "**/pages/**"
  ]
}
```
