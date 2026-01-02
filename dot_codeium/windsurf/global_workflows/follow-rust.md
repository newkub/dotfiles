---
trigger: always_on
---
 
 
 

## 1. Setup และเครื่องมือที่แนะนำ (Recommended Tooling)

- **Error Handling**: `thiserror` (สำหรับ Library), `anyhow` (สำหรับ Application)
- **Testing**: `cargo-nextest` (ตัวรันเทสประสิทธิภาพสูง), `mockall` (สำหรับ Mocking)
- **Async**: `tokio` (Asynchronous Runtime)
- **Configuration**: `figment` (จัดการ Config จากหลายแหล่ง)
- **Observability**: `tracing` (สำหรับ Logging และ Tracing), `tracing-subscriber` (ตัวรับและจัดการ Log)

#### package.json (สำหรับ workspace ที่ใช้ turborepo)


```json [package.json]
{
  "name": "",
  "scripts": {
     "dev": "cargo watch -x run",
    "dev:build": "cargo build",

    "check": "cargo check",
    "format": "cargo fmt --all",
    "lint": "cargo clippy --all-targets --all-features -- -D warnings",

    "test": "cargo test --all-features",
    "test:nextest": "cargo nextest run --all-features --verbose",

    "build": "cargo build --release",
    "build:windows": "cargo build --release --target x86_64-pc-windows-msvc",
    "build:linux": "cargo build --release --target x86_64-unknown-linux-gnu",
    "build:mac": "cargo build --release --target x86_64-apple-darwin",

    "build:wasm": "wasm-pack build --out-dir pkg --target bundler",
    "build:node": "napi build --release",

    "audit": "cargo audit",
    "deny": "cargo deny check",

    "verify": "bun run format -- --check && bun run lint && bun run test:nextest && cargo audit && cargo deny check",
    "verify:ci": "bun run format -- --check && bun run lint && bun run test:nextest --ci && cargo audit && cargo deny check"
  }

}
```

## 2. โครงสร้างโปรเจกต์ (Project Structure)

```plaintext
.cargo/config.toml       # Build configurations and optimizations (e.g., sccache)
.github/workflows/ci.yml # CI Pipeline
src/
├── app/           # Application Layer: Orchestrates business flows
├── components/    # Pure Layer: Domain logic ที่บริสุทธิ์
├── services/      # Effect Layer: จัดการ I/O (ผ่าน Traits)
├── adapters/      # Wrappers สำหรับไลบรารีภายนอก (e.g., database client)
├── config/        # โหลดและจัดการการตั้งค่า (Figment)
├── types/         # Data Structures (Structs, Enums, Traits)
├── error/         # Custom Error types (thiserror)
├── utils/         # Helper functions ที่ไม่มี Dependencies ภายใน
├── constants/     # ค่าคงที่
├── telemtry/      # ตั้งค่า Logging/Tracing
├── lib.rs         # Library Entry Point: Public API
└── main.rs        # Application Entry Point (Composition Root)
tests/             # Integration tests
Config.toml        #ไฟล์ Configuration หลัก
```

- **`main.rs` (Composition Root)**: ประกอบร่าง Dependencies, โหลด `config`, ตั้งค่า `telemetry` (logging), แล้วเริ่ม `app`
- **`lib.rs` (Library Entry Point)**: Expose เฉพาะ Public API ที่จำเป็น

## 3. หลักการสำคัญ (Core Principles)

- **Immutability by Default**: ข้อมูลไม่ควรเปลี่ยนแปลงได้เป็นค่าเริ่มต้น
- **Purity**: ฟังก์ชันควรไม่มี Side Effects
- **Explicit Side Effects**: Side Effects ทั้งหมดต้องถูกแยกไปอยู่ `services` Layer
- **Dependency Injection**: ส่ง Dependencies ผ่าน Constructor หรือ Function arguments

## 4. กฎและตัวอย่างในแต่ละ Layer

### `error/`
- **หน้าที่**: นิยาม Error ที่มีความหมายและมีโครงสร้างชัดเจน

```rust
// src/error.rs
use thiserror::Error;

#[derive(Error, Debug)]
pub enum AppError {
    #[error("Configuration error: {0}")]
    Config(#[from] figment::Error),

    #[error("User not found (id: {user_id})")]
    UserNotFound { user_id: String },

    #[error("External service failed: {service_name}")]
    ServiceError { service_name: String, #[source] source: anyhow::Error },

    #[error(transparent)]
    Io(#[from] std::io::Error),
}
```

(ตัวอย่าง `types`, `components`, `services`, `app` เหมือนเดิม แต่ใช้ `AppError` ที่ปรับปรุงแล้ว)

