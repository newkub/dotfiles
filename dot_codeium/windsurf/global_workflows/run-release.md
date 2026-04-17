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

### 2. Setup Release Tool

1. สำหรับ npm: ทำ `/follow-release-npm`
2. สำหรับ crates: ทำ `/follow-release-crates`
3. สำหรับ vscode: ทำ `/follow-release-vscode`
4. สำหรับ webstore: ทำ `/follow-release-webstore`
5. สำหรับ docker: ทำ `/follow-release-docker`
6. ตรวจสอบ installation สำเร็จ

### 3. Run Release

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

- สำหรับ npm: ใช้ `/follow-release-npm`
- สำหรับ crates: ใช้ `/follow-release-crates`
- สำหรับ vscode: ใช้ `/follow-release-vscode`
- สำหรับ webstore: ใช้ `/follow-release-webstore`
- สำหรับ docker: ใช้ `/follow-release-docker`
- รัน prerelease script ก่อน release

## Expected Outcome

- Package ถูก release สำเร็จ
- Version ถูก bump อัตโนมัติ
- Changelog ถูกสร้างอัตโนมัติ
- Git tags ถูกสร้างอัตโนมัติ
