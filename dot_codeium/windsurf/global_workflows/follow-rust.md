---
auto_execution_mode: 3
---

# แนวทางการพัฒนาระบบด้วย Rust เชิงฟังก์ชัน (Functional Rust Guide)

เอกสารนี้เป็นแนวทางสำหรับพัฒนาโปรเจกต์ด้วยภาษา Rust โดยใช้สถาปัตยกรรมที่ได้รับแรงบันดาลใจจากหลักการเขียนโปรแกรมเชิงฟังก์ชัน (Functional Programming) เพื่อสร้างโค้ดที่เข้าใจง่าย, บำรุงรักษาได้, และมีโอกาสเกิดข้อผิดพลาดน้อย

## 1. หลักการสำคัญของ Functional Rust (Core Concepts)

แนวคิดของเราตั้งอยู่บนหลักการสำคัญหลายประการที่ Rust ส่งเสริมโดยธรรมชาติ:

- **Immutability (ความไม่เปลี่ยนรูป):** ข้อมูลควรเป็นแบบอ่านอย่างเดียว (immutable) โดยปริยาย การเปลี่ยนแปลงสถานะทำผ่านการสร้างข้อมูลชุดใหม่ ซึ่งช่วยลด Side Effects และทำให้โค้ดคาดเดาได้ง่ายขึ้น
- **Purity (ฟังก์ชันบริสุทธิ์):** ฟังก์ชันควรมีผลลัพธ์ขึ้นอยู่กับ Input ที่ส่งเข้ามาเท่านั้น และไม่มีการเปลี่ยนแปลงสถานะภายนอก (Side Effects) เช่น การแก้ไขตัวแปร Global, การเขียนไฟล์, หรือการเรียก API
- **Function Composition (การประกอบฟังก์ชัน):** สร้างฟังก์ชันที่ซับซ้อนขึ้นโดยการรวมฟังก์ชันเล็กๆ เข้าด้วยกัน ทำให้โค้ดเป็นโมดูลและนำกลับมาใช้ใหม่ได้ง่าย
- **Higher-Order Functions:** Rust รองรับฟังก์ชันที่รับฟังก์ชันอื่นเป็นอาร์กิวเมนต์ หรือคืนค่าเป็นฟังก์ชันได้ เช่น `map`, `filter`, `fold` ซึ่งเป็นเครื่องมือที่ทรงพลังในการจัดการข้อมูล
- **Ownership & Borrowing:** ระบบ Ownership ของ Rust ช่วยจัดการหน่วยความจำได้อย่างปลอดภัย และบังคับให้เราจัดการกับการเข้าถึงข้อมูลอย่างมีวินัย ซึ่งสอดคล้องกับหลักการของ FP

## 2. สถาปัตยกรรมและโครงสร้างโปรเจกต์ (Architecture & Project Structure)

สถาปัตยกรรมนี้แบ่งแอปพลิเคชันออกเป็น Layer ที่ชัดเจน โดยแยกส่วนที่เป็น Pure Business Logic ออกจากส่วนที่มี Side Effects (I/O) อย่างเด็ดขาด

```
            ┌────────────────────────────────────────────────────┐
            │           Functional Rust (Tokio & Axum)           │
            └────────────────────────────────────────────────────┘

                              ┌──────────┐
                              │  types/  │
                              └─────┬────┘
                                    │ Structs, Enums, Traits
                                    │ • Data modeling
                                    │ • Newtype pattern
                                    │ • Serde for serialization
                                    │
                         ┌──────────┼──────────┐
                         │                     │
                         ▼                     ▼
                    ┌──────────┐          ┌──────────┐
                    │constants/│          │  config/ │
                    └─────┬────┘          └─────┬────┘
                          │                     │
                          │ • Compile-time      │ • Figment loader
                          │ • `const` / `static`  │ • Typed config
                          │ • Immutable         │ • Env vars & files
                          │                     │
                          └──────────┬──────────┘
                                     │
                  ┌──────────────────┼──────────────────┐
                  │                  │                  │
                  ▼                  ▼                  ▼
          ┌───────────────┐  ┌──────────────┐  ┌──────────────┐
          │  Pure Layer   │  │ Effect Layer │  │  adapters/   │
          └───────────────┘  └──────────────┘  └──────────────┘

       ┌──────────┐                  ┌───────────┐
       │components│                  │ services/ │
       └─────┬────┘                  └─────┬─────┘
             │                             │
             │ • Pure functions            │ • Async traits
             │ • Business logic            │ • I/O operations
             │ • `Result<T, E>`            │ • Database, API calls
             │ • No side effects           │ • `AppResult<T>`
             │ • Testable (Unit)           │ • DI via `Arc<dyn Trait>`
             │                             │
        ┌────┴────┐                   ┌────┴─────┐
        │         │                   │          │
        ▼         ▼                   ▼          ▼
   ┌────────┐ ┌────────┐        ┌─────────┐ ┌─────────┐
   │ utils/ │ │adapters│        │  main.rs│ │  tests/ │
   └────────┘ └────────┘        └─────────┘ └─────────┘
    • Iterators • 3rd-party      • Composition • Integration
    • `map`     • `reqwest`        • Root        • `mockall`
    • `filter`  • `sqlx`         • DI Setup    • Test HTTP server
    • `fold`                     • Run program
        │         │                   │          │
        └────┬────┴───────────────────┴────┬─────┘
             │                             │
             └──────────────┬──────────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │  Application    │
                   └─────────────────┘
                            │
                 ┌──────────┼──────────┐
                 │                     │
                 ▼                     ▼
            ┌─────────┐           ┌─────────┐
            │  app/   │           │  lib.rs │
            └─────────┘           └─────────┘
             • Use cases           • Public API
             • Orchestration       • Exports
             • Business flows      • Crate root
             • Error handling
                 │                     │
                 └──────────┬──────────┘
                            │
                            ▼
          ┌─────────────────────────────────────┐
          │      Data Flow & Execution          │
          └─────────────────────────────────────┘
                            │
          Types → Config → Pure → Effect → App
          Model   Load     Logic   I/O      Run
```

