---
auto_execution_mode: 3
---

# แนวทางการเขียนโปรแกรมเชิงฟังก์ชันด้วย Rust (Functional Rust Guide)

เอกสารนี้เป็นแนวทางสำหรับการพัฒนาโปรเจกต์ด้วยภาษา Rust โดยใช้กระบวนทัศน์การเขียนโปรแกรมเชิงฟังก์ชัน (Functional Programming) เพื่อสร้างโค้ดที่เข้าใจง่าย, บำรุงรักษาได้, และมีโอกาสเกิดข้อผิดพลาดน้อย

## 1. Core Concepts (แนวคิดหลัก)

การเขียนโปรแกรมเชิงฟังก์ชันใน Rust ตั้งอยู่บนหลักการสำคัญหลายประการ:

- **Immutability (ความไม่เปลี่ยนรูป):** ข้อมูลควรเป็นแบบอ่านอย่างเดียว (immutable) โดยปริยาย การเปลี่ยนแปลงสถานะจะทำผ่านการสร้างข้อมูลชุดใหม่แทนการแก้ไขของเดิม ซึ่งช่วยลด side effects และทำให้โค้ดคาดเดาได้ง่ายขึ้น
- **Purity (ฟังก์ชันบริสุทธิ์):** ฟังก์ชันควรเป็นฟังก์ชันบริสุทธิ์ (Pure Function) คือผลลัพธ์ขึ้นอยู่กับอาร์กิวเมนต์ที่ส่งเข้ามาเท่านั้น และไม่มีการเปลี่ยนแปลงสถานะภายนอก (side effects) เช่น การแก้ไขตัวแปร global, การเขียนไฟล์, หรือการเรียก API
- **Function Composition (การประกอบฟังก์ชัน):** สร้างฟังก์ชันที่ซับซ้อนขึ้นโดยการรวมฟังก์ชันเล็กๆ เข้าด้วยกัน ทำให้โค้ดเป็นโมดูลและนำกลับมาใช้ใหม่ได้ง่าย
- **Higher-Order Functions (ฟังก์ชันลำดับสูง):** Rust รองรับฟังก์ชันที่รับฟังก์ชันอื่นเป็นอาร์กิวเมนต์ หรือคืนค่าเป็นฟังก์ชันได้ เช่น `map`, `filter`, `fold` ซึ่งเป็นเครื่องมือที่ทรงพลังในการจัดการข้อมูล
- **Ownership & Borrowing:** ระบบ Ownership ของ Rust ช่วยให้จัดการหน่วยความจำได้อย่างปลอดภัยโดยไม่ต้องมี Garbage Collector และบังคับให้เราจัดการกับการเข้าถึงข้อมูลอย่างมีวินัย ซึ่งสอดคล้องกับหลักการของ FP

## 2. Project Structure (โครงสร้างโปรเจกต์)

โครงสร้างโปรเจกต์ที่แนะนำถูกออกแบบมาเพื่อแยกส่วนของโค้ดตามหน้าที่อย่างชัดเจน:

```plaintext
src/
├── app/           # Application Layer / Use Cases (Orchestrates business flows)
├── components/    # Pure Business Logic (ฟังก์ชันบริสุทธิ์สำหรับ Business Logic)
├── services/      # Side Effects (จัดการ I/O, API calls, Database)
├── adapters/      # 3rd-party Wrappers (ห่อหุ้มไลบรารีภายนอก)
├── config/        # Configuration & Type Bridge (รวมศูนย์การตั้งค่าและ Type)
├── types/         # Data Structures (Structs, Enums, Traits)
├── utils/         # Generic Pure Functions (ฟังก์ชันบริสุทธิ์ทั่วไป)
├── constants/     # Compile-time Constants (ค่าคงที่)
├── error/         # Custom Error Types (ประเภทข้อผิดพลาด)
├── lib.rs         # Library Entry Point (จุดเริ่มต้นของไลบรารี)
└── main.rs        # Application Entry Point (จุดเริ่มต้นของโปรแกรม)
tests/             # Integration tests (การทดสอบแบบบูรณาการ)
benches/           # Benchmarks (การทดสอบประสิทธิภาพ)
examples/          # Example usage (ตัวอย่างการใช้งาน)
```

