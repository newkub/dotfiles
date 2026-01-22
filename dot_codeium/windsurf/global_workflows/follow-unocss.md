---
trigger: always_on
description: ตั้งค่า UnoCSS สำหรับโปรเจกต์
instruction:
  - เลือก framework ที่ใช้ (Next.js, Nuxt, Vite, HTML CDN)
  - ติดตั้ง UnoCSS และ dependencies ที่จำเป็น
  - ตั้งค่า config files ตาม framework
  - ทำตาม /follow-unocss-theme เพื่อตั้งค่า theme
condition:
  - ใช้เมื่อเริ่มโปรเจกต์ใหม่ที่ใช้ UnoCSS
  - ใช้เมื่อต้องการติดตั้ง UnoCSS ในโปรเจกต์ที่มีอยู่
goal: ตั้งค่า UnoCSS ให้พร้อมใช้งานในโปรเจกต์
input: framework ที่ใช้ (Next.js, Nuxt, Vite, HTML)
output: config files ที่ตั้งค่า UnoCSS
outcome: สามารถใช้งาน UnoCSS utilities ได้
---

## 1. Installation (ใช้เสมอ)

### 1.1. เลือก framework ที่ใช้

เลือก framework ที่ต้องการติดตั้ง UnoCSS:
- Next.js
- Nuxt
- Vite
- HTML CDN

---

## 2. Setup (ใช้เสมอ)

### 2.1. UnoCSS + Next.js

หากใช้ Next.js ให้ทำตาม /follow-unocss-next

---

### 2.2. UnoCSS + Nuxt

หากใช้ Nuxt ให้ทำตาม /follow-unocss-nuxt

---

### 2.3. UnoCSS + Vite

หากใช้ Vite ให้ทำตาม /follow-unocss-vite

---

### 2.4. UnoCSS + HTML CDN

หากใช้ HTML CDN ให้ทำตาม /follow-unocss-html

---

---

## 3. Theme Configuration (ใช้เมื่อต้องการใช้ theme)

หลังจากตั้งค่า UnoCSS เรียบร้อยแล้ว ให้ทำตาม /follow-unocss-theme เพื่อตั้งค่า theme colors

---

## 4. Usage (ใช้เมื่อเริ่มใช้งาน)

### 4.1. การใช้ UnoCSS utilities

หลังจากติดตั้งและตั้งค่าเรียบร้อยแล้ว สามารถใช้ UnoCSS utilities ได้ทันที:

```html
<!-- ตัวอย่างการใช้งาน -->
<div class="flex items-center justify-center p-4 bg-blue-500 text-white">
  Hello UnoCSS!
</div>
```

### 4.2. การใช้ theme colors

หลังจากทำตาม /follow-unocss-theme แล้ว สามารถใช้ theme colors ได้:

```html
<button class="bg-primary text-primary-foreground hover:bg-primary-hover">
  ปุ่มหลัก
</button>
```