### 2.1 โครงสร้างโฟลเดอร์

```plaintext
src/
├── app/           # Application Layer: Orchestrates business flows (Use Cases)
├── components/    # Pure Layer: Business logic ที่บริสุทธิ์
├── services/      # Effect Layer: จัดการ I/O, API calls, Database
├── adapters/      # Wrappers สำหรับไลบรารีภายนอก
├── config/        # โหลดและจัดการการตั้งค่า (Configuration)
├── types/         # Data Structures (Structs, Enums, Traits)
├── utils/         # Helper functions ที่บริสุทธิ์และใช้ได้ทั่วไป
├── constants/     # ค่าคงที่ (Compile-time constants)
├── error/         # Custom Error types และการจัดการข้อผิดพลาด
├── lib.rs         # Library Entry Point
└── main.rs        # Application Entry Point (Composition Root)
tests/             # Integration tests
```

### 2.2 กฎการ Import ระหว่าง Layer

เพื่อให้การแบ่ง Layer มีประสิทธิภาพ เราต้องมีวินัยในการ Import:

```
app         <-- components, services, config, types, error
components  <-- types, constants, error (domain-specific)
services    <-- config, types, error (application)
adapters    <-- (External crates only)
utils       <-- (No internal dependencies)
error       <-- types
```

### 2.4 สำหรับโปรเจกต์ขนาดใหญ่: Workspace & Multi-crate Layout

เมื่อโปรเจกต์เติบโตขึ้น การแบ่งโค้ดออกเป็นหลาย Crate ภายใน Workspace เดียวจะช่วยลดเวลาในการคอมไพล์, แยกแยะ Dependencies, และส่งเสริมการนำโค้ดกลับมาใช้ใหม่ได้ดียิ่งขึ้น

**โครงสร้างที่แนะนำ:**
```plaintext
cargo.toml       # Workspace root
crates/
├── core/          # Crate สำหรับ Pure Logic (types, components)
├── services/      # Crate สำหรับ Service Traits และ Implementations
└── api/           # Crate สำหรับ Application Binary (Axum server, main.rs)
```

- **`core`:** ไม่มี Dependencies เกี่ยวกับ I/O หรือ Web Framework ใดๆ ทำให้คอมไพล์เร็วและนำไปใช้ที่อื่นได้ง่าย
- **`services`:** จัดการการเชื่อมต่อกับโลภายนอก
- **`api`:** ประกอบทุกอย่างเข้าด้วยกัน เป็น Crate เดียวที่รู้จัก Concrete Types ทั้งหมด

### 2.5 รายละเอียดและกฎของแต่ละ Layer

#### `types/`: Data Structures
- **หน้าที่:** กำหนดโครงสร้างข้อมูลหลักของแอปพลิเคชัน เช่น Structs, Enums, และ Traits ที่เป็นตัวแทนของ Domain Model
- **สิ่งที่ควรทำ:**
    - ใช้ `#[derive(Debug, Clone, PartialEq, serde::Serialize, serde::Deserialize)]` ตามความจำเป็น
    - ใช้ Newtype Pattern เพื่อสร้าง Type-safe primitives (เช่น `UserId(u64)` แทน `u64`)
- **สิ่งที่ไม่ควรทำ:** ใส่ Business Logic ที่ซับซ้อน (ควรอยู่ใน `components`)
- **ตัวอย่าง:**
```rust
// src/types/user.rs
#[derive(Debug, Clone, PartialEq)]
pub struct UserId(pub u64);

#[derive(Debug, Clone, PartialEq)]
pub struct User {
    pub id: UserId,
    pub name: String,
}
```

