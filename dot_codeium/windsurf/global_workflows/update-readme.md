---
description: อัพเดท README.md ทุก workspace ให้มีรูปแบบที่สอดคล้องกัน
title: update-readme
---

## Objective

อัพเดท README.md ในทุก workspace ให้มีรูปแบบและข้อมูลที่สอดคล้องกัน

## Scope

- ตรวจสอบ README.md ในทุก workspace
- อัพเดท README.md ที่ว่างหรือไม่สมบูรณ์
- ใช้รูปแบบมาตรฐานสำหรับทุก README.md
- ตรวจสอบความถูกต้องของข้อมูลและ commands

## Preconditions

- มี workspaces ในโปรเจกต์
- เข้าใจโครงสร้าง monorepo (apps/, packages/)
- รู้ว่าต้องการอัพเดท README.md แบบไหน

## Execution

### Check

1. ตรวจสอบ README.md หลักของ workspace
2. ตรวจสอบ README.md ใน apps/ ทุกตัว
3. ตรวจสอบ README.md ใน packages/ ทุกตัว
4. สร้างรายการ README.md ที่ต้องอัพเดท

### Update Main

1. เรียก /follow-readme-monorepo สำหรับ README.md หลัก
2. ตรวจสอบว่า README.md หลักสร้างเสร็จแล้ว
3. ตรวจสอบว่ามีข้อมูล packages และ apps ครบถ้วน

### Update Apps

1. เรียก /follow-readme-apps สำหรับแต่ละ app
2. ตรวจสอบว่า README.md ของแต่ละ app สร้างเสร็จแล้ว
3. ตรวจสอบว่ามีข้อมูลเฉพาะของแต่ละ app ครบถ้วน

### Update Packages

1. เรียก /follow-readme-packages สำหรับแต่ละ package
2. ตรวจสอบว่า README.md ของแต่ละ package สร้างเสร็จแล้ว
3. ตรวจสอบว่ามีข้อมูลเฉพาะของแต่ละ package ครบถ้วน

### Verify

1. ตรวจสอบว่าทุก README.md มีรูปแบบที่สอดคล้องกัน
2. ตรวจสอบว่าทุก README.md มีข้อมูลครบถ้วน
3. ตรวจสอบว่า commands ทั้งหมดถูกต้อง
4. ตรวจสอบว่า examples ทั้งหมดใช้งานได้จริง

## Validation

- ทุก README.md มีรูปแบบที่กำหนด
- ข้อมูลใน README.md ครบถ้วนและถูกต้อง
- Commands และ examples ทำงานได้จริง
- รูปแบบสอดคล้องกันในทุก workspace