### Data Flow & Dependencies

เพื่อให้โค้ดเป็นระเบียบและง่ายต่อการติดตาม การ import dependency ควรเป็นไปในทิศทางเดียว:

```plaintext
app         <── components, services, config, types, error
components  <── types, constants, error (domain-specific)
services    <── config, types, error (application)
adapters    <── (External crates only)
utils       <── (No internal dependencies)
error       <── types
```

## 3. Folder Rules & Examples (กฎและตัวอย่าง)

### `types/`
- **หน้าที่:** กำหนดโครงสร้างข้อมูลหลักของแอปพลิเคชัน เช่น `Structs` และ `Enums`
- **Do:**
    - ใช้ `#[derive(Debug, Clone, PartialEq, serde::Serialize, serde::Deserialize)]` ตามความเหมาะสม
    - ใช้ Newtype Pattern เพื่อสร้าง Type-safe Abstractions
- **Don't:**
    - ใส่ business logic ที่ซับซ้อน (ควรอยู่ใน `components`)

```rust
// src/types/user.rs
#[derive(Debug, Clone, PartialEq)]
pub struct UserId(pub u64);

#[derive(Debug, Clone, PartialEq)]
pub struct User {
    pub id: UserId,
    pub name: String,
    pub age: u32,
}
```

### `constants/`
- **หน้าที่:** เก็บค่าคงที่ที่ใช้ในโปรแกรม
- **Do:**
    - ใช้ `const` หรือ `static`
    - ตั้งชื่อแบบ `UPPER_SNAKE_CASE`

```rust
// src/constants/api.rs
pub const API_BASE_URL: &str = "https://api.example.com";
pub const MAX_RETRIES: u32 = 3;
```

### `error/`
- **หน้าที่:** กำหนดประเภทของข้อผิดพลาด (Error Types) สำหรับแอปพลิเคชัน
- **Do:**
    - ใช้ `thiserror` เพื่อสร้าง custom error enums ที่สวยงาม
    - สร้าง `AppResult<T>` type alias เพื่อความสะดวก

```rust
// src/error.rs
use thiserror::Error;

#[derive(Error, Debug)]
pub enum AppError {
    #[error("Configuration Error: {0}")]
    Config(String),

    #[error("External API Error: {0}")]
    ApiError(#[from] reqwest::Error),

    #[error("I/O Error")]
    Io(#[from] std::io::Error),
}

pub type AppResult<T> = Result<T, AppError>;
```

### `config/` (Production Grade)
- **หน้าที่:** จัดการการตั้งค่าของแอปพลิเคชันอย่างยืดหยุ่น โดยรวมค่าจากหลายแหล่ง (ไฟล์, environment variables) 
- **Do:**
    - ใช้ `figment` และ `serde` เพื่อสร้าง typed configuration ที่แข็งแกร่ง
    - แยกการตั้งค่าตามสภาพแวดล้อม (e.g., `development`, `production`)
    - กำหนดค่า default ที่เหมาะสม
- **Don't:**
    - Hardcode ค่า configuration ในโค้ด

```rust
// src/config.rs
use figment::{
    Figment,
    providers::{Format, Toml, Env},
};
use serde::{Deserialize, Serialize};
use crate::error::{AppError, AppResult};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ApiConfig {
    pub base_url: String,
    pub timeout_secs: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AppConfig {
    pub admin_id: u64,
    pub api: ApiConfig,
}

impl AppConfig {
    pub fn load() -> AppResult<Self> {
        Figment::new()
            // Load default from `Config.toml`
            .merge(Toml::file("Config.toml"))
            // Override with environment-specific file, e.g., `Prod.toml`
            .merge(Toml::file(Env::var_or("APP_ENV", "dev").as_str().to_lowercase() + ".toml"))
            // Override with environment variables, e.g., `APP_ADMIN_ID=100`
            .merge(Env::prefixed("APP_"))
            .extract()
            .map_err(|e| AppError::Config(e.to_string()))
    }
}
```

