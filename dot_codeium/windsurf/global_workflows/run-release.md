---
title: Run Release
description: Auto-detect platforms จาก project และ release ไปยัง external platforms
auto_execution_mode: 3
---

Auto-detect platforms จาก project และ release ไปยัง external platforms

## Goal

Auto-detect platforms ที่ project รองรับจาก configuration files และ release ไปยัง external platforms อัตโนมัติ

## Scope

High-level workflow สำหรับ auto-detect และ release ไปยัง npm, crates, vscode, webstore, docker

## Execute

### 1. Detect Platforms

ตรวจสอบ platforms ที่ project รองรับจาก configuration files

1. ตรวจสอบ `package.json` มีอยู่ → รองรับ `npm` และ `vscode`
2. ตรวจสอบ `Cargo.toml` มีอยู่ → รองรับ `crates`
3. ตรวจสอบ `manifest.json` มีอยู่ → รองรับ `webstore`
4. ตรวจสอบ `Dockerfile` มีอยู่ → รองรับ `docker`
5. ตรวจสอบ `package.json` มี `publisher` field → รองรับ `vscode`
6. ตรวจสอบ `package.json` มี `private: false` → รองรับ `npm`

### 2. Run Platform-Specific Release

รัน release ตาม platforms ที่ detect ได้

1. ถ้า detect `npm`: ทำ `/run-release-npm`
2. ถ้า detect `crates`: ทำ `/run-release-crates`
3. ถ้า detect `vscode`: ทำ `/run-release-vscode`
4. ถ้า detect `webstore`: ทำ `/run-release-webstore`
5. ถ้า detect `docker`: ทำ `/run-release-docker`

## Rules

### 1. Auto-Detection

ตรวจสอบ platforms จาก configuration files อัตโนมัติ

- ตรวจสอบ `package.json` สำหรับ npm และ vscode
- ตรวจสอบ `Cargo.toml` สำหรับ crates
- ตรวจสอบ `manifest.json` สำหรับ webstore
- ตรวจสอบ `Dockerfile` สำหรับ docker
- ตรวจสอบ `publisher` field สำหรับ vscode
- ตรวจสอบ `private: false` สำหรับ npm

### 2. Workflow Delegation

ใช้ platform-specific workflows ตามที่ detect ได้

- ใช้ `/run-release-npm` สำหรับ npm
- ใช้ `/run-release-crates` สำหรับ crates
- ใช้ `/run-release-vscode` สำหรับ vscode
- ใช้ `/run-release-webstore` สำหรับ webstore
- ใช้ `/run-release-docker` สำหรับ docker
- รันเฉพาะ workflows ที่ detect ได้เท่านั้น

## Expected Outcome

- Platforms ถูก detect อัตโนมัติจาก project configuration
- Packages ถูก release สำเร็จไปยัง platforms ที่ detect ได้
- Version ถูก bump อัตโนมัติ
- Changelog ถูกสร้างอัตโนมัติ
- Git tags ถูกสร้างอัตโนมัติ

