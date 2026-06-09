---
title: Run Release
description: ทำการ release package ไปยัง npm, crates, vscode, webstore, docker
auto_execution_mode: 3
---

ทำการ release package ไปยัง npm, crates, vscode, webstore, docker

## Goal

Release package ไปยัง npm, crates, vscode, webstore, docker ด้วยการตั้งค่าที่ถูกต้อง

## Execute

### 1. Check Package Configuration

1. สำหรับ npm: ตรวจสอบ package.json มีข้อมูลครบถ้วน
2. สำหรับ crates: ตรวจสอบ Cargo.toml มีข้อมูลครบถ้วน
3. สำหรับ vscode: ตรวจสอบ package.json มี publisher
4. สำหรับ webstore: ตรวจสอบ manifest.json มีข้อมูลครบถ้วน
5. สำหรับ docker: ตรวจสอบ Dockerfile มีข้อมูลครบถ้วน
6. ตรวจสอบ version และ license
7. ตรวจสอบ repository และ homepage

### 2. Setup Authentication with CLI

1. สำหรับ npm: รับ token จาก https://www.npmjs.com/settings/newkubise/tokens (Automation token)
2. สำหรับ npm: ตั้งค่า NPM_TOKEN ใน GitHub Secrets ด้วย (ต้องทำครั้งเดียว):
   ```bash
   gh secret set NPM_TOKEN
   # วาง npm token แล้วกด Enter
   ```
   **Note:** GitHub Actions ต้องมี NPM_TOKEN ใน Secrets เพื่อ publish ได้ ไม่สามารถใช้ token จาก local โดยตรงได้
   **Alternative:** ใช้ npm Trusted Publishers (OIDC) แทน token โดยตั้งค่าใน npm organization settings
3. สำหรับ npm scoped package: ตรวจสอบว่า scope มีใน npm หรือไม่
   - ถ้าไม่มี scope: publish ครั้งแรกใน local ด้วย `bun publish --access public`
   - ถ้า scope มีแล้ว: ตรวจสอบ NPM_TOKEN มีสิทธิ์ publish ไปที่ scope นั้น
4. สำหรับ crates: รับ token จาก https://crates.io/settings/tokens
5. สำหรับ crates: ตั้งค่า CARGO_REGISTRY_TOKEN ด้วย:
   ```bash
   gh secret set CARGO_REGISTRY_TOKEN
   ```
6. สำหรับ vscode: รับ token จาก https://dev.azure.com/
7. สำหรับ vscode: ตั้งค่า VSCE_PAT ด้วย:
   ```bash
   gh secret set VSCE_PAT
   ```
8. สำหรับ webstore: รับ credentials จาก Google Cloud Console
9. สำหรับ webstore: ตั้งค่า CLIENT_ID, CLIENT_SECRET, REFRESH_TOKEN ด้วย:
   ```bash
   gh secret set CLIENT_ID
   gh secret set CLIENT_SECRET
   gh secret set REFRESH_TOKEN
   ```
10. สำหรับ docker: รับ credentials จาก Docker Hub
11. สำหรับ docker: ตั้งค่า DOCKER_USERNAME, DOCKER_PASSWORD ด้วย:
    ```bash
    gh secret set DOCKER_USERNAME
    gh secret set DOCKER_PASSWORD
    ```

### 3. Setup Release Tool

1. สำหรับ npm: ทำ `/release-npm`
2. สำหรับ crates: ทำ `/release-crates`
3. สำหรับ vscode: ทำ `/release-vscode`
4. สำหรับ webstore: ทำ `/release-webstore`
5. สำหรับ docker: ทำ `/release-docker`
6. ตรวจสอบ installation สำเร็จ

### 4. Run Release

1. สำหรับ npm: รัน `bun run release`
2. สำหรับ crates: รัน `cargo release` หรือ `release-plz release`
3. สำหรับ vscode: รัน `vsce publish`
4. สำหรับ webstore: รัน `chrome-webstore-upload`
5. สำหรับ docker: รัน `docker build` และ `docker push`
6. ถ้า release ไม่สำเร็จ ให้ทำข้อ 1 ใหม่จนกว่าจะผ่าน

## Rules

### 1. Package Configuration

- ตรวจสอบ configuration ครบถ้วนก่อน release
- ต้องมี name, version, description, license
- ต้องมี repository และ homepage
- สำหรับ npm: private ต้องเป็น false
- สำหรับ vscode: ต้องมี publisher
- สำหรับ webstore: ต้องมี manifest_version
- สำหรับ docker: ต้องมี Dockerfile

### 2. Authentication

- ตรวจสอบว่ามีสิทธิ์ publish
- สำหรับ npm: ต้องมี NODE_AUTH_TOKEN
- สำหรับ crates: ต้องมี CARGO_REGISTRY_TOKEN
- สำหรับ vscode: ต้องมี VSCE_PAT
- สำหรับ webstore: ต้องมี CLIENT_ID, CLIENT_SECRET, REFRESH_TOKEN
- สำหรับ docker: ต้องมี DOCKER_USERNAME, DOCKER_PASSWORD
- ต้องมี permissions ใน workflow

### 3. Tool Usage

- สำหรับ npm: ใช้ `/release-npm`
- สำหรับ crates: ใช้ `/release-crates`
- สำหรับ vscode: ใช้ `/release-vscode`
- สำหรับ webstore: ใช้ `/release-webstore`
- สำหรับ docker: ใช้ `/release-docker`
- รัน prerelease script ก่อน release

## Expected Outcome

- Package ถูก release สำเร็จ
- Version ถูก bump อัตโนมัติ
- Changelog ถูกสร้างอัตโนมัติ
- Git tags ถูกสร้างอัตโนมัติ

