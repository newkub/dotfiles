---
title: Follow Rust
description: สร้างหรือปรับปรุง Rust project ด้วย Clean Architecture และ Workspace
auto_execution_mode: 3
---

## Goal

กำหนดแนวทางการพัฒนา Rust applications ให้มีประสิทธิภาพสูงสุด

## Execute

### 1. Project Planning

1. ระบุ Project Location ใน monorepo
2. ตัดสินใจใช้ Workspace หรือ Single Crate
3. กำหนด Architecture: Clean Architecture หรือ Standard
4. เลือก Async Runtime: Tokio, async-std, หรือ smol
5. ตัดสินใจใช้ Database หรือไม่ (SQLx, Diesel, หรือ SeaORM)
6. เลือก Web Framework (ถ้าทำ API): Axum, Actix-web, หรือ Rocket

### 2. Directory Structure

1. ใช้ `src/` directory สำหรับ source code
2. สร้าง `crates/` สำหรับ workspace members
3. สร้าง `tests/` สำหรับ integration tests
4. สร้าง `benches/` สำหรับ benchmarks
5. สร้าง `examples/` สำหรับ usage examples

### 3. Configuration

1. ตั้งค่า `Cargo.toml` (workspace หรือ single crate)
2. ตั้งค่า `.cargo/config.toml` สำหรับ build configurations
3. ตั้งค่า `rust-toolchain.toml` สำหรับ Rust version
4. สร้าง `justfile` สำหรับ development scripts
5. ตั้งค่า sccache สำหรับ shared compilation cache

### 4. Quality Enforcement

1. รัน `/follow-cargo` เพื่อตั้งค่า Cargo lint rules
2. รัน `/follow-clippy` เพื่อตั้งค่า Clippy lint rules
3. ตั้งค่า `forbid unsafe_code` ใน workspace
4. ตั้งค่า `cargo-deny` สำหรับ security advisories
5. ตั้งค่า rustdoc warnings เป็น errors

### 5. Verification

1. รัน `cargo check` ตรวจสอบ compilation errors
2. รัน `cargo clippy` ตรวจสอบ linting
3. รัน `cargo fmt` ตรวจสอบ formatting
4. รัน `cargo test` ยืนยัน tests ผ่าน
5. ทดสอบ `cargo build --release` สำเร็จ

## Rules

### 1. Project Structure

ใช้ Clean Architecture และ workspace patterns เพื่อ maintainability

- ใช้ workspace สำหรับ multi-crate projects
- แยก concerns ตาม layers: domain, application, infrastructure
- ใช้ `crates/` สำหรับ workspace members
- ตั้งชื่อไฟล์ด้วย snake_case
- ตั้งชื่อ types ด้วย PascalCase
- ใช้ `mod.rs` เป็น barrel exports เท่านั้น

### 2. Configuration

ตั้งค่า configuration files ให้ถูกต้อง

- ตั้งค่า `Cargo.toml` สำหรับ workspace หรือ single crate
- ตั้งค่า `.cargo/config.toml` ด้วย `[build] jobs = 4`
- ตั้งค่า `[profile.dev]` มี `debug = "line-tables-only"` และ `incremental = true`
- ตั้งค่า `[profile.dev.package."*"]` มี `debug = false`
- ตั้งค่า `[profile.release]` มี `lto = true`, `opt-level = "z"`, `strip = true`, `codegen-units = 1`, `panic = "abort"`
- ตั้งค่า `rust-toolchain.toml` สำหรับ lock Rust version
- ตั้งค่า `rust-version` ใน workspace package
- สร้าง `justfile` สำหรับ development scripts
- ตั้งค่า sccache สำหรับ shared compilation cache

### 3. Code Standards

ทำตาม Rust API Guidelines และ naming conventions

- ทำตาม Rust naming conventions (RFC 430)
- Implement common traits: Copy, Clone, Eq, PartialEq, Ord, PartialOrd, Hash, Debug, Display, Default
- ใช้ traits สำหรับ abstraction
- จัดเรียง imports: std, external, internal
- ใช้ `crate::` สำหรับ internal imports
- ไม่ใช้ `unwrap()` ใน production code
- ใช้ `?` แทน `unwrap()` หรือ `try!`
- ตั้งค่า `forbid unsafe_code` ใน workspace

### 4. Error Handling

ใช้ error handling patterns ที่เหมาะสมกับ context

- ใช้ `thiserror` สำหรับ library errors
- ใช้ `anyhow` สำหรับ application errors
- กำหนด error types ชัดเจนด้วย `#[from]`
- เพิ่ม context ด้วย `.context()`
- Error types ควร implement std::error::Error

### 5. Documentation

เขียน documentation ครบถ้วนสำหรับ public API

- ใช้ `//!` สำหรับ crate-level documentation
- Public API ทุกอย่างควรมี documentation
- Examples ใช้ `?` ไม่ใช่ `unwrap` หรือ `try!`
- Function docs ควร include error, panic, safety considerations
- ใช้ `# Errors`, `# Panics`, `# Safety` sections ตามความเหมาะสม
- ตั้งค่า `RUSTDOCFLAGS="-D rustdoc::all"` ใน CI

### 6. CI/CD

ตั้งค่า CI/CD pipeline สำหรับ quality assurance

- ใช้ GitHub Actions สำหรับ CI
- รัน linting, formatting, tests แบบ parallel
- ทดสอบกับ stable, beta, nightly, และ MSRV
- ทดสอบ cross-platform (ARM, WASM)
- ใช้ `cargo-deny` สำหรับ dependency checks
- ตรวจสอบ dependencies sorted

## Expected Outcome

- Rust project ที่มีโครงสร้างถูกต้อง
- Clean Architecture ที่จัดระเบียบดี
- Code ที่มี memory safety และ performance
- Error handling ที่ robust
- Build และ lint ที่ผ่านทั้งหมด
- Documentation ที่ครบถ้วน
- CI/CD pipeline ที่เข้มงวด