---
title: Follow Rust
description: สร้างหรือปรับปรุง Rust project ด้วย Clean Architecture และ Workspace
auto_execution_mode: 3
related:
  - /follow-cargo
  - /follow-clippy
  - /follow-clean-architecture
  - /follow-mutants-rs
  - /follow-nextest
  - /follow-test
  - /follow-release-crates
  - /follow-best-practice
  - /follow-code-quality
---

## Goal

กำหนดแนวทางการพัฒนา Rust applications ให้มีประสิทธิภาพสูงสุด

## Scope

ใช้สำหรับสร้างหรือปรับปรุง Rust projects ทั้ง single crate และ workspace

## Execute

### 1. Project Planning

1. ระบุ Project Location ใน monorepo
2. ตัดสินใจใช้ Workspace หรือ Single Crate
3. กำหนด Architecture: Clean Architecture หรือ Standard
4. เลือก Async Runtime: Tokio (default), async-std, หรือ smol
5. ถ้า project มี Database: เลือก SQLx (default), Diesel, หรือ SeaORM
6. ถ้า project มี API: เลือก Axum (default), Actix-web, หรือ Rocket
7. ถ้า project มี TUI: เลือก Ratatui
8. ถ้า project ต้องการ WASM: เลือก wasm-bindgen และ wasm-pack

### 2. Directory Structure

1. ใช้ `src/` directory สำหรับ source code
2. สร้าง `crates/` สำหรับ workspace members
3. สร้าง `tests/` สำหรับ integration tests
4. สร้าง `benches/` สำหรับ benchmarks
5. สร้าง `examples/` สำหรับ usage examples
6. ถ้า project มี Clean Architecture: ทำ `/follow-clean-architecture`

### 3. Configuration

1. ตั้งค่า `Cargo.toml` (workspace หรือ single crate)
2. ตั้งค่า `.cargo/config.toml` สำหรับ build configurations
3. ตั้งค่า `rust-toolchain.toml` สำหรับ Rust version
4. สร้าง `justfile` สำหรับ development scripts
5. ตั้งค่า sccache สำหรับ shared compilation cache

### 4. Quality Enforcement

1. รัน `/follow-cargo` เพื่อตั้งค่า Cargo lint rules และ workspace lint inheritance
2. รัน `/follow-clippy` เพื่อตั้งค่า Clippy lint rules และ thresholds
3. ตั้งค่า `forbid unsafe_code` ใน workspace
4. ตั้งค่า `cargo-deny` สำหรับ security advisories
5. ตั้งค่า rustdoc warnings เป็น errors
6. ใช้ `cargo-nextest` สำหรับ parallel test execution ใน CI
7. ใช้ `cargo-llvm-cov` สำหรับ coverage reporting ใน CI
8. ใช้ Miri สำหรับตรวจสอบ undefined behavior ใน CI

### 5. Verification

1. รัน `cargo check` ตรวจสอบ compilation errors
2. รัน `cargo clippy` ตรวจสอบ linting
3. รัน `cargo fmt` ตรวจสอบ formatting
4. รัน `cargo nextest run` ยืนยัน tests ผ่าน
5. รัน `cargo test --doc` ยืนยัน doctests ผ่าน
6. ทดสอบ `cargo build --release` สำเร็จ
7. ถ้า project มี WASM target: ทดสอบ `cargo build --target wasm32-unknown-unknown`

### 6. Testing Strategy

กำหนด testing strategy ตาม project type