#### `constants/`: ค่าคงที่
- **หน้าที่:** เก็บค่าคงที่ที่ไม่เปลี่ยนแปลงตอน Runtime (Compile-time constants)
- **สิ่งที่ควรทำ:** ใช้ `const` หรือ `static` และตั้งชื่อแบบ `UPPER_SNAKE_CASE`
- **สิ่งที่ไม่ควรทำ:** เก็บค่าที่สามารถเปลี่ยนแปลงได้
- **ตัวอย่าง:**
```rust
// src/constants/api.rs
pub const MAX_RETRIES: u32 = 3;
```

#### `error/`: การจัดการข้อผิดพลาด
- **หน้าที่:** ศูนย์รวมการจัดการ Error ของแอปพลิเคชัน กำหนด Custom Error types และ Type Alias สำหรับ `Result`
- **สิ่งที่ควรทำ:**
    - ใช้ `thiserror` เพื่อสร้าง Error Enum ที่ทรงพลัง
    - สร้าง `AppResult<T>` เป็น Type Alias สำหรับ `Result<T, AppError>` เพื่อใช้ทั่วทั้งแอปพลิเคชัน
- **Error Flow and Boundary Mapping:**
    - ข้อผิดพลาดควรถูกจัดการและแปลงไปตาม Layer อย่างเป็นระบบ:
| Error Type            | เกิดที่ Layer   | ถูกแปลงเมื่อ...                        | ผลลัพธ์ที่ได้      |
| --------------------- | --------------- | -------------------------------------- | ------------------- |
| **Domain-Specific Error** | `components/`   | ถูกเรียกจาก `app/` layer               | `AppError` variant  |
| **`AppError`**          | `app/`, `services/` | อยู่ใน Axum `IntoResponse` impl        | HTTP Response       |
| **Benchmarking**      | - **Micro-benchmarks:** ใช้ `criterion` เพื่อวัดประสิทธิภาพของฟังก์ชันที่สำคัญ (Hot Paths)
|                       |   ```rust
|                       |   // benches/my_benchmark.rs
|                       |   use criterion::{black_box, criterion_group, criterion_main, Criterion};
|                       |   fn my_function(input: u64) -> u64 { /* ... */ }
|                       |   fn criterion_benchmark(c: &mut Criterion) {
|                       |       c.bench_function("my_func 20", |b| b.iter(|| my_function(black_box(20))));
|                       |   }
|                       |   criterion_group!(benches, criterion_benchmark);
|                       |   criterion_main!(benches);
|                       |   ```
|                       | - **Runtime Analysis:** ใช้ `flamegraph` หรือ `tokio-console` เพื่อหาจุดคอขวด (Hotspots) ในระดับ Runtime (แนะนำให้รันใน Local Environment เท่านั้น)
|                       | - **Commands:**
|                       |   ```powershell
|                       |   # Run all benchmarks with criterion
|                       |   cargo bench
|                       |   
|                       |   # Generate a flamegraph (requires `flamegraph` to be installed)
|                       |   cargo flamegraph --bin <your-binary-name>
|                       |   ```
|                       |   ```rust
|                       |   // benches/runtime.rs
|                       |   use tokio::runtime::Runtime;
|                       |   #[tokio::main]
|                       |   async fn main() {
|                       |       let runtime = Runtime::new().unwrap();
|                       |       runtime.block_on(async {
|                       |           // Run your async code here
|                       |       });
|                       |   }
|                       |   ```
- **`app` Layer** จะเป็นผู้รับผิดชอบในการแปลง Domain Error จาก `components` ให้เป็น `AppError` ที่เหมาะสม

    ```rust
    // src/app/user_management.rs
    use crate::components::errors::UserValidationError;
    use crate::error::AppError;

    // Implement the `From` trait for clean conversion
    impl From<UserValidationError> for AppError {
        fn from(err: UserValidationError) -> Self {
            match err {
                UserValidationError::AlreadyAdmin => AppError::Validation("User is already an admin".to_string()),
                UserValidationError::EmptyName => AppError::Validation("User name cannot be empty".to_string()),
            }
        }
    }

    #[cfg(test)]
    mod tests {
        use super::*;

        #[test]
        fn test_error_mapping() {
            let domain_error = UserValidationError::AlreadyAdmin;
            let app_error: AppError = domain_error.into();
            assert!(matches!(app_error, AppError::Validation(_)));
            assert_eq!(app_error.to_string(), "Validation Error: User is already an admin");
        }
    }
    ```
- **กฎเหล็กของ `anyhow`:**
    - **อนุญาต**ให้ใช้ `anyhow::Result<()>` เป็น Return Type ของฟังก์ชัน `main` **ที่เดียวเท่านั้น**
    - **ห้าม**ให้ `anyhow::Error` รั่วไหลเข้าไปใน `services`, `app`, หรือ `components` โดยเด็ดขาด Layer เหล่านี้ต้องคืนค่าเป็น Typed Error เสมอ
