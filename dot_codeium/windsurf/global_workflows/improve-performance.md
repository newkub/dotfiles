---
title: Improve Performance
description: ปรับปรุง web performance, rendering, scalability และ caching
auto_execution_mode: 3
related_workflows:
  - /improve-web-performance
  - /improve-web-rendering
  - /improve-scalability
  - /improve-performance-tuning
  - /improve-asset
  - /improve-analytics
  - /improve-caching
---

## Goal

ปรับปรุง web performance, rendering, scalability, caching และ asset optimization ของ codebase

## Scope

ใช้สำหรับการปรับปรุงด้าน performance ของ codebase ทั้ง web performance, rendering, bundle size และ analytics

## Execute

### 1. Web Performance And Rendering

1. ถ้า project เป็น web application ทำ `/improve-web-performance`
2. ถ้า project มี rendering ทำ `/improve-web-rendering`

### 2. Scalability, Caching And Tuning

1. ทำ `/improve-scalability` เพื่อปรับปรุง scalability
2. ทำ `/improve-caching` เพื่อปรับปรุง caching strategy ครบวงจร
3. ทำ `/improve-performance-tuning` เพื่อปรับปรุง bundle size และ HTTP caching

### 3. Assets And Analytics

1. ถ้า project มี static assets ทำ `/improve-asset`
2. ถ้า project มี analytics ทำ `/improve-analytics`

## Rules

### 1. Execution Order

- ทำทีละ section และตรวจสอบ
- ถ้าพบ issues ทำ `/resolve-errors` ก่อนดำเนินต่อ
- ทำ `/update-reference` หลังแต่ละ section
- รัน tests หลังแต่ละ improvement และตรวจสอบ coverage ไม่ลดลง

## Expected Outcome

- Web performance และ rendering ถูกปรับปรุง
- Scalability และ caching strategy ดีขึ้น
- Bundle size ลดลง
- Static assets และ analytics ถูกปรับปรุง
