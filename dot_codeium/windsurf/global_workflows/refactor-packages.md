---
trigger: manual
description: ตัดสินใจ refactor ไปเป็น package ใหม่ หรือใช้ package ที่มีอยู่
instruction:
  - ANALYZE code ที่ต้องการ refactor
  - CHECK packages ที่มีอยู่แล้ว
  - DECIDE ว่าควรสร้างใหม่หรือใช้ที่มี
  - EXECUTE ตามขั้นตอนที่เหมาะสม
condition:
  - ใช้เมื่อมี code ที่ต้องการ refactor ไปเป็น package
---

## 1. Analysis Phase (ใช้เสมอ)

### 1.1. ตรวจสอบลักษณะของ code

1.1.1. CHECK เกณฑ์ที่ควร refactor เป็น package ใหม่
    - มีการใช้งานซ้ำในหลาย apps หรือหลายส่วน
    - เป็น generic logic ที่ไม่ขึ้นกับ business logic ของ app ใด app หนึ่ง
    - มี dependencies ที่ชัดเจนและไม่เฉพาะเจาะจง
    - มีความซับซ้อน > 100 บรรทัด

1.1.2. CHECK เกณฑ์ที่ไม่ควร refactor เป็น package ใหม่
    - เป็น business logic เฉพาะของ app
    - ใช้เพียงครั้งเดียวใน app เดียว
    - มี dependencies ที่เฉพาะเจาะจงกับ app หลัก
    - มีความซับซ้อนน้อย (< 50 บรรทัด)

### 1.2. ตรวจสอบ package ที่มีอยู่

1.2.1. CHECK packages ที่มีอยู่
    - LIST โครงสร้าง packages/ ทั้งหมด
    - READ README และ Cargo.toml ของ packages ที่น่าสนใจ
    - CHECK ว่ามี package ที่มีหน้าที่คล้ายกันหรือไม่

---

## 2. Decision Phase (ใช้เสมอ)

### 2.1. ใช้ package ที่มีอยู่แล้ว

2.1.1. CHECK เงื่อนไขการใช้ package ที่มีอยู่
    - package มี functionality ที่ตรงกับความต้องการ
    - package มี dependencies ที่เข้ากันได้กับ project
    - package มี version และ maintenance ที่ดี

2.1.2. EXECUTE ขั้นตอน
    - ADD dependency ใน Cargo.toml
    - REFACTOR code ให้ใช้ package ที่มีอยู่
    - DELETE code เดิมที่ไม่ใช้แล้ว

### 2.2. สร้าง package ใหม่

2.2.1. CHECK เงื่อนไขการสร้าง package ใหม่
    - ไม่มี package ที่ตรงกับความต้องการ
    - package ที่มีอยู่มี dependencies ที่ไม่เข้ากัน
    - ต้องการ functionality ที่เฉพาะเจาะจงมาก

2.2.2. EXECUTE ขั้นตอน
    - CREATE โครงสร้าง package ใหม่ใน packages/
    - WRITE Cargo.toml ตาม @[/follow-rust]
    - MOVE code ไปยัง package ใหม่
    - ADD dependency ใน apps ที่จะใช้
    - UPDATE workspace members

---

## 3. Package Structure (ใช้เมื่อสร้างใหม่)

### 3.1. โครงสร้างพื้นฐาน

````text
packages/<package-name>/
├── Cargo.toml
├── README.md
├── src/
│   ├── lib.rs
│   ├── error.rs
│   ├── mod.rs (ถ้ามีหลาย modules)
│   └── <modules>/
└── tests/
    └── integration_tests.rs
````

### 3.2. Cargo.toml

````toml
[package]
name = "<package-name>"
version = "0.1.0"
edition = "2021"
description = "<คำอธิบายสั้นๆ>"

[dependencies]
# Error Handling
thiserror = "2.0"
anyhow = "1.0"

# Async
tokio = { version = "1.48", features = ["full"] }

# Config
figment = { version = "0.10", features = ["toml", "env"] }

# Logging
tracing = "0.1"
tracing-subscriber = { version = "0.3", features = ["env-filter"] }

# Internal dependencies
other-package = { path = "../other-package" }

[dev-dependencies]
mockall = "0.14"
pretty_assertions = "1.4"
````

### 3.3. lib.rs

````rust
//! # <Package Name>
//!
//! คำอธิบายสั้นๆ เกี่ยวกับ package

pub mod error;
pub mod <modules>;

// Re-export public APIs
pub use error::*;
````

### 3.4. error.rs

````rust
use thiserror::Error;

#[derive(Error, Debug)]
pub enum PackageError {
    #[error("Configuration error: {0}")]
    Config(#[from] figment::Error),

    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),

    #[error("{0}")]
    Custom(String),
}
````

---

## 4. Testing (ใช้เสมอ)

### 4.1. Unit Tests

- WRITE tests ในไฟล์เดียวกับ code
- USE `#[cfg(test)]` module
- TEST ทุก public function

### 4.2. Integration Tests

- WRITE ใน `tests/` directory
- TEST การทำงานร่วมกันของหลาย modules
- USE mockall สำหรับ mocking

---

## 5. Checklist (ใช้เสมอ)

### 5.1. ก่อน refactor

- ANALYZE code ว่าควร refactor หรือไม่
- CHECK packages ที่มีอยู่แล้ว
- DECIDE ว่าควรสร้างใหม่หรือใช้ที่มี

### 5.2. เมื่อสร้าง package ใหม่

- CREATE โครงสร้าง package
- WRITE Cargo.toml ตาม @[/follow-rust]
- WRITE error.rs ด้วย thiserror
- WRITE tests ให้ครอบคลุม
- UPDATE workspace members
- UPDATE apps ที่ใช้