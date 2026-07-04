---
title: Test Usage
description: ทดสอบว่าใช้งานได้จริงๆ ตามที่คาดหวัง
auto_execution_mode: 3
---

## Goal

ทดสอบว่า feature หรือ application ใช้งานได้จริงๆ ตามที่คาดหวัง

## Scope

ใช้สำหรับทดสอบ usage scenarios แบบ manual หรือ real-world testing ที่ต้องการ validate user experience และ actual usage ไม่ใช่ automated testing

## Execute

### 1. Prepare Test Environment

1. ตั้งค่า test environment
2. ตั้งค่า dependencies ที่จำเป็น
3. เตรียม test data
4. ตรวจสอบ prerequisites

### 2. Execute Usage Tests

1. ทดสอบ basic functionality
2. ทดสอบ common workflows
3. ทดสอบ edge cases
4. บันทึก findings

### 3. Validate Results

1. ตรวจสอบ expected behavior
2. ตรวจสอบ issues
3. บันทึก bugs
4. รายงาน results

## Rules

- ทดสอบ usage scenarios ที่ realistic
- ครอบคลุม common user workflows
- บันทึก findings ทั้งหมด
- รายงาน issues อย่างชัดเจน
- สำหรับ automated testing ใช้ `/test-function`, `/test-app`, หรือ `/test-e2e` แทน

## Expected Outcome

1. Feature ใช้งานได้ตามที่คาดหวัง
2. Issues ถูกตรวจพบและรายงาน
3. User experience ได้รับการ validate
4. Documentation ครบถ้วน

