---
title: Improve Performance
description: ปรับปรุง performance ของ application ทั้ง bundle แล runtime
auto_execution_mode: 3
related_workflows:
  - /improve-bundle-size
  - /improve-web-performance
---

## Goal

ปรับปรุง performance ของ application ทั้ง bundle size และ runtime performance

## Scope

ใช้สำหรับปรับปรุง performance ทั้ง build time และ runtime

## Execute

### 1. Improve Bundle Size

ปรับปรุงขนาด bundle

- ทำ `/improve-bundle-size` เพื่อปรับปรุงขนาด bundle

### 2. Improve Web Performance

ปรับปรุง web performance ครบวงจร

- ทำ `/improve-web-performance` เพื่อปรับปรุง web performance ครบวงจร

## Rules

### 1. Performance Budgets

ตั้งค่าและรักษา performance budgets

- ตั้งค่า performance budgets สำหรับ bundle size
- ตั้งค่า performance budgets สำหรับ Core Web Vitals
- ตรวจสอบว่า budgets ผ่านเสมอ
- แจ้งเตือนเมื่อเกิน budgets

### 2. Measure Before And After

วัด performance ก่อนและหลังปรับปรุง

- วัด performance metrics ก่อนปรับปรุง
- วัด performance metrics หลังปรับปรุง
- เปรียบเทียบผลลัพธ์
- ตรวจสอบว่ามีการปรับปรุงจริง

### 3. Optimize Critical Path

ปรับปรุง critical path ก่อน

- ปรับปรุย rendering performance ก่อน
- ปรับปรุย JavaScript execution ก่อน
- ปรับปรุย network requests ก่อน
- ปรับปรุย memory usage ก่อน

## Expected Outcome

- Bundle size ลดลง
- Runtime performance ดีขึ้น
- Rendering performance ดีขึ้น
- Memory usage ลดลง
- Core Web Vitals ดีขึ้น
- Performance budgets ผ่าน
