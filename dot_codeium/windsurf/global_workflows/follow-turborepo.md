---
trigger: always_on
---

# Turborepo Best Practices

## 0. Folder Structure

```
my-turborepo/
├── .github/
│   └── workflows/
│       └── ci.yml
├── apps/
│   ├── app1/
│   └── app2/
├── packages/
│   ├── pkg1/
│   └── pkg2/
├── .gitignore
├── .knip.json           // @ai /follow-knip
├── vitest.config.ts     // @ai /follow-vitest
├── lefthook.yml         // @ai /follow-lefthook
├── package.json         // @ai /follow-package-json
├── turbo.json
└── bun.lock
```



## 1. Root Configuration

### package.json

```json
{
  "name": "",                    // @ai ใช้ชื่อ folder เท่านั้น (ไม่มี @)
  "packageManager": "bun@",      // @ai ใช้ bun upgrade && bun -v เพื่อ version ล่าสุด
  "globalConcurrency": 32,
  "scripts": {
    "watch": "turbo watch verify --ui=tui",
    "preinstall": "bun update --latest -r",
    "prepare": "bunx lefthook install",
    "dev": "turbo dev --ui=tui",
    "format": "turbo format",
    "scan": "bunx sg scan -r",   // @ai /follow-ast-grep
    "check:modules": "bunx node-modules-inspector",
    "lint": "turbo lint",
    "test": "turbo test",
    "build": "turbo build",
    "verify": "turbo verify",
    "devtools": "turbo devtools"
  }
}
```

### turbo.json

กำหนด task ให้ครบตรงกับใน package.json (root)

```json [turbo.json]
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "stream",
  "globalDependencies": [], // @ai กำหนดให้เหมาะสม
  "tasks": {
    "watch": {
      "cache": false,
      "persistent": true
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "prepare": {
      "cache": false
    },
    "format": {
      "dependsOn": ["^prepare"]
    },
    "lint": {
      "dependsOn": ["^format"],
      "cache" : false
    },
    "test": {
      "dependsOn": ["^lint"],
      "cache" : true
    },
    "build": {
      "dependsOn": ["^lint"],
      "outputs": [],
      "cache" : false
    },
    "verify": {
      "dependsOn": ["^test"],
      "cache" : false
    },
    "preview": {
      "dependsOn": ["^verify"]
    }
  }
}
```

## 2. Workspace Configuration

### Requirements

| Rule | Description |
|------|-------------|
| **Follow** | `/follow-package-json`, `/follow-config-file` |
| **Naming** | `name` = folder name |
| **Tasks** | ตรงกับ root scripts ที่มี `turbo` |
| **Files** | `package.json`, `README.md`, `.gitignore` (ทุก workspace) |
| **Examples** | `examples/` สำหรับ `packages/` |

---

## 3. Git Configuration

### .gitignore

เพิ่ม `.turbo`