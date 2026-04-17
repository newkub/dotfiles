---
description: สร้างหรือปรับปรุง Rust project ด้วย Clean Architecture และ Workspace
title: Rust Best Practices
auto_execution_mode: 3
---

## Goal

กำหนดแนวทางการพัฒนา Rust applications ให้มีประสิทธิภาพสูงสุด

## Execute

### 1. Setup

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

### 4. Code Standards

1. ใช้ modules ตาม Clean Architecture layers
2. ตั้งชื่อไฟล์ด้วย snake_case
3. ตั้งชื่อ types ด้วย PascalCase
4. ใช้ traits สำหรับ abstraction
5. ไม่ใช้ unwrap() ใน production code

### 5. API Design

1. **Naming Conventions** - ทำตาม Rust naming conventions (RFC 430)
   - Casing conforms to RFC 430
   - Ad-hoc conversions follow `as_`, `to_`, `into_` conventions
   - Getter names follow Rust convention
   - Methods on collections that produce iterators follow `iter`, `iter_mut`, `into_iter`
   - Iterator type names match the methods that produce them
   - Feature names are free of placeholder words
   - Names use a consistent word order

2. **Interoperability** - Types ควร interact nicely กับ library อื่นๆ
   - Types eagerly implement common traits (Copy, Clone, Eq, PartialEq, Ord, PartialOrd, Hash, Debug, Display, Default)
   - Conversions use standard traits (From, AsRef, AsMut)
   - Collections implement FromIterator and Extend
   - Data structures implement Serde's Serialize, Deserialize
   - Types are Send and Sync where possible
   - Error types are meaningful and well-behaved
   - Binary number types provide Hex, Octal, Binary formatting
   - Generic reader/writer functions take `R: Read` and `W: Write` by value

3. **Macros** - Macros ควร present อย่าง well-behaved
   - Input syntax is evocative of the output
   - Macros compose well with attributes
   - Item macros work anywhere that items are allowed
   - Item macros support visibility specifiers
   - Type fragments are flexible

### 6. Documentation

1. **Crate Level Docs** - Crate level docs ควร thorough และมี examples
   - ใช้ `//!` สำหรับ crate-level documentation
   - อธิบาย role ของ crate
   - ให้ links ไปยัง technical details
   - อธิบายว่าทำไมควรใช้ crate นี้
   - ให้ examples ของการใช้งานใน real-world setting

2. **Component Documentation** - Public API ทุกอย่างควรมี documentation
   - ใช้โครงสร้าง: [short sentence] [detailed explanation] [code example] [advanced explanations]
   - ทุก public module, trait, struct, enum, function, method, macro, type definition ควรมี example
   - Examples ควรใช้ `?` ไม่ใช่ `try!` หรือ `unwrap`
   - Function docs ควร include error, panic, และ safety considerations
   - ใช้ `# Errors`, `# Panics`, `# Safety` sections ตามความเหมาะสม

3. **Documentation Testing** - Examples ควร compile และ test ได้
   ```rust
   /// ```rust
   /// # use std::error::Error;
   /// #
   /// # fn main() -> Result<(), Box<dyn Error>> {
   /// your;
   /// example?;
   /// code;
   /// #
   /// # Ok(())
   /// # }
   /// ```
   ```

### 7. Development

1. สร้าง directory structure ตามที่วางแปลง
2. ติดตั้ง dependencies ด้วย `cargo add`
3. สร้าง base types, errors, config
4. สร้าง traits และ implementations
5. สร้าง tests สำหรับ critical paths

### 8. Verification

1. รัน `cargo check` ตรวจสอบ compilation errors
2. รัน `cargo clippy` ตรวจสอบ linting
3. รัน `cargo fmt` ตรวจสอบ formatting
4. รัน `cargo test` ยืนยัน tests ผ่าน
5. ทดสอบ `cargo build --release` สำเร็จ

## Rules

- ใช้ Clean Architecture principles
- ใช้ workspace สำหรับ multi-crate projects
- ตั้งชื่อไฟล์ด้วย snake_case
- ตั้งชื่อ types ด้วย PascalCase
- ไม่ใช้ unwrap() ใน production code
- จัดเรียง imports: std, external, internal
- ใช้ `crate::` สำหรับ internal imports
- รัน `cargo check` และ `cargo test` ก่อน commit
- ทำตาม Rust API Guidelines
- เขียน documentation สำหรับ public API ทุกอย่าง
- Examples ใช้ `?` ไม่ใช่ `unwrap` หรือ `try!`
- Implement common traits สำหรับ types

## Expected Outcome

- Rust project ที่มีโครงสร้างถูกต้อง
- Clean Architecture ที่จัดระเบียบดี
- Code ที่มี memory safety และ performance
- Tests ที่ครอบคลุม
- Build และ lint ที่ผ่านทั้งหมด
- Documentation ที่ครบถ้วน
- API ที่ interoperable กับ ecosystem

/e