**ตัวอย่าง `Config.toml`:**
```toml
admin_id = 1

[api]
base_url = "http://localhost:8080"
timeout_secs = 30
```

**ตัวอย่าง `Prod.toml`:**
```toml
[api]
base_url = "https://api.production.com"
```

### `utils/`
- **หน้าที่:** เก็บฟังก์ชันบริสุทธิ์ที่ไม่มี side effects และสามารถใช้ได้ทั่วไป
- **Do:**
    - เขียนฟังก์ชันที่รับข้อมูลและคืนค่าข้อมูลใหม่ (input -> output)
    - ใช้ Iterators และ Higher-Order Functions
- **Don't:**
    - ทำ I/O, แก้ไข state ภายนอก, หรือเรียกใช้ `unwrap()`

```rust
// src/utils/formatters.rs
pub fn to_uppercase_names<'a>(
    names: impl Iterator<Item = &'a str>,
) -> impl Iterator<Item = String> + 'a {
    names.map(|name| name.to_uppercase())
}
```

### `components/`
- **หน้าที่:** เป็นหัวใจของ Business Logic ที่เป็นฟังก์ชันบริสุทธิ์ 100%
- **Do:**
    - รับ `Types` เป็น input และคืนค่าเป็น `Result` ที่มี Error เป็น Domain-specific
    - ไม่มี dependency กับ `AppError` หรือ `config` โดยตรง
- **Don't:**
    - มี Side effects หรือผูกกับ Application-level concerns

```rust
// src/components/errors.rs
#[derive(Debug, Clone, PartialEq)]
pub enum UserValidationError {
    EmptyName,
}

// src/components/user_logic.rs
use crate::{types::user::User, components::errors::UserValidationError};

pub fn validate_user(user: &User) -> Result<(), UserValidationError> {
    if user.name.is_empty() {
        Err(UserValidationError::EmptyName)
    } else {
        Ok(())
    }
}

pub fn is_admin(user: &User, admin_id: &crate::types::user::UserId) -> bool {
    user.id == *admin_id
}
```

### `services/`
- **หน้าที่:** จัดการกับ Side Effects ทั้งหมด เช่น การเรียก API, การติดต่อฐานข้อมูล, การเขียนไฟล์
- **Do:**
    - ใช้ Trait-based design เพื่อให้ง่ายต่อการ test (Dependency Injection)
    - คืนค่าเป็น `AppResult<T>` เพื่อจัดการข้อผิดพลาด
- **Don't:**
    - ใส่ Business Logic (ควรอยู่ใน `components`)

```rust
// src/services/user_api.rs
use crate::{types::user::User, error::AppResult, config::AppConfig};

#[async_trait::async_trait]
pub trait UserApi {
    async fn fetch_user(&self, id: u64) -> AppResult<User>;
}

pub struct LiveUserApi { 
    client: reqwest::Client,
    config: AppConfig,
}

#[async_trait::async_trait]
impl UserApi for LiveUserApi {
    async fn fetch_user(&self, id: u64) -> AppResult<User> {
        let url = format!("{}/users/{}", self.config.api_url, id);
        let user = self.client.get(&url).send().await?.json::<User>().await?;
        Ok(user)
    }
}
```

## 4. Tooling & Configuration (เครื่องมือและการตั้งค่า)

### `cargo.toml`

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
serde_json = "1.0"

# Async Runtime & HTTP Client
tokio = { version = "1.0", features = ["full"] }
reqwest = { version = "0.11", features = ["json"] }
async-trait = "0.1"

# Logging
tracing = "0.1"
tracing-subscriber = "0.3"

# Functional Programming Helpers
itertools = "0.12"

[dev-dependencies]
# Testing
proptest = "1.4"
mockall = "0.12"

