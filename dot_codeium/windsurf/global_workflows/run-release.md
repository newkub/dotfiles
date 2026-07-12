---
title: Run Release
description: Auto-detect platforms และ release ไปยัง external platforms อัตโนมัติ
auto_execution_mode: 3
related:
  - /release-npm
  - /release-crates
  - /release-vscode
  - /release-webstore
  - /release-docker
---

## Goal

Auto-detect platforms ที่ project รองรับจาก configuration files และ release ไปยัง external platforms อัตโนมัติ

## Scope

Release ไปยัง npm, crates.io, VSCode Marketplace, Chrome Web Store, และ Docker Hub

## Execute

### 1. Detect Platforms

ตรวจสอบ platforms ที่ project รองรับจาก configuration files

1. ตรวจสอบ `package.json` มี `private: false` → รองรับ `npm`
2. ตรวจสอบ `package.json` มี `publisher` field → รองรับ `vscode`
3. ตรวจสอบ `Cargo.toml` มีอยู่ → รองรับ `crates`
4. ตรวจสอบ `manifest.json` มีอยู่ → รองรับ `webstore`
5. ตรวจสอบ `Dockerfile` มีอยู่ → รองรับ `docker`

### 2. Check Configuration

ตรวจสอบ configuration ครบถ้วนก่อน release ตาม platforms ที่ detect ได้

- `npm`: ตรวจสอบ `package.json` มี name, version, description, license, repository, homepage, files
- `vscode`: ตรวจสอบ `package.json` มี publisher, engines.vscode, activationEvents, main, contributes
- `crates`: ตรวจสอบ `Cargo.toml` มี name, version, description, license, repository, categories, keywords, edition, rust-version
- `webstore`: ตรวจสอบ `manifest.json` มี name, version, manifest_version, permissions, icons, action
- `docker`: ตรวจสอบ `Dockerfile` มี FROM, WORKDIR, COPY, RUN และ `.dockerignore` มีการ exclude files

### 3. Setup Authentication

ตั้งค่า authentication สำหรับ platforms ที่ detect ได้

- `npm`: ตั้งค่า `NPM_TOKEN` ใน GitHub Secrets ด้วย `gh secret set NPM_TOKEN` (ใช้ Automation token)
- `vscode`: ตั้งค่า `VSCE_PAT` ใน GitHub Secrets ด้วย `gh secret set VSCE_PAT`
- `crates`: ตั้งค่า `CARGO_REGISTRY_TOKEN` ใน GitHub Secrets ด้วย `gh secret set CARGO_REGISTRY_TOKEN`
- `webstore`: ตั้งค่า `CLIENT_ID`, `CLIENT_SECRET`, `REFRESH_TOKEN` ใน GitHub Secrets
- `docker`: ตั้งค่า `DOCKER_USERNAME`, `DOCKER_PASSWORD` ใน GitHub Secrets

### 4. Run Verify

ตรวจสอบคุณภาพโค้ดก่อน release

1. ทำ `/run-verify` เพื่อตรวจสอบคุณภาพโค้ด
2. ถ้า verify ไม่ผ่าน ให้แก้ไขก่อนดำเนินการต่อ

### 5. Setup Release Tool

ตั้งค่า release tool ตาม platforms ที่ detect ได้

1. `npm`: ทำ `/release-npm` เพื่อตั้งค่า release tool
2. `crates`: ทำ `/release-crates` เพื่อตั้งค่า release tool
3. `vscode`: ทำ `/release-vscode` เพื่อตั้งค่า release tool
4. `webstore`: ทำ `/release-webstore` เพื่อตั้งค่า release tool
5. `docker`: ทำ `/release-docker` เพื่อตั้งค่า release tool

### 6. Run Release

รัน release ตาม platforms ที่ detect ได้

1. `npm`: รัน `bun run release` หรือ `npm publish`
2. `crates`: รัน `cargo release` หรือ `release-plz release`
3. `vscode`: รัน `vsce publish`
4. `webstore`: รัน `chrome-webstore-upload`
5. `docker`: รัน `docker build` และ `docker push`
6. ถ้า release ไม่สำเร็จ ให้แก้ไขแล้วรันใหม่จนกว่าจะผ่าน

## Rules

### 1. Auto-Detection

- ตรวจสอบ `package.json` สำหรับ npm และ vscode
- ตรวจสอบ `Cargo.toml` สำหรับ crates
- ตรวจสอบ `manifest.json` สำหรับ webstore
- ตรวจสอบ `Dockerfile` สำหรับ docker
- รันเฉพาะ platforms ที่ detect ได้เท่านั้น

### 2. Configuration Requirements

- ทุก platform ต้องมี name, version, description, license
- `npm`: `private` ต้องเป็น `false`, ต้องมี `repository` และ `homepage`
- `vscode`: ต้องมี `publisher`, `engines.vscode`, `contributes`
- `crates`: ต้องมี `categories`, `keywords`, `edition`, `rust-version`
- `webstore`: ต้องมี `manifest_version`, `permissions`, `icons`
- `docker`: ต้องมี `.dockerignore` และ tag ที่ชัดเจน

### 3. Authentication

- ใช้ API/Automation tokens ไม่ใช่ personal tokens
- ตั้งค่า secrets ใน GitHub Secrets ก่อน release
- ตรวจสอบว่า token มีสิทธิ์ publish ไปที่ package/extension ที่เกี่ยวข้อง
- `npm` alternative: ใช้ npm Trusted Publishers (OIDC) แทน token

### 4. Release Tool Usage

- ใช้ `/release-*` workflows สำหรับตั้งค่า release tool แต่ละ platform
- รัน verify ก่อน release เสมอ
- รัน prerelease script ก่อน release สำหรับ npm
- รัน `vsce package` ก่อน publish สำหรับ vscode
- รัน `chrome-webstore-upload validate` ก่อน publish สำหรับ webstore
- รัน `docker build --no-cache` สำหรับ build ใหม่ทั้งหมด

## Expected Outcome

- Platforms ถูก detect อัตโนมัติจาก project configuration
- Packages ถูก release สำเร็จไปยัง platforms ที่ detect ได้
- Version ถูก bump อัตโนมัติ
- Changelog ถูกสร้างอัตโนมัติ
- Git tags ถูกสร้างอัตโนมัติ
