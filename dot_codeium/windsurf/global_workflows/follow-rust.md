---
description: Guidelines for Functional Rust project structure and best practices
auto_execution_mode: 3
---

# Functional Rust Project Structure

follow ทำตามกฏเหล่านี้อย่างเคร่งครัด

## Project Structure

```
src/
├── components/    # Pure (Zero Side Effects)
├── services/      # Side Effects (Result/Option)
├── config/        # Config & Type Bridge
├── types/         # Structs, Enums, Traits
├── utils/         # Pure Functions
├── lib_wrapper/   # 3rd-party Wrappers
├── constants/     # Compile-time Constants
├── error/         # Error Types
├── lib.rs         # Library Entry
└── main.rs        # App Entry
```

## Core Principles
- **Ownership**: Zero-cost abstraction, no GC
- **Data Flow**: `types` → `constants` → `config` → `components`
- **Pure Functions**: `utils/` is side-effect free
- **Single Entry**: Use `config/` to access types
- **Type Safety**: Compile-time guarantees

### Import Rules
```
components  ← config ← types + constants
services    ← config + types + error
utils       ← (No dependencies)
lib_wrapper ← (External crates)
error       ← types
```

## Folder Rules

### components/
- **Do** => import `config/`, pure functions, iterators, `&` refs
- **Don't** => `.unwrap()`, side effects, mut state
- **Example**
```rust
pub fn render_button(text: &str, cfg: &DisplayConfig) -> String {
    format!("[{}] {}", cfg.border_style, text)
}
```

### types/
- **Do** => `#[derive(Debug, Clone)]`, newtype pattern
- **Don't** => ใช้ตรงใน components (ผ่าน config/)
- **Example**
```rust
#[derive(Debug, Clone, PartialEq)]
pub struct Color(String);
impl Color {
    pub fn new(v: impl Into<String>) -> Result<Self, String> {
        /* validation */
    }
}
```

### utils/
- **Do** => pure functions, iterators, `&` refs
- **Don't** => I/O, `mut` params, global state
- **Example**
```rust
pub fn process_users<'a>(users: impl Iterator<Item = &'a User> + 'a) 
    -> impl Iterator<Item = User> + 'a {
    users.filter(|u| u.age >= 18).map(|u| User { name: u.name.to_uppercase(), ..*u })
}
```

### config/
- **Do** => import `types/` + `constants/`, `Default` trait
- **Don't** => business logic, mutable config
- **Example**
```rust
#[derive(Debug, Clone)]
pub struct DisplayConfig { pub color: Color, pub width: u32 }
impl Default for DisplayConfig {
    fn default() -> Self { Self { color: Color::new("blue").unwrap(), width: 80 } }
}
```

### constants/
- **Do** => `const`/`static`, `UPPER_SNAKE_CASE`
- **Example**
```rust
pub const BORDER_STYLES: &[&str] = &["─", "═", "━"];
pub const DEFAULT_WIDTH: u32 = 80;
```

### services/
- **Do** => `Result<T, E>`, error propagation `?`, trait-based
- **Don't** => `.unwrap()` in production
- **Example**
```rust
pub trait Logger { fn log(&self, msg: &str) -> Result<(), AppError>; }
pub struct ConsoleLogger;
impl Logger for ConsoleLogger {
    fn log(&self, msg: &str) -> Result<(), AppError> { println!("{}", msg); Ok(()) }
}
```

### error/
- **Do** => `thiserror` for errors, `anyhow` for apps
- **Example**
```rust
#[derive(Error, Debug)]
pub enum AppError {
    #[error("IO: {0}")] IoError(#[from] std::io::Error),
    #[error("Parse: {0}")] ParseError(String),
}
pub type AppResult<T> = Result<T, AppError>;
```

### lib_wrapper/
- **Do** => type-safe wrappers, re-export เฉพาะจำเป็น
- **Don't** => side effects (ใช้ services/)

### Root Files

#### Cargo.toml
```toml
[package]
name = "functional-rust-cli"
version = "0.1.0"
edition = "2021"

[dependencies]
thiserror = "1.0"
anyhow = "1.0"
itertools = "0.12"
clap = { version = "4.4", features = ["derive"] }
serde = { version = "1.0", features = ["derive"] }

[dev-dependencies]
proptest = "1.4"
```

#### main.rs
```rust
use functional_rust_cli::{run_app, AppError};
fn main() -> Result<(), AppError> { run_app() }
```

#### lib.rs
```rust
pub mod components; pub mod config; pub mod error; pub mod services;
pub use error::{AppError, AppResult};
pub fn run_app() -> Result<(), AppError> { /* app logic */ Ok(()) }
```

## Testing

```rust
// Unit test
#[test]
fn test_process_users() {
    let users = vec![User { id: 1, name: "john".into(), age: 25 }];
    let result: Vec<_> = process_users(users.iter()).collect();
    assert_eq!(result[0].name, "JOHN");
}

// Property-based test (proptest)
proptest! {
    #[test]
    fn test_count(users in prop::collection::vec(any::<User>(), 0..100)) {
        assert_eq!(process_users(users.iter()).count(), users.iter().filter(|u| u.age >= 18).count());
    }
}
```

## Best Practices

**Ownership** => Use `&` refs, avoid unnecessary ownership transfer
```rust
fn process(data: &[String]) -> Vec<String> { data.iter().map(|s| s.to_uppercase()).collect() }
```

**Error Handling** => Use `Result` with `?`, never `.unwrap()` in production
```rust
fn read_config(path: &str) -> AppResult<Config> {
    let content = fs::read_to_string(path)?;
    Ok(toml::from_str(&content)?)
}
```

**Iterators** => Lazy evaluation, avoid eager `Vec`
```rust
fn process(items: &[Item]) -> impl Iterator<Item = String> + '_ {
    items.iter().filter(|i| i.is_valid()).map(|i| i.name.clone())
}
```

**Traits** => Generic with bounds, not concrete types
```rust
fn log_items<L: Logger, I: IntoIterator<Item = String>>(logger: &L, items: I) -> AppResult<()> {
    for item in items { logger.log(&item)?; }
    Ok(())
}
```

## Commands

```bash
cargo build          # Build
cargo run            # Run
cargo test           # Test
cargo clippy         # Lint
cargo fmt            # Format
cargo build --release # Release build
cargo doc --open     # Docs
```