- **ตัวอย่าง:**
```rust
// src/error.rs
use thiserror::Error;

#[derive(Error, Debug)]
pub enum AppError {
    #[error("Configuration Error: {0}")]
    Config(String),

    #[error("External API Error: {0}")]
    ExternalApiError(#[from] reqwest::Error),

    #[error("Validation Error: {0}")]
    Validation(String),
}

pub type AppResult<T> = Result<T, AppError>;
```

#### `config/`: การตั้งค่า
- **หน้าที่:** โหลดการตั้งค่าจากไฟล์และ Environment Variables มาเป็น Struct ที่ Type-safe
- **สิ่งที่ควรทำ:**
    - ใช้ `figment` และ `serde` เพื่อความสะดวกและปลอดภัย
    - แยกไฟล์ Config ตามสภาพแวดล้อม (เช่น `dev.toml`, `prod.toml`)
- **สิ่งที่ไม่ควรทำ:** Hardcode ค่า Config หรือ Secrets ไว้ในโค้ดส่วนอื่น
- **การจัดการ Secrets:** สำหรับข้อมูลที่ละเอียดอ่อน (เช่น API Keys) ให้โหลดจาก Environment Variables หรือใช้บริการจัดการ Secret เช่น HashiCorp Vault แทนการเก็บเป็น Plaintext ในไฟล์ Config
- **ตัวอย่าง:**
```rust
// src/config.rs
use figment::{Figment, providers::{Format, Toml, Env}};
use serde::Deserialize;
use crate::error::{AppError, AppResult};

#[derive(Debug, Clone, Deserialize)]
pub struct ApiConfig {
    pub base_url: String,
}

#[derive(Debug, Clone, Deserialize)]
pub struct AppConfig {
    pub api: ApiConfig,
}

impl AppConfig {
    pub fn load() -> AppResult<Self> {
        Figment::new()
            .merge(Toml::file("Config.toml"))
            .merge(Env::prefixed("APP_"))
            .extract()
            .map_err(|e| AppError::Config(e.to_string()))
    }
}
```

#### `utils/`: Helper Functions
- **หน้าที่:** เก็บฟังก์ชันบริสุทธิ์ที่สามารถใช้ได้ทั่วไปและไม่มีความเกี่ยวข้องกับ Business Logic โดยตรง
- **Functional:** ต้องเป็น Pure Function, จัดการกับ Immutable Data, และส่งเสริม Function Composition
- **Testing:** ต้องมี Unit Test ครบทุกฟังก์ชัน
- **ตัวอย่าง:**
```rust
// src/utils/formatters.rs
pub fn to_uppercase_names<'a>(
    names: impl Iterator<Item = &'a str>,
) -> impl Iterator<Item = String> + 'a {
    names.map(|name| name.to_uppercase())
}
```

#### `components/`: Pure Business Logic
- **หน้าที่:** เป็นหัวใจของแอปพลิเคชัน ประกอบด้วย Business Logic ทั้งหมดในรูปแบบของฟังก์ชันบริสุทธิ์
- **Functional:** ต้องเป็น Pure Function, รับ Input เป็น `types` และคืนค่าเป็น `Result<T, DomainError>`
- **Dependencies:** ห้ามขึ้นอยู่กับ `AppError`, `config`, หรือ `services` โดยเด็ดขาด
- **Testing:** ทดสอบได้ง่ายที่สุดด้วย Unit Test เพราะไม่มี Side Effects
- **ตัวอย่าง:**
```rust
// src/components/errors.rs
#[derive(Debug, Clone, PartialEq)]
pub enum UserValidationError {
    EmptyName,
    AlreadyAdmin,
}

// src/components/user_logic.rs
use crate::{types::user::{User, UserId}, components::errors::UserValidationError};

// Query (Pure function)
pub fn can_be_promoted(user: &User, current_admins: &[UserId]) -> Result<(), UserValidationError> {
    if current_admins.contains(&user.id) {
        return Err(UserValidationError::AlreadyAdmin);
    }
    // ... other rules
    Ok(())
}
```

