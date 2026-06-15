---
title: Global Rules
description: Routing table และ execution guidelines สำหรับทุก workspace
auto_execution_mode: 3
---

## Goal

Routing user prompts ไปยัง workflows/skills ที่เหมาะสม และทำตาม execution guidelines เพื่อให้การทำงานสม่ำเสมอและมีคุณภาพ

## Scope

ใช้สำหรับทุก workspace เพื่อ routing และ execution ก่อนเริ่ม task ใหม่ทุกครั้ง

## Execute

### 1. Follow Execution Guidelines

ทำตาม `/follow-execution` เสมอก่อนเริ่ม task ใหม่

### 2. Determine Workflow/Skill

ทำตาม `/follow-workflows` และ `/follow-skills` เพื่อเลือก workflow หรือ skill ที่เหมาะสม

## Rules

- ทำตาม `/follow-workflows` เพื่ออ่านและทำตาม workflows ทั้ง global และ project
- ทำตาม `/follow-skills` เพื่ออ่านและใช้ skills ที่มีอยู่
- ใช้ reference แทนการ duplicate เนื้อหา
- ตรวจสอบ references มีอยู่จริงก่อนอ้างอิง
- ตรวจสอบว่า workflow หรือ skill ที่อ้างถึงมีอยู่จริง

## Expected Outcome

- AI เลือก workflow หรือ skill ที่ถูกต้องตาม user prompt
- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มีการ duplicate เนื้อหา
- References ถูกต้องทั้งหมด
