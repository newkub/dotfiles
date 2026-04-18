---
title: Run Until Pass
description: run command จนกว่าจะผ่าน และแก้ไข error ทั้งหมด
auto_execution_mode: 3
---

## Goal

run command จนกว่าจะผ่าน ถ้าเจอ error ให้แก้ไขท้งหมดจนไม่มีเหลือ

## Execute

### 1. Run Command

run command และตรวจสอบผล

1. รัน command
2. ตรวจสอบว่าผ่านหรือไม่
3. ถ้าไม่ผ่าน ให้ดำเนินการต่อ

### 2. Fix Errors

แก้ไข errors ทั้งหมด

1. ระบุ errors ทั้งหมด
2. แก้ไข errors ทีละตัว
3. รัน command อีกครั้ง
4. ทำซ้ำจนกว่าจะผ่าน

## Rules

- แก้ไข errors ทั้งหมดจนไม่มีเหลือ
- รัน command จนกว่าจะผ่าน
- ตรวจสอบว่าไม่มี errors ที่เหลือ

## Expected Outcome

- Command ผ่านทั้งหมด
- ไม่มี errors ที่เหลือ
- Code ที่ถูกต้อง