#### `services/`: Effect Layer (Side Effects)
- **หน้าที่:** จัดการกับการทำงานที่มี Side Effects ทั้งหมด เช่น การเรียก API, การติดต่อฐานข้อมูล, หรือการอ่าน/เขียนไฟล์
- **Design:** ใช้ Trait-based design เพื่อทำ Dependency Injection (DI) ทำให้สามารถสลับระหว่าง Implementation จริงกับ Mock ในการทดสอบได้
- **Return Value:** คืนค่าเป็น `AppResult<T>` เสมอ
- **สิ่งที่ไม่ควรทำ:** ใส่ Business Logic (ควรอยู่ใน `components`)
- **Testing:** ทดสอบผ่าน Integration Test โดยใช้ Mocking Library เช่น `mockall`
- **การออกแบบ Trait (Generics vs. `dyn Trait`):**
    - **`Arc<dyn Trait>` (Trait Objects):**
        - **ข้อดี:** เป็น Dynamic Dispatch ทำให้ง่ายต่อการทำ DI และ Mocking ใน `main.rs` โดยไม่ต้องเปลี่ยน Signature ของฟังก์ชัน, ลดเวลาคอมไพล์
        - **ข้อเสีย:** มี Runtime Overhead เล็กน้อยจากการใช้ vtable
        - **แนะนำสำหรับ:** `app` Layer และ `main.rs` เพื่อความยืดหยุ่น
    - **Generics (`impl Trait`):
        - **ข้อดี:** เป็น Static Dispatch (Zero-cost Abstraction) ทำให้มีประสิทธิภาพสูงสุด
        - **ข้อเสีย:** ทำให้โค้ดซับซ้อนขึ้น (viral generics), อาจเพิ่มเวลาคอมไพล์
        - **แนะนำสำหรับ:** ภายใน `services` Layer หรือใน Performance-critical paths
- **ตัวอย่าง:**
```rust
// src/services/user_api.rs
use crate::{types::user::User, error::AppResult, config::AppConfig};

#[async_trait::async_trait]
pub trait UserApi {
    async fn fetch_user(&self, id: u64) -> AppResult<User>;
    async fn set_admin_role(&self, id: UserId) -> AppResult<()>;
}

pub struct LiveUserApi { 
    client: reqwest::Client,
    config: AppConfig,
}

#[async_trait::async_trait]
impl UserApi for LiveUserApi {
    // ... implementation
}
```

#### `app/`: Application & Orchestration Layer
- **หน้าที่:** เป็นตัวกลางที่เชื่อมระหว่างโลกของ Pure Logic (`components`) และโลกของ Side Effects (`services`) ทำหน้าที่ Orchestrate Business Flows หรือ Use Cases
- **Logic:** เรียกใช้ฟังก์ชันจาก `components` เพื่อตัดสินใจ และเรียกใช้ `services` เพื่อกระทำ Side Effects
- **ตัวอย่าง:**
```rust
// src/app/user_management.rs
use std::sync::Arc;
use crate::{services::user_api::UserApi, components, types::user::UserId, error::AppResult};

pub struct UserManagement {
    user_api: Arc<dyn UserApi>,
}

impl UserManagement {
    // Command (Effectful function)
    #[tracing::instrument(skip(self))]
    pub async fn promote_user(&self, user_id: u64) -> AppResult<()> {
        let user = self.user_api.fetch_user(user_id).await?;
        let admins = self.user_api.fetch_admins().await?;

        // 1. Call pure logic from `components`
        components::user_logic::can_be_promoted(&user, &admins)?;

        // 2. Perform the side effect via `services`
        self.user_api.set_admin_role(user.id).await?;
        Ok(())
    }
}
```

## 3. การนำไปใช้งานจริง (Implementation & Tooling)

ส่วนนี้จะอธิบายถึงเครื่องมือที่ใช้, กลยุทธ์การทดสอบ, และการประกอบทุกส่วนเข้าด้วยกันเพื่อสร้างแอปพลิเคชันที่สมบูรณ์

### 3.1 เครื่องมือและการตั้งค่า (Tooling)

`cargo.toml` คือศูนย์กลางของ Dependencies ทั้งหมด:

```toml
[package]
name = "functional-rust-app"
version = "0.1.0"
edition = "2021"

[dependencies]
# Error Handling
anyhow = "1.0"
thiserror = "1.0"

# Serialization
serde = { version = "1.0", features = ["derive"] }

# Async & Web
tokio = { version = "1.0", features = ["full"] }
axum = "0.7"
reqwest = { version = "0.11", features = ["json"] }
async-trait = "0.1"

# Logging & Tracing
tracing = "0.1"
tracing-subscriber = "0.3"

# Config
figment = { version = "0.10", features = ["toml", "env"] }

[dev-dependencies]
# Testing
mockall = "0.12"
proptest = "1.4"
```

### 3.2 กลยุทธ์การทดสอบ (Testing Strategy)

- **Unit Tests:** สำหรับ `components` และ `utils` ที่เป็น Pure Functions สามารถทดสอบได้โดยตรงด้วย Input และ Output ที่คาดหวัง
- **Integration Tests:** ทดสอบ `app` Layer โดย Mock `services` (I/O) เพื่อจำลอง Side Effects ทำให้เราสามารถทดสอบ Business Flow ทั้งหมดได้โดยไม่ต้องเชื่อมต่อกับระบบภายนอกจริงๆ
- **Contract Tests:** เขียนเทสเพื่อยืนยัน "สัญญา" ระหว่าง `app` Layer และ `services` Layer โดยเฉพาะการตั้งค่า Expectations ของ Mock (`mockall`) ควรสอดคล้องกับพฤติกรรมจริงของ Service นั้นๆ เพื่อป้องกัน Regression เมื่อมีการเปลี่ยนแปลง Implementation

