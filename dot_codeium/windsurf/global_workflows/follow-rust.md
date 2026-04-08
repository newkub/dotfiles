---
title: Follow Rust
description: สร้างหรือปรับปรุง Rust project ด้วย Clean Architecture, Workspace และ Performance Optimization
auto_execution_mode: 3
---

1. Project Requirements

วิเคราะห์โครงสร้างและความต้องการก่อนเริ่มพัฒนา

- ระบุ Project Location ใน monorepo
- ตัดสินใจใช้ Workspace หรือ Single Crate
- กำหนด Architecture: Clean Architecture หรือ Standard
- เลือก Async Runtime: Tokio, async-std, หรือ smol
- ตัดสินใจใช้ Database หรือไม่ (SQLx, Diesel, หรือ SeaORM)
- เลือก Web Framework (ถ้าทำ API): Axum, Actix-web, หรือ Rocket

2. Setup and Development

ดำเนินการตั้งค่าและพัฒนาโปรเจกต์ตามมาตรฐาน

- สร้าง directory structure ตาม Clean Architecture
- ตั้งค่า `Cargo.toml` (workspace หรือ single crate)
- สร้าง crates สำหรับแต่ละ layer (ถ้าใช้ workspace)
- ติดตั้ง dependencies ด้วย `cargo add`
- สร้าง base types, errors, config
- สร้าง traits และ implementations
- ตั้งค่า justfile สำหรับ scripts

3. Quality Verification

ตรวจสอบและยืนยันคุณภาพโค้ดและ build

- รัน `cargo check` ตรวจสอบ compilation errors
- รัน `cargo clippy` ตรวจสอบ linting
- รัน `cargo fmt` ตรวจสอบ formatting
- รัน `cargo test` ยืนยัน tests ผ่าน
- ทดสอบ `cargo build --release` สำเร็จ

4. Directory Structure

ใช้โครงสร้างมาตรฐานสำหรับ Rust projects

- ใช้ `src/` directory สำหรับ source code
- สร้าง `crates/` สำหรับ workspace members
- สร้าง `tests/` สำหรับ integration tests
- สร้าง `benches/` สำหรับ benchmarks
- สร้าง `examples/` สำหรับ usage examples
- ใช้ `docs/` สำหรับ documentation

5. Code Standards

กำหนดมาตรฐานการเขียนโค้ดสำหรับทุกส่วนของโปรเจกต์

- Rust components: ใช้ modules ตาม Clean Architecture layers
- Traits: กำหนด interfaces ใน domain layer
- Types: ใช้ strong types, ไม่ใช้ raw primitives
- Errors: ใช้ thiserror และ anyhow อย่างเหมาะสม
- Imports: ใช้ crate:: สำหรับ internal, จัดเรียงตามลำดับ

6. Config Requirements

ตั้งค่าไฟล์ config ตามมาตรฐานที่กำหนด

- `Cargo.toml`: package metadata, dependencies, features
- `Cargo.lock`: lock file สำหรับ reproducible builds
- `.cargo/config.toml`: build configurations, sccache
- `rust-toolchain.toml`: Rust version specification
- `justfile`: development scripts และ tasks

7. Performance Optimization

ปรับปรุงประสิทธิภาพของ Rust application

- ใช้ cargo flamegraph หา hotspots
- วิเคราะห์ memory allocations ด้วย heaptrack
- ตรวจสอบ binary size ด้วย cargo bloat
- ใช้ zero-copy patterns เมื่อเหมาะสม
- implement arena allocators ถ้าจำเป็น
- ใช้ SIMD instructions สำหรับ CPU-intensive tasks
- parallelize ด้วย rayon สำหรับ data parallelism
- ลด unnecessary allocations
- ใช้ stack allocation แทน heap เมื่อเป็นไปได้

8. Related Workflows