# Tooling
cargo-watch = "8.5"
```

### `package.json` (Optional, with TurboRepo)

สำหรับ Monorepo ที่จัดการด้วย `turborepo` และ `bun`:

```json
{
  "name": "",           // @ai ชื่อให้ตรงกับ folder
  "type" : "module",
  "scripts": {
    "prepare": "lefthook install",
    "dev": "cargo watch -x run",
    "format": "cargo fmt",
    "lint": "cargo check && cargo clippy --all-targets --all-features",
    "test": "cargo nextest run",
    "verify": "bun format && bun lint && bun test && cargo audit && run build"
  }
}
```

## 5. Testing Strategy (กลยุทธ์การทดสอบ)

สถาปัตยกรรมนี้ถูกออกแบบมาให้ทดสอบได้ง่ายในทุกระดับ:

- **Unit Tests:** สำหรับ `components` และ `utils` ที่เป็น pure functions สามารถทดสอบได้โดยตรงด้วย input และ output ที่คาดหวัง
- **Integration Tests:** ทดสอบ `app` layer โดย mock `services` เพื่อจำลอง side effects

### Integration Testing the `app` Layer

เราจะใช้ `mockall` เพื่อสร้าง mock implementation ของ `UserApi` trait ทำให้เราสามารถทดสอบ `UserManagement` use case ได้โดยไม่ต้องเชื่อมต่อกับ API จริง

```rust
// tests/user_management_test.rs
use std::sync::Arc;
use crate::{
    app::user_management::UserManagement,
    services::user_api::MockUserApi, // Generated by mockall
    types::user::{User, UserId},
    error::AppError,
};

#[tokio::test]
async fn test_promote_user_success() {
    // 1. Arrange
    let mut mock_api = MockUserApi::new();
    let user_id = 10;
    let admin_id = UserId(1);
    let user = User { id: UserId(user_id), name: "test".to_string(), age: 30 };

    // Expect `fetch_user` to be called once and return a mock user
    mock_api.expect_fetch_user()
        .with(predicate::eq(user_id))
        .times(1)
        .returning(move |_| Ok(user.clone()));

    // Expect `set_admin_role` to be called once and succeed
    mock_api.expect_set_admin_role()
        .with(predicate::eq(UserId(user_id)))
        .times(1)
        .returning(|_| Ok(()));

    let user_management = UserManagement::new(Arc::new(mock_api), admin_id);

    // 2. Act
    let result = user_management.promote_user(user_id).await;

    // 3. Assert
    assert!(result.is_ok());
}

#[tokio::test]
async fn test_promote_user_already_admin() {
    // 1. Arrange
    let mut mock_api = MockUserApi::new();
    let user_id = 1;
    let admin_id = UserId(1);
    let user = User { id: UserId(user_id), name: "admin".to_string(), age: 40 };

    mock_api.expect_fetch_user()
        .returning(move |_| Ok(user.clone()));

    // `set_admin_role` should NOT be called
    mock_api.expect_set_admin_role().times(0);

    let user_management = UserManagement::new(Arc::new(mock_api), admin_id);

    // 2. Act
    let result = user_management.promote_user(user_id).await;

    // 3. Assert
    assert!(matches!(result, Err(AppError::Validation(_))));
}
```

## 6. Observability (Logging & Tracing)

ในระบบ Production การมี Logging ที่ดีเป็นสิ่งจำเป็นอย่างยิ่ง เราจะใช้ `tracing` สำหรับ instrumenting code และ `tracing-subscriber` สำหรับการเก็บและแสดงผล logs

- **Structured Logging:** บันทึก Log เป็น JSON format เพื่อให้ง่ายต่อการประมวลผลโดยเครื่องมืออย่าง Datadog, Splunk, หรือ ELK Stack
- **Spans:** ใช้ `#[tracing::instrument]` เพื่อสร้าง `span` ซึ่งจะช่วยติดตามการทำงานของฟังก์ชัน พร้อมทั้งแนบ context (เช่น request_id) ไปกับ log ทั้งหมดที่เกิดขึ้นภายใน span นั้น