**ตัวอย่าง Contract Test (ส่วนหนึ่งของ Integration Test):**

Contract Test คือการยืนยันว่า Mock Object ของเรามีพฤติกรรมตรงตาม "สัญญา" ที่คาดหวังจาก Service จริง

```rust
// tests/user_management_test.rs
use mockall::predicate::*;

// ... (setup)

#[tokio::test]
async fn test_promote_user_contract() {
    let mut mock_api = MockUserApi::new();
    let user_id_to_promote = 10;

    // Contract: `fetch_user` must be called EXACTLY ONCE with the correct ID.
    mock_api.expect_fetch_user()
        .with(eq(user_id_to_promote))
        .times(1)
        .returning(move |_| Ok(User { id: UserId(user_id_to_promote), name: "test".to_string() }));

    // Contract: `set_admin_role` must be called EXACTLY ONCE with the correct user ID.
    mock_api.expect_set_admin_role()
        .with(eq(UserId(user_id_to_promote)))
        .times(1)
        .returning(|_| Ok(()));

    // Contract: If the user is already an admin, `set_admin_role` must NEVER be called.
    let mut mock_api_admin = MockUserApi::new();
    let admin_user_id = 1;
    mock_api_admin.expect_fetch_user()
        .returning(move |_| Ok(User { id: UserId(admin_user_id), name: "admin".to_string() }));
    mock_api_admin.expect_set_admin_role().times(0); // Expect NOT to be called

    // ... (Act & Assert for both scenarios)
}

### 3.3 In-process Testing สำหรับ API Layer

เราสามารถทดสอบ Axum Router ทั้งหมดแบบ In-process ได้ ซึ่งเป็นการทดสอบที่ใกล้เคียงกับ Production มากที่สุดโดยไม่ต้องเปิด Port จริง

```rust
// tests/api_test.rs
use axum::{
    body::Body,
    http::{Request, StatusCode},
};
use tower::ServiceExt; // for `oneshot`

// ... (imports for AppState, mocks, etc.)

#[tokio::test]
asyn fn test_promote_user_endpoint_success() {
    // 1. Arrange: Create a mock service that expects a call and returns success.
    let mut mock_api = MockUserApi::new();
    mock_api.expect_promote_user().times(1).returning(|_| Ok(()));

    // 2. Arrange: Build the app state and router with the mock.
    let app_state = build_app_state_with_mock(Arc::new(mock_api)); // A test helper function
    let app = create_router(app_state); // A helper that returns the Axum Router

    // 3. Act: Send a request to the router.
    let response = app
        .oneshot(Request::builder()
            .method("POST")
            .uri("/users/10/promote")
            .body(Body::empty())
            .unwrap())
        .await
        .unwrap();

    // 4. Assert: Check the response status code.
    assert_eq!(response.status(), StatusCode::OK);
}
```
}
```
```rust
// tests/user_management_test.rs
use std::sync::Arc;
use crate::{app::user_management::UserManagement, services::user_api::MockUserApi, types::user::{User, UserId}};

#[tokio::test]
async fn test_promote_user_success() {
    // 1. Arrange
    let mut mock_api = MockUserApi::new();
    let user_id = 10;

    mock_api.expect_fetch_user().returning(move |_| Ok(User { id: UserId(user_id), name: "test".to_string() }));
    mock_api.expect_set_admin_role().returning(|_| Ok(()));

    let user_management = UserManagement::new(Arc::new(mock_api));

    // 2. Act
    let result = user_management.promote_user(user_id).await;

    // 3. Assert
    assert!(result.is_ok());
}
```

### 3.3 Observability ในระดับ Production

- **Middleware (tower-http):** ใช้ `tower-http` เพื่อเพิ่ม Middleware ที่จำเป็น เช่น `TraceLayer` สำหรับ Request Logging, `CompressionLayer`, และ `CorsLayer`
- **Metrics Endpoint:** สร้าง Endpoint `/metrics` เพื่อให้ Prometheus สามารถ Scrape ข้อมูลได้

**ตัวอย่างการเพิ่ม Middleware และ Metrics Endpoint ใน `main.rs`:**
```rust
// (In main.rs)
use axum::{routing::get, http::Request};
use tower_http::trace::TraceLayer;
use metrics_exporter_prometheus::{PrometheusBuilder, PrometheusHandle};

// ... (in main)
let prometheus_handle = PrometheusBuilder::new().install_recorder().unwrap();

let app = Router::new()
    .route("/users/:id/promote", post(promote_user_handler))
    .route("/metrics", get(move || async move { prometheus_handle.render() }))
    .layer(TraceLayer::new_for_http())
    .with_state(app_state);
```

การมี Logging ที่ดีเป็นสิ่งจำเป็นอย่างยิ่งในระบบ Production เราจะใช้ `tracing` เป็นแกนหลัก และขยายความสามารถด้วยเครื่องมืออื่นๆ