- `/follow-rust-architecture` - โครงสร้างโปรเจกต์ Rust มาตรฐาน
- `/validate` - ตรวจสอบความถูกต้องของ project structure
- `/analyze-project` - วิเคราะห์โครงสร้าง project
- `/optimize-workflows` - ปรับปรุง workflow files
- `/follow-coding-workflows` - แนวทางการพัฒนาโค้ด

## Execute

1. Setup Phase

เตรียมความพร้อมก่อนเริ่มพัฒนา

- ตรวจสอบว่าติดตั้ง Rust แล้ว (rustup)
- ตรวจสอบว่ามี just หรือ cargo-make
- สร้าง backup หรือ commit ก่อนเริ่ม
- รัน tests เดิมให้ผ่านทั้งหมดก่อนเริ่ม (ถ้ามี)

2. Analysis Phase

วิเคราะห์ความต้องการของโปรเจกต์

- ระบุ Project Location และ Architecture
- กำหนด Async Runtime และ Database
- วางแผนโครงสร้าง crates และ modules
- ประเมิน dependencies ที่จำเป็น

3. Development Phase

ดำเนินการตั้งค่าและพัฒนา

- สร้าง directory structure ตามที่วางแปลง
- ตั้งค่า `Cargo.toml` และ config อื่นๆ
- ติดตั้ง dependencies ด้วย `cargo add`
- สร้าง base types, errors, config
- สร้าง traits และ implementations
- สร้าง tests สำหรับ critical paths

4. Verification Phase

ตรวจสอบความถูกต้องและคุณภาพ

- รัน `cargo check` ตรวจสอบ compilation errors
- รัน `cargo clippy` ตรวจสอบ linting
- รัน `cargo fmt` ตรวจสอบ formatting
- รัน `cargo test` ยืนยัน tests ผ่าน
- ทดสอบ `cargo build --release` สำเร็จ

5. Optimization Phase

ปรับปรุงประสิทธิภาพ

- ใช้ cargo flamegraph วิเคราะห์ hotspots
- ใช้ heaptrack ตรวจสอบ memory allocations
- ใช้ cargo bloat วิเคราะห์ binary size
- ปรับปรุง config สำหรับ performance
- benchmark ก่อน/หลัง optimize
- ตรวจสอบว่า correctness ยังคงเดิม

## Rules

1. Architecture Standards

กำหนดมาตรฐานโครงสร้างโปรเจกต์

- ใช้ Clean Architecture principles
- แยก domain, application, interface, infrastructure layers
- ใช้ workspace สำหรับ multi-crate projects
- สร้าง `crates/` สำหรับแต่ละ layer (ถ้าใช้ workspace)

2. Code Style Standards

กำหนดมาตรฐานการเขียนโค้ด

- ใช้ modules ตาม Clean Architecture layers
- ตั้งชื่อไฟล์ด้วย snake_case
- ตั้งชื่อ types ด้วย PascalCase
- ใช้ traits สำหรับ abstraction
- ไม่ใช้ unwrap() ใน production code

3. Import and Dependencies

กำหนดมาตรฐานการ import และ dependencies

- จัดเรียง imports: std, external, internal
- ใช้ `crate::` สำหรับ internal imports
- ใช้ workspace dependencies สำหรับ consistency
- ไม่ใช้ wildcard imports (`use *;`)

4. Testing and Quality

กำหนดมาตรฐานการทดสอบและคุณภาพ

- รัน `cargo check` และ `cargo test` ก่อน commit
- รัน `cargo clippy` และ `cargo fmt` อย่างสม่ำเสมอ
- เขียน unit tests ในไฟล์เดียวกับ source
- เขียน integration tests ใน `tests/`
- รักษา code coverage ไม่ให้ลดลง

5. Performance Standards

กำหนดมาตรฐานประสิทธิภาพ

- วัด performance ก่อนและหลัง optimize
- ใช้ cargo flamegraph วิเคราะห์ bottlenecks
- หลีกเลี่ยง premature optimization
- validate improvements ด้วย data
- ใช้ release mode ในการ benchmark
- ไม่ sacrifice safety เพื่อ performance