1. ทำ `/follow-test` สำหรับ testing strategy ทั่วไป
2. ใช้ `cargo-nextest` สำหรับ parallel test execution
3. ถ้า project มี business logic: ใช้ `proptest` สำหรับ property-based testing
4. ถ้า project มี API: เขียน integration tests ใน `tests/`
5. ใช้ `#[cfg(test)]` สำหรับ unit tests inline กับ source code
6. ถ้า project มี complex logic: ทำ `/follow-mutants-rs` สำหรับ mutation testing
7. รัน `cargo test --doc` แยกจาก `cargo nextest run` (nextest ไม่รองรับ doctests)

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
- ใช้ builder pattern สำหรับ complex constructors
- ใช้ newtype pattern สำหรับ domain-specific types
- ใช้ `clippy::correctness` เป็น `deny`, `clippy::perf` เป็น `deny`
- ใช้ `clippy::style`, `clippy::suspicious` เป็น `warn`
- ตั้งค่า `dbg_macro`, `todo`, `print_stdout`, `print_stderr` เป็น `warn` (deny ใน CI)

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
- ใช้ `#![warn(missing_docs)]` หรือ `#![deny(missing_docs)]` สำหรับ crate-level enforcement
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
- ใช้ `cargo-nextest` สำหรับ parallel test execution
- ใช้ `cargo-llvm-cov` สำหรับ coverage reporting
- ใช้ Miri สำหรับ undefined behavior detection
- ใช้ `taiki-e/install-action` สำหรับ install CI tools
- ตรวจสอบ dependencies sorted

### 7. Testing

เขียน tests ที่ครอบคลุมและเชื่อถือได้

- ใช้ `#[cfg(test)]` สำหรับ unit tests inline กับ source code
- ใช้ `tests/` สำหรับ integration tests
- ใช้ `proptest` สำหรับ property-based testing
- รัน `cargo test --doc` แยกจาก `cargo nextest run`
- ใช้ `assert!`, `assert_eq!`, `assert_ne!` สำหรับ assertions
- ใช้ `#[should_panic]` สำหรับ testing panic conditions

### 8. Performance

ปรับปรุง performance ด้วย zero-cost abstractions

- ใช้ `criterion` สำหรับ benchmarking ใน `benches/`
- ใช้ `cargo flamegraph` สำหรับ profiling
- หลีกเลี่ยง allocations ใน hot paths
- ใช้ `&str` แทน `String` เมื่อไม่ต้องการ ownership
- ใช้ `Cow<T>` สำหรับ conditional ownership
- ใช้ `SmallVec` สำหรับ small collections
- ตั้งค่า `[profile.release]` ด้วย `lto = true` และ `codegen-units = 1`

### 9. Security

ตั้งค่า security สำหรับ production

- ใช้ `cargo-audit` สำหรับ vulnerability scanning
- ใช้ `cargo-deny` สำหรับ license และ advisory checks
- ตั้งค่า `forbid unsafe_code` ใน workspace
- ตรวจสอบ dependencies ก่อนเพิ่มใหม่
- ใช้ `RUSTSEC` advisory database
- หลีกเลี่ยง `unsafe` blocks ถ้าไม่จำเป็น

### 10. Dependency Management

จัดการ dependencies อย่างมีระบบ

- กำหนด `rust-version` (MSRV) ใน `Cargo.toml`
- ใช้ feature flags สำหรับ optional functionality
- ลด dependencies ให้น้อยที่สุดที่จำเป็น
- ใช้ `[workspace.dependencies]` สำหรับ shared dependency versions
- ตรวจสอบ dependencies sorted ด้วย `cargo sort`
- ใช้ `cargo outdated` สำหรับตรวจสอบ outdated dependencies

### 11. Async Patterns

ใช้ async patterns ที่ถูกต้องและ safe

- ใช้ `tokio` เป็น default async runtime
- ใช้ structured concurrency ด้วย `tokio::task::JoinSet`
- จัดการ cancellation ด้วย `CancellationToken`
- ใช้ `Send + Sync` bounds สำหรับ shared state
- หลีกเลี่ยง `block_on` ใน async context
- ใช้ `tokio::select!` สำหรับ concurrent operations
- ใช้ `Arc<T>` สำหรับ shared ownership ข้าม tasks

## Expected Outcome

- Rust project ที่มีโครงสร้างถูกต้อง
- Clean Architecture ที่จัดระเบียบดี
- Code ที่มี memory safety และ performance
- Error handling ที่ robust
- Testing ที่ครอบคลุมด้วย unit, integration, และ property-based tests
- Performance ที่ optimized ด้วย profiling และ benchmarking
- Security ที่ผ่าน audit และ deny checks
- Dependencies ที่จัดการอย่างเป็นระบบ
- Async patterns ที่ safe และ efficient
- Build และ lint ที่ผ่านทั้งหมด
- Documentation ที่ครบถ้วน
- CI/CD pipeline ที่เข้มงวด
