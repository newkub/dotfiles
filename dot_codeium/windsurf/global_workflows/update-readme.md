---
title: Update Readme
description: สร้าง README.md ทั้งหมดใน monorepo ตามประเภทโปรเจกต์ (Single Repo, Monorepo, Workspace) และ README.html
auto_execution_mode: 3
related_workflows:
  - /update-readme-singlerepo
  - /update-readme-monorepo
  - /update-readme-workspace
  - /update-readme-html
---

## Goal

สร้าง README.md ทั้งหมดใน monorepo ตามประเภทโปรเจกต์ โดยเลือก workflow ที่เหมาะสม และสร้าง README.html

## Execute

### 1. Identify Project Type

ตรวจสอบประเภทโปรเจกต์:

1. **Single Repo**: โปรเจกต์เดียว ไม่มี workspaces
2. **Monorepo**: มีหลาย packages ใน repository เดียว
3. **Workspace**: ส่วนหนึ่งของ monorepo ที่ต้องการ README เฉพาะสำหรับ workspace นั้น

### 2. Select Workflow

เลือก workflow ตามประเภทโปรเจกต์:

- **Single Repo**: ทำ `/update-readme-singlerepo`
- **Monorepo**: ทำ `/update-readme-monorepo`
- **Workspace**: ทำ `/update-readme-workspace`

### 3. Execute Selected Workflow

ทำตาม workflow ที่เลือก

### 4. Generate README.html

ทำ `/update-readme-html` เพื่อสร้าง README.html พร้อม tab system สำหรับ Features และ Dependencies

## Rules

### 1. Project Type Detection

ตรวจสอบประเภทโปรเจกต์:

- **Single Repo**: ไม่มี `packages/`, `apps/`, หรือ workspace configuration
- **Monorepo**: มี `packages/`, `apps/`, หรือ workspace configuration (pnpm-workspace.yaml, lerna.json, turbo.json)
- **Workspace**: อยู่ใน monorepo และต้องการ README เฉพาะสำหรับ workspace นั้น

### 2. Workflow Selection

เลือก workflow ตามประเภทโปรเจกต์:

| Project Type | Workflow |
|--------------|----------|
| Single Repo | `/update-readme-singlerepo` |
| Monorepo | `/update-readme-monorepo` |
| Workspace | `/update-readme-workspace` |

## Expected Outcome

- README.md ทั้งหมดใน monorepo ที่เหมาะสมกับประเภทโปรเจกต์
- โครงสร้างสม่ำเสมอตามมาตรฐาน
- ข้อมูลครบถ้วนและเป็นปัจจุบัน