```rust
// src/main.rs (setup part)
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt, EnvFilter, fmt};

pub fn setup_tracing() {
    let env_filter = EnvFilter::try_from_default_env()
        .unwrap_or_else(|_| EnvFilter::new("info"));

    let formatting_layer = fmt::layer().json()
        .with_current_span(true)
        .with_span_list(true);

    tracing_subscriber::registry()
        .with(env_filter)
        .with(formatting_layer)
        .init();
}

// Example usage in `app` layer
// src/app/user_management.rs
use tracing::info;

#[tracing::instrument(
    skip(self),
    fields(
        user_id = %user_id,
    )
)]
pub async fn promote_user(&self, user_id: u64) -> AppResult<User> {
    info!("Attempting to promote user");
    // ... function body
}
```

เมื่อเรียกใช้ `promote_user` จะได้ Log ที่มีโครงสร้างและ context ดังนี้:

```json
{"timestamp":"...","level":"INFO","fields":{"message":"Attempting to promote user","user_id":10},"target":"...","span":{"name":"promote_user","user_id":10,"level":"INFO"},"spans":[...]}
```

## 7. Application Startup & State Management (`main.rs`)

`main.rs` คือจุดที่ทุกอย่างถูกประกอบเข้าด้วยกัน (Composition Root) ที่นี่คือที่ที่เราจะ:

1.  โหลด `AppConfig`
2.  ตั้งค่า `tracing`
3.  สร้าง instances ของ `services` (เช่น `LiveUserApi`)
4.  สร้าง instance ของ `app` layer (เช่น `UserManagement`)
5.  ส่งต่อ dependencies ทั้งหมดโดยใช้ `Arc` เพื่อจัดการ shared ownership

```rust
// src/main.rs
use std::sync::Arc;
use crate::{
    config::AppConfig,
    services::user_api::LiveUserApi, // Assuming this is the concrete implementation
    app::user_management::UserManagement,
    types::user::UserId,
};

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    // 1. Load configuration
    let config = AppConfig::load()?;

    // 2. Setup tracing/logging
    setup_tracing();

    // 3. Initialize services (dependencies)
    let user_api = Arc::new(LiveUserApi::new(config.api.clone()));

    // 4. Initialize the application layer
    let user_management = UserManagement::new(
        user_api.clone(),
        UserId(config.admin_id),
    );

    // 5. Run the main application logic
    // (In a real app, this would be starting a web server, a CLI, etc.)
    println!("Application started successfully!");
    let user_to_promote = 123;
    match user_management.promote_user(user_to_promote).await {
        Ok(user) => println!("Successfully promoted user: {:?}", user),
        Err(e) => eprintln!("Failed to promote user: {}", e),
    }

    Ok(())
}
```

## 8. Graceful Shutdown

สำหรับ long-running services การจัดการ shutdown signal เป็นสิ่งสำคัญเพื่อให้แอปพลิเคชันมีโอกาสทำงานที่ค้างอยู่ให้เสร็จสิ้นก่อนปิดตัวลง เช่น ปิด database connections หรือส่ง logs ที่ค้างอยู่

เราสามารถใช้ `tokio::signal` เพื่อดักจับ signal เช่น `Ctrl+C`

```rust
// In main.rs, inside the `main` function

// This part would replace the simple `println!` and `promote_user` call
// For example, if we were running a web server:
/*
let app = create_axum_app(user_management);
let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await?;

tracing::info!("listening on {}", listener.local_addr()?);
axum::serve(listener, app)
    .with_graceful_shutdown(shutdown_signal())
    .await?;
*/

async fn shutdown_signal() {
    let ctrl_c = async {
        tokio::signal::ctrl_c()
            .await
            .expect("failed to install Ctrl+C handler");
    };

    #[cfg(unix)]
    let terminate = async {
        tokio::signal::unix::signal(tokio::signal::unix::SignalKind::terminate())
            .expect("failed to install signal handler")
            .recv()
            .await;
    };

    #[cfg(not(unix))]
    let terminate = std::future::pending::<()>();

    tokio::select! {
        _ = ctrl_c => {},
        _ = terminate => {},
    }

    tracing::warn!("Signal received, starting graceful shutdown");
}

// The example above assumes a web server context, which will be detailed
// in the next section.
```

## 9. API Layer Integration with Axum