- **Structured Logging (JSON):** บันทึก Log เป็น JSON format เพื่อให้ง่ายต่อการประมวลผลโดยเครื่องมืออย่าง Datadog, Splunk, หรือ ELK Stack
- **Spans:** ใช้ `#[tracing::instrument]` เพื่อสร้าง `span` ซึ่งจะช่วยติดตามการทำงานของฟังก์ชัน พร้อมทั้งแนบ context (เช่น `request_id`) ไปกับ log ทั้งหมดที่เกิดขึ้นภายใน span นั้น
- **Metrics Exporter:** เพิ่มการส่งออก Metrics ไปยังระบบ Monitoring เช่น Prometheus เพื่อติดตามสุขภาพของแอปพลิเคชัน (เช่น request latency, error rate)
- **Log Layers:** `tracing-subscriber` รองรับการเพิ่ม `Layer` หลายๆ ชั้น ทำให้เราสามารถส่ง Log ไปยังหลายปลายทางได้พร้อมกัน เช่น แสดงผลใน Console สำหรับ Development และส่งเป็น JSON ไปยัง Collector ใน Production

**ตัวอย่างการตั้งค่า `tracing` สำหรับ Production:**
```rust
// (In main.rs)
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt, EnvFilter, fmt};

pub fn setup_observability() {
    let env_filter = EnvFilter::try_from_default_env()
        .unwrap_or_else(|_| EnvFilter::new("info"));

    let formatting_layer = fmt::layer().json()
        .with_current_span(true)
        .with_span_list(true);

    // Add more layers here, e.g., for Prometheus metrics

    tracing_subscriber::registry()
        .with(env_filter)
        .with(formatting_layer)
        // .with(prometheus_layer)
        .init();
}
```

### 3.4 การสร้างและจัดการ Application (Composition Root & API Layer)

`main.rs` คือ **Composition Root** ซึ่งเป็นจุดที่ทุกอย่างถูกประกอบเข้าด้วยกัน และเป็นที่เดียวที่แอปพลิเคชันของเรา "รู้" เกี่ยวกับ Implementation ที่เป็นรูปธรรม

**ขั้นตอนการทำงานใน `main.rs`:**
1.  **โหลด Config:** โหลด `AppConfig` จากไฟล์และ Environment Variables
2.  **ตั้งค่า Observability:** ติดตั้ง `tracing` สำหรับ Structured Logging
3.  **สร้าง Dependencies:** สร้าง Instance ของ Concrete Types จาก `services` (เช่น `LiveUserApi`)
4.  **Dependency Injection:** ส่ง Dependencies ทั้งหมดเข้าไปใน `app` Layer โดยใช้ `Arc<dyn Trait>`
5.  **สร้าง API Layer:** สร้าง Router ของ `axum`, กำหนด `AppState`, และผูก Handler เข้ากับ Route ต่างๆ
6.  **รัน Server:** เริ่ม Web Server พร้อมจัดการ `Graceful Shutdown`

**ตัวอย่าง `main.rs` ที่สมบูรณ์ (พร้อม Factory Function):**
```rust
// src/main.rs
use std::sync::Arc;
use axum::{routing::post, Router, extract::{State, Path}, response::Json, http::StatusCode};
use crate::{config::AppConfig, services::user_api::{LiveUserApi, UserApi}, app::user_management::UserManagement, error::AppError};

// AppState holds all shared state for the application.
#[derive(Clone)]
pub struct AppState {
    user_management: Arc<UserManagement>,
}

// Factory function to build the application state from configuration.
fn build_app_state(config: AppConfig) -> AppState {
    // 3. Create Concrete Dependencies
    let user_api: Arc<dyn UserApi> = Arc::new(LiveUserApi::new(config.api.clone()));

    // 4. Dependency Injection
    let user_management = Arc::new(UserManagement::new(user_api));

    AppState { user_management }
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    // 1. Load Config & 2. Setup Observability
    let config = AppConfig::load()?;
    setup_observability();

    // 5. Create API Layer using the factory
    let app_state = build_app_state(config);
    let app = Router::new()
        .route("/users/:id/promote", post(promote_user_handler))
        .with_state(app_state);

    // 6. Run Server
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await?;
    tracing::info!("listening on {}", listener.local_addr()?);
    axum::serve(listener, app)
        .with_graceful_shutdown(shutdown_signal()) // (Implementation is in the original doc)
        .await?;

    Ok(())
}

// API Handler remains the same...
async fn promote_user_handler(
    State(state): State<AppState>,
    Path(user_id): Path<u64>,
) -> Result<Json<()>, AppError> {
    state.user_management.promote_user(user_id).await?;
    Ok(Json(()))
}

// Axum Error Handling with detailed mapping
impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        // Log the full error for debugging
        tracing::error!(error = ?self, "API Error Response");

        let (status, message) = match self {
            AppError::Validation(msg) => (StatusCode::BAD_REQUEST, msg),
            AppError::ExternalApiError(_) => (StatusCode::SERVICE_UNAVAILABLE, "External service is unavailable".to_string()),
            AppError::Config(_) => (StatusCode::INTERNAL_SERVER_ERROR, "Internal configuration error".to_string()),
            // Add more specific mappings here
        };

        (status, Json(serde_json::json!({ "error": message }))).into_response()
    }
}
```

