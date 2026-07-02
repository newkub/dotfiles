---
title: Improve Performance
description: ปรับปรุง performance ของ application ทั้ง bundle แล runtime
auto_execution_mode: 3
related_workflows:
  - /improve-bundle-size
  - /improve-web-performance
  - /improve-scalability
  - /improve-caching
  - /improve-offline
  - /improve-cost
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
- ปรับปรุง Core Web Vitals (LCP, INP, CLS)
- ปรับปรุง FCP, TBT, Speed Index

### 3. Improve Scalability

ปรับปรุง scalability

- ทำ `/improve-scalability` เพื่อปรับปรุง scalability
- ระบุ bottlenecks
- ปรับปรุง horizontal และ vertical scaling

### 4. Improve Caching

ปรับปรุง caching strategy ครบวงจร

- ทำ `/improve-caching` เพื่อปรับปรุง caching strategy
- เพิ่ม cache layers ที่เหมาะสม
- ตั้งค่า cache invalidation
- ใช้ stale-while-revalidate

### 5. Improve Offline

ปรับปรุง offline support และ PWA

- ทำ `/improve-offline` เพื่อปรับปรุง offline support
- เพิ่ม PWA support
- ตั้งค่า background sync
- จัดการ conflict resolution

### 6. Improve Cost

ปรับปรุง cost optimization

- ทำ `/improve-cost` เพื่อปรับปรุง cost ของ infrastructure และ resources
- ปรับขนาด instances ให้เหมาะสม
- ลด underutilized resources

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
- Scalability ดีขึ้น
- Caching ครอบคลุมทุก layers
- Offline support พร้อม PWA
- Performance budgets ผ่าน