## 5. Testing Strategy

- **Unit Tests**: ทดสอบ `components`, `utils` (Pure functions)
- **Integration Tests**: ทดสอบ `app` Layer โดย Mock `services` (I/O)

## 6. กฎการ Import ระหว่าง Layers

(เหมือนเดิม)

---

## 7. การจัดการ Configuration (`figment`)

- **เป้าหมาย**: แยกการตั้งค่าออกจากโค้ด, โหลดจากหลายแหล่ง (ไฟล์, env) ได้

1.  **สร้าง `Config.toml`**
    ```toml
    [database]
    url = "postgres://user:pass@localhost/db"

    [api]
    port = 8080
    ```

2.  **สร้าง `config.rs`**
    ```rust
    // src/config.rs
    use figment::{Figment, providers::{Format, Toml, Env}};
    use serde::Deserialize;

    #[derive(Deserialize, Debug)]
    pub struct DatabaseConfig {
        pub url: String,
    }

    #[derive(Deserialize, Debug)]
    pub struct ApiConfig {
        pub port: u16,
    }

    #[derive(Deserialize, Debug)]
    pub struct AppConfig {
        pub database: DatabaseConfig,
        pub api: ApiConfig,
    }

    impl AppConfig {
        pub fn load() -> Result<Self, figment::Error> {
            Figment::new()
                .join(Toml::file("Config.toml"))
                .join(Env::prefixed("APP_").split("__"))
                .extract()
        }
    }
    ```
    *หมายเหตุ: `Env` ทำให้เรา override ค่าในไฟล์ด้วย Environment Variable ได้ เช่น `APP_DATABASE__URL=...`*

## 8. การทำ Observability (`tracing`)

- **เป้าหมาย**: มี Log ที่มีโครงสร้างชัดเจน, สามารถติดตามการทำงานของฟังก์ชันได้

1.  **เพิ่ม Dependencies**: `tracing`, `tracing-subscriber`
2.  **สร้าง `telemetry.rs`**
    ```rust
    // src/telemetry.rs
    use tracing_subscriber::{EnvFilter, FmtSubscriber};

    pub fn init_subscriber() {
        let filter = EnvFilter::try_from_default_env()
            .unwrap_or_else(|_| EnvFilter::new("info")); // Log `info` ขึ้นไป

        let subscriber = FmtSubscriber::builder()
            .with_env_filter(filter)
            .finish();

        tracing::subscriber::set_global_default(subscriber)
            .expect("Failed to set tracing subscriber");
    }
    ```
3.  **เรียกใช้ใน `main.rs`**
    ```rust
    // src/main.rs
    fn main() {
        crate::telemetry::init_subscriber();
        // ... aplication code ...
    }
    ```
4.  **การใช้งาน**: ใช้ `#[tracing::instrument]` ที่ฟังก์ชันเพื่อดู input/output หรือใช้ `tracing::info!`, `tracing::error!`

## 9. มาตรฐานเอกสาร (Documentation Standard)

- `///`: สำหรับอธิบาย Public items (functions, structs, modules) จะถูกนำไปสร้างเป็นเอกสารด้วย `cargo doc`
- `//!`: สำหรับอธิบาย Module ที่ตัวเองอยู่ (เขียนไว้บนสุดของไฟล์)

```rust
//! # User Management Module
//!
//! โมดูลนี้จัดการเกี่ยวกับการสร้างและค้นหาผู้ใช้

/// Represents a user in the system.
pub struct User { /* ... */ }

/// Finds a user by their unique ID.
///
/// # Arguments
/// * `id` - The ID of the user to find.
///
/// # Returns
/// An `Option<User>` which is `Some` if found, `None` otherwise.
///
/// # Errors
/// Returns `AppError` if the database connection fails.
pub fn find_user_by_id(id: &str) -> Result<Option<User>, AppError> { /* ... */ }
```

## 10. ตัวอย่าง CI Workflow (GitHub Actions)

- **เป้าหมาย**: ตรวจสอบคุณภาพโค้ดทุกครั้งที่มีการ Push หรือสร้าง Pull Request

**สร้างไฟล์ `.github/workflows/ci.yml`**
```yaml
name: Rust CI

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build_and_test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Rust toolchain
        uses: dtolnay/rust-toolchain@stable
        with:
          components: clippy, fmt

      - name: Check formatting
        run: cargo fmt --all -- --check

      - name: Run Clippy
        run: cargo clippy --all-targets --all-features -- -D warnings

      - name: Run tests
        run: cargo nextest run --all-features

      - name: Build release
        run: cargo build --release --verbose