## 4. แนวปฏิบัติที่ดีที่สุดและข้อควรพิจารณา (Best Practices & Considerations)

### 4.1 แนวปฏิบัติหลัก

- **Embrace Iterators:** ใช้ `iter()`, `map()`, `filter()`, `fold()` ให้เป็นประโยชน์แทนการใช้ `for` loop แบบดั้งเดิม เพื่อโค้ดที่สั้นและสื่อความหมายได้ดีกว่า
- **Prefer `Result` and `Option`:** หลีกเลี่ยง `.unwrap()` หรือ `.expect()` ใน Production Code ใช้ `?` Operator เพื่อ Propagate Errors และใช้ Pattern Matching เพื่อจัดการ `Option` และ `Result` อย่างปลอดภัย
- **Use Traits for Abstraction:** ออกแบบ `services` โดยใช้ Traits เพื่อทำ Dependency Injection ทำให้สามารถสลับ Implementation จริงกับ Mock Object ในการทดสอบได้
- **Command/Query Responsibility Segregation (CQRS):** แยกฟังก์ชันที่เปลี่ยนแปลงสถานะ (Commands) ออกจากฟังก์ชันที่อ่านข้อมูล (Queries) อย่างชัดเจน เพื่อให้ Queries เป็น Pure Function ที่ทดสอบง่าย และจำกัดขอบเขตของ Side Effects ให้อยู่ใน Commands
- **Property-Based Testing:** ใช้ `proptest` หรือ `quickcheck` เพื่อทดสอบคุณสมบัติของฟังก์ชันบริสุทธิ์ของคุณกับข้อมูล Input ที่หลากหลายโดยอัตโนมัติ

### 4.2 เมื่อไหร่ที่ไม่ควรยึดติดกับ FP (Be Pragmatic)

สถาปัตยกรรมนี้ไม่ใช่ Silver Bullet วิศวกรที่ดีต้องรู้ว่าเมื่อไหร่ควรใช้ และเมื่อไหร่ควรปรับเปลี่ยน การยึดติดกับ FP อย่างเคร่งครัดในบางสถานการณ์อาจทำให้โค้ดซับซ้อนหรือทำงานช้าโดยไม่จำเป็น

| กรณีใช้งาน              | คำแนะนำ                                                              | เหตุผล                                                                |
| ----------------------- | ------------------------------------------------------------------- | --------------------------------------------------------------------- |
| **Hot Loops ที่เน้น Performance** | ใช้ Mutable Variables และ `for` loop แบบปกติ                      | หลีกเลี่ยง Overhead จาก Abstractions (เช่น Iterators, Closures)      |
| **Parsers หรือ State Machines ที่ซับซ้อน** | การใช้ Iterator ร่วมกับ Mutable State อาจเข้าใจง่ายกว่า             | การจำลอง State ที่ซับซ้อนด้วย Pure Functions อาจทำให้โค้ดวกวน         |
| **Caching หรือ Memoization** | ใช้ `Arc<Mutex<T>>` หรือ `once_cell` สำหรับ Interior Mutability | Cache เป็น Side Effect โดยธรรมชาติ ควรห่อหุ้มมันไว้อย่างชัดเจน         |
| **การเชื่อมต่อกับ C Libraries (FFI)** | โค้ดส่วนนี้มักจะเป็น Unsafe และ Imperative โดยธรรมชาติ            | ให้สร้าง Safe Wrapper ที่เป็น Idiomatic Rust หุ้มส่วน Unsafe เอาไว้ |

**กฎทอง:** **Benchmark เสมอ** อย่าเพิ่งทึกทักว่า FP ช้าหรือ Imperative เร็ว ให้วัดผลกระทบของ Design ที่เลือก แล้วตัดสินใจจากข้อมูลจริง

## 6. ไลบรารีและเครื่องมือที่แนะนำ (Recommended Crates & Tooling)

- **`sqlx`**: Async SQL toolkit พร้อม Compile-time checked queries
- **`tower-http`**: ชุด Middleware ที่มีประโยชน์สำหรับ `axum` (CORS, Compression, Request ID)
- **`tracing-opentelemetry`**: สำหรับ Distributed Tracing
- **`metrics` & `metrics-exporter-prometheus`**: สำหรับส่งออก Metrics ไปยัง Prometheus
- **`once_cell` / `lazy_static`**: สำหรับจัดการ Immutable Global State (เช่น Config, Clients)
- **`dashmap` / `parking_lot`**: สำหรับ Caching และ Locking ที่มีประสิทธิภาพสูง