สุดท้าย เราจะนำทุกอย่างมารวมกันเพื่อสร้าง Web API Server ด้วย `axum`

### 1. Application State
เราจะสร้าง `AppState` struct เพื่อเก็บ shared state ทั้งหมดที่ handler ของเราต้องการเข้าถึง เช่น `UserManagement` instance

```rust
// src/api/state.rs
use std::sync::Arc;
use crate::app::user_management::UserManagement;

#[derive(Clone)]
pub struct AppState {
    pub user_management: Arc<UserManagement>,
}
```

### 2. API Handlers
Handlers จะรับ `State` และทำการเรียก `app` layer เพื่อทำงานตาม business logic

```rust
// src/api/handlers.rs
use axum::{
    extract::{State, Path},
    response::Json,
    http::StatusCode,
};
use crate::api::state::AppState;
use crate::error::AppError;

// Custom result type for API handlers
pub type ApiResult<T> = Result<T, AppError>;

pub async fn promote_user_handler(
    State(state): State<AppState>,
    Path(user_id): Path<u64>,
) -> ApiResult<Json<()>> {
    state.user_management.promote_user(user_id).await?;
    Ok(Json(()))
}

// Axum error handling: Convert AppError to an HTTP response
impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        let (status, error_message) = match self {
            AppError::Validation(msg) => (StatusCode::BAD_REQUEST, msg),
            AppError::ApiError(_) => (StatusCode::INTERNAL_SERVER_ERROR, "External API error".to_string()),
            _ => (StatusCode::INTERNAL_SERVER_ERROR, "Internal server error".to_string()),
        };

        let body = Json(json!({ "error": error_message }));
        (status, body).into_response()
    }
}
```

### 3. Router & Main
ใน `main.rs` เราจะสร้าง router, ใส่ state, และเริ่ม server

```rust
// src/main.rs (final version)
use axum::{routing::post, Router};
use std::sync::Arc;
// ... other imports

async fn main() -> anyhow::Result<()> {
    // ... (config loading, tracing setup, service init)
    let user_management = Arc::new(UserManagement::new(user_api, UserId(config.admin_id)));

    let app_state = AppState { user_management };

    let app = Router::new()
        .route("/users/:id/promote", post(promote_user_handler))
        .with_state(app_state);

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await?;
    tracing::info!("listening on {}", listener.local_addr()?);

    axum::serve(listener, app)
        .with_graceful_shutdown(shutdown_signal())
        .await?;

    Ok(())
}
```

## 10. Best Practices (แนวปฏิบัติที่ดีที่สุด)

- **Embrace Iterators:** ใช้ `iter()`, `map()`, `filter()`, `fold()` ให้เป็นประโยชน์แทนการใช้ `for` loop แบบดั้งเดิม เพื่อโค้ดที่สั้นและสื่อความหมายได้ดีกว่า
- **Prefer `Result` and `Option`:** หลีกเลี่ยงการใช้ `.unwrap()` หรือ `.expect()` ใน production code ใช้ `?` operator เพื่อ propagate errors และใช้ pattern matching เพื่อ handle `Option` และ `Result` อย่างปลอดภัย
- **Use Traits for Abstraction:** ออกแบบ `services` โดยใช้ traits เพื่อให้สามารถสลับ implementation จริงกับ mock object ในการทดสอบได้ (Dependency Injection)
- **Property-Based Testing:** ใช้ `proptest` หรือ `quickcheck` เพื่อทดสอบคุณสมบัติของฟังก์ชันบริสุทธิ์ของคุณกับข้อมูล input ที่หลากหลายโดยอัตโนมัติ

```rust
// Example: Property-based test for a pure function
use proptest::prelude::*;

fn reverse<T: Clone>(items: &[T]) -> Vec<T> {
    let mut reversed = items.to_vec();
    reversed.reverse();
    reversed
}

proptest! {
    #[test]
    fn test_double_reversal_returns_original(s in "\\PC*") {
        let vec = s.chars().collect::<Vec<_>>();
        prop_assert_eq!(reverse(&reverse(&vec)), vec);
    }
}
```
