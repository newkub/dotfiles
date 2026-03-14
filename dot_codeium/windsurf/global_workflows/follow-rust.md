---
description: แนวทางการพัฒนา Rust projects ตาม Best Practices ครบถ้วนสำหรับ Production Grade
---

# Rust Project Development Workflow

## 1. Project Structure Analysis

```sh
eza --tree --git-ignore
eza --tree --git-ignore
```

## 2. Rust Monorepo with Turborepo Structure

```
rust-monorepo/
├── apps/                           # Applications
│   ├── cli/                        # CLI application
│   │   ├── Cargo.toml
│   │   ├── src/
│   │   │   ├── main.rs
│   │   │   └── ...
│   │   └── package.json            # Turborepo config
│   └── tui/                        # TUI application
│       ├── Cargo.toml
│       ├── src/
│       │   ├── main.rs
│       │   └── ...
│       └── package.json
├── packages/                       # Shared libraries
│   ├── core/                       # Core business logic
│   │   ├── Cargo.toml
│   │   ├── src/
│   │   │   ├── lib.rs
│   │   │   ├── domain/
│   │   │   │   ├── mod.rs
│   │   │   │   ├── entities/
│   │   │   │   │   ├── mod.rs
│   │   │   │   │   ├── user.rs
│   │   │   │   │   └── agent.rs
│   │   │   │   ├── value_objects/
│   │   │   │   │   ├── mod.rs
│   │   │   │   │   ├── email.rs
│   │   │   │   │   └── id.rs
│   │   │   │   ├── repositories/
│   │   │   │   │   ├── mod.rs
│   │   │   │   │   └── user_repository.rs
│   │   │   │   └── errors/
│   │   │   │       ├── mod.rs
│   │   │   │       └── domain_error.rs
│   │   │   ├── application/
│   │   │   │   ├── mod.rs
│   │   │   │   ├── commands/
│   │   │   │   ├── queries/
│   │   │   │   ├── services/
│   │   │   │   └── dto/
│   │   │   └── shared/
│   │   │       ├── functional/
│   │   │       │   ├── mod.rs
│   │   │       │   ├── core.rs
│   │   │       │   ├── effects.rs
│   │   │       │   ├── state.rs
│   │   │       │   ├── validation.rs
│   │   │       │   ├── pipeline.rs
│   │   │       │   ├── either.rs
│   │   │       │   └── io.rs
│   │   │       ├── utils/
│   │   │       └── types/
│   │   └── package.json
│   ├── infrastructure/             # Infrastructure layer
│   │   ├── database/               # Database implementations
│   │   │   ├── Cargo.toml
│   │   │   ├── src/
│   │   │   │   ├── lib.rs
│   │   │   │   ├── postgres.rs
│   │   │   │   ├── sqlite.rs
│   │   │   │   └── migrations/
│   │   │   └── package.json
│   │   ├── http/                   # HTTP clients
│   │   │   ├── Cargo.toml
│   │   │   ├── src/
│   │   │   │   ├── lib.rs
│   │   │   │   ├── client.rs
│   │   │   │   └── middleware.rs
│   │   │   └── package.json
│   │   ├── config/                 # Configuration
│   │   │   ├── Cargo.toml
│   │   │   ├── src/
│   │   │   │   ├── lib.rs
│   │   │   │   └── app_config.rs
│   │   │   └── package.json
│   │   └── external_services/      # External API integrations
│   │       ├── Cargo.toml
│   │       ├── src/
│   │       │   ├── lib.rs
│   │       │   └── payment_service.rs
│   │       └── package.json
│   ├── presentation/              # Presentation layer
│   │   ├── tui/                    # TUI components
│   │   │   ├── Cargo.toml
│   │   │   ├── src/
│   │   │   │   ├── lib.rs
│   │   │   │   ├── components/
│   │   │   │   │   ├── functional_list.rs
│   │   │   │   │   └── ...
│   │   │   │   └── events.rs
│   │   │   └── package.json
│   │   └── cli/                    # CLI components
│   │       ├── Cargo.toml
│   │       ├── src/
│   │       │   ├── lib.rs
│   │       │   └── commands.rs
│   │       └── package.json
│   └── shared/                    # Shared utilities
│       ├── logging/                # Logging utilities
│       │   ├── Cargo.toml
│       │   ├── src/
│       │   │   ├── lib.rs
│       │   │   └── logger.rs
│       │   └── package.json
│       ├── metrics/                # Metrics collection
│       │   ├── Cargo.toml
│       │   ├── src/
│       │   │   ├── lib.rs
│       │   │   └── collector.rs
│       │   └── package.json
│       └── testing/                # Testing utilities
│           ├── Cargo.toml
│           ├── src/
│           │   ├── lib.rs
│           │   └── mocks.rs
│           └── package.json
├── tools/                          # Development tools
│   ├── codegen/                    # Code generation
│   │   ├── Cargo.toml
│   │   ├── src/
│   │   │   └── main.rs
│   │   └── package.json
│   ├── migration/                  # Database migration tool
│   │   ├── Cargo.toml
│   │   ├── src/
│   │   │   └── main.rs
│   │   └── package.json
│   └── bench/                      # Benchmarking tool
│       ├── Cargo.toml
│       ├── src/
│       │   └── main.rs
│       └── package.json
├── docs/                           # Documentation
│   ├── architecture/
│   ├── api/
│   ├── examples/
│   └── README.md
├── tests/                          # Integration tests
│   ├── integration/
│   ├── e2e/
│   └── fixtures/
├── benches/                        # Benchmark suite
│   ├── Cargo.toml
│   └── benches/
├── .github/                        # GitHub workflows
│   └── workflows/
│       ├── ci.yml
│       ├── release.yml
│       └── security.yml
├── Cargo.toml                      # Workspace configuration
├── Cargo.lock                      # Lock file
├── package.json                    # Turborepo configuration
├── turbo.json                      # Turborepo configuration
├── rust-toolchain.toml             # Rust version specification
├── justfile                        # Task runner
├── .gitignore
├── README.md
├── CHANGELOG.md
└── LICENSE
```

## 3. Layer Architecture Explained

### Domain Layer (Pure Rust)
- **entities/** - Core business objects with behavior
- **value_objects/** - Immutable value objects (Email, Id, Money)
- **repositories/** - Abstract repository traits
- **services/** - Domain business logic
- **errors/** - Domain-specific error types

### Application Layer
- **commands/** - Command pattern for write operations
- **queries/** - Query pattern for read operations (CQRS)
- **services/** - Application orchestration
- **dto/** - Data transfer objects for external communication

### Infrastructure Layer
- **database/** - Database connections and migrations
- **repositories/** - Concrete repository implementations
- **http/** - HTTP clients and external API calls
- **config/** - Configuration management
- **external_services/** - Third-party service integrations

### Presentation Layer
- **cli/** - Command-line interface
- **tui/** - Terminal user interface (ratatui)
- **grpc/** - gRPC service implementations

## 4. Rust Development Principles

### 4.1 Core Principles
1. **Ownership & Borrowing** - Leverage Rust's ownership system
2. **Zero-cost Abstractions** - Use generics and traits efficiently
3. **Memory Safety** - No garbage collector, compile-time guarantees
4. **Concurrency** - Fearless concurrency with async/await
5. **Error Handling** - Explicit error handling with Result<T, E>

### 4.2 Functional Programming
```rust
// Pure functions
fn calculate_total(items: &[Item]) -> Money {
    items.iter()
        .map(|item| item.price())
        .fold(Money::zero(), |acc, price| acc + price)
}

// Immutable data structures
#[derive(Debug, Clone)]
struct User {
    id: UserId,
    email: Email,
    created_at: DateTime<Utc>,
}

// Composition over inheritance
trait Repository<T> {
    async fn find_by_id(&self, id: &T::Id) -> Result<Option<T>, RepoError>;
    async fn save(&self, entity: &T) -> Result<(), RepoError>;
}
```

### 4.3 Type Safety
```rust
// Strongly typed IDs
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct UserId(Uuid);

impl UserId {
    pub fn new() -> Self {
        Self(Uuid::new_v4())
    }
}

// Value objects with validation
#[derive(Debug, Clone, PartialEq)]
pub struct Email(String);

impl Email {
    pub fn new(email: &str) -> Result<Self, EmailError> {
        if !email.contains('@') {
            return Err(EmailError::InvalidFormat);
        }
        Ok(Self(email.to_string()))
    }
}

// Domain-specific errors
#[derive(Debug, thiserror::Error)]
pub enum DomainError {
    #[error("User not found: {0}")]
    UserNotFound(UserId),
    #[error("Invalid email format")]
    InvalidEmail,
    #[error("Permission denied")]
    PermissionDenied,
}
```

## 5. Rust Monorepo Configuration

### 5.1 Workspace Cargo.toml (Root)

```toml
[workspace]
members = [
    # Applications
    "apps/cli",
    "apps/tui",
    
    # Core packages
    "packages/core",
    "packages/infrastructure/*",
    "packages/presentation/*",
    "packages/shared/*",
    
    # Tools
    "tools/*",
    
    # Development
    "benches",
    "tests/*",
]

resolver = "2"

[workspace.package]
version = "0.1.0"
edition = "2021"
authors = ["Wrikka <dev@wrikka.com>"]
license = "MIT OR Apache-2.0"
repository = "https://github.com/wrikka/rust-monorepo"
homepage = "https://github.com/wrikka/rust-monorepo"
rust-version = "1.75.0"

[workspace.dependencies]
# Core dependencies
tokio = { version = "1.50", features = ["full"] }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
thiserror = "2.0"
anyhow = "1.0"
tracing = "0.1"
tracing-subscriber = { version = "0.3", features = ["env-filter", "fmt"] }
uuid = { version = "1.22", features = ["v4", "serde"] }
chrono = { version = "0.4", features = ["serde"] }

# Functional programming
fp-core = "0.1.9"
itertools = "0.14"
tool = "0.1"
rayon = "1.11"

# Database
sqlx = { version = "0.8", features = ["runtime-tokio-rustls", "postgres", "uuid", "chrono"] }

# HTTP
reqwest = { version = "0.13", features = ["json", "rustls-tls"] }

# TUI
ratatui = "0.31"
crossterm = "0.30"

# CLI
clap = { version = "4.6", features = ["derive", "env"] }

# Testing
mockall = "0.14"
proptest = "1.6"
criterion = { version = "0.8", features = ["html_reports"] }

[profile.release]
lto = true
codegen-units = 1
strip = true
panic = "abort"
opt-level = "z"

[profile.dev]
debug = true
overflow-checks = true

[profile.bench]
debug = true
```

### 5.2 Turborepo Configuration

```json
// package.json (Root)
{
  "name": "rust-monorepo",
  "private": true,
  "scripts": {
    "build": "turbo run build",
    "test": "turbo run test",
    "lint": "turbo run lint",
    "format": "turbo run format",
    "dev": "turbo run dev",
    "clean": "turbo run clean && cargo clean",
    "bench": "turbo run bench",
    "check": "turbo run check",
    "docs": "turbo run docs",
    "migration": "cargo run --bin migration",
    "codegen": "cargo run --bin codegen"
  },
  "devDependencies": {
    "turbo": "^2.0.0"
  },
  "engines": {
    "node": ">=18.0.0"
  },
  "packageManager": "pnpm@8.0.0"
}
```

```json
// turbo.json
{
  "$schema": "https://turbo.build/schema.json",
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["target/**", "dist/**"]
    },
    "test": {
      "dependsOn": ["build"],
      "outputs": []
    },
    "test:unit": {
      "dependsOn": ["build"],
      "outputs": []
    },
    "test:integration": {
      "dependsOn": ["build"],
      "outputs": []
    },
    "lint": {
      "outputs": []
    },
    "format": {
      "outputs": []
    },
    "format:check": {
      "outputs": []
    },
    "clippy": {
      "dependsOn": ["build"],
      "outputs": []
    },
    "doc": {
      "dependsOn": ["build"],
      "outputs": ["target/doc/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "bench": {
      "dependsOn": ["build"],
      "outputs": ["target/criterion/**"]
    },
    "clean": {
      "cache": false
    },
    "check": {
      "dependsOn": ["^check"],
      "outputs": []
    },
    "docs": {
      "outputs": ["docs/**"]
    },
    "migration": {
      "cache": false,
      "outputs": []
    },
    "codegen": {
      "cache": false,
      "outputs": []
    }
  },
  "globalEnv": [
    "RUST_LOG",
    "DATABASE_URL",
    "NODE_ENV"
  ]
}
```

### 5.3 Application Package.json Examples

```json
// apps/cli/package.json
{
  "name": "@wrikka/cli",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "build": "cargo build --release",
    "dev": "cargo run",
    "test": "cargo test",
    "test:unit": "cargo test --lib",
    "test:integration": "cargo test --test integration",
    "lint": "cargo clippy -- -D warnings",
    "format": "cargo fmt",
    "format:check": "cargo fmt -- --check",
    "clippy": "cargo clippy -- -D warnings",
    "doc": "cargo doc --no-deps",
    "clean": "cargo clean",
    "check": "cargo check"
  },
  "dependencies": {
    "@wrikka/core": "workspace:*",
    "@wrikka/infrastructure-config": "workspace:*",
    "@wrikka/presentation-cli": "workspace:*",
    "@wrikka/shared-logging": "workspace:*"
  }
}
```

```json
// apps/web/package.json
{
  "name": "@wrikka/web",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "build": "cargo build --release",
    "dev": "cargo run",
    "test": "cargo test",
    "test:unit": "cargo test --lib",
    "test:integration": "cargo test --test integration",
    "lint": "cargo clippy -- -D warnings",
    "format": "cargo fmt",
    "format:check": "cargo fmt -- --check",
    "clippy": "cargo clippy -- -D warnings",
    "doc": "cargo doc --no-deps",
    "clean": "cargo clean",
    "check": "cargo check"
  },
  "dependencies": {
    "@wrikka/core": "workspace:*",
    "@wrikka/infrastructure-database": "workspace:*",
    "@wrikka/infrastructure-http": "workspace:*",
    "@wrikka/presentation-web": "workspace:*",
    "@wrikka/shared-logging": "workspace:*",
    "@wrikka/shared-metrics": "workspace:*"
  }
}
```

```json
// apps/tui/package.json
{
  "name": "@wrikka/tui",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "build": "cargo build --release",
    "dev": "cargo run",
    "test": "cargo test",
    "test:unit": "cargo test --lib",
    "test:integration": "cargo test --test integration",
    "lint": "cargo clippy -- -D warnings",
    "format": "cargo fmt",
    "format:check": "cargo fmt -- --check",
    "clippy": "cargo clippy -- -D warnings",
    "doc": "cargo doc --no-deps",
    "clean": "cargo clean",
    "check": "cargo check"
  },
  "dependencies": {
    "@wrikka/core": "workspace:*",
    "@wrikka/infrastructure-config": "workspace:*",
    "@wrikka/presentation-tui": "workspace:*",
    "@wrikka/shared-logging": "workspace:*"
  }
}
```

### 5.4 Package Configuration Examples

```json
// packages/core/package.json
{
  "name": "@wrikka/core",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "build": "cargo build --release",
    "test": "cargo test",
    "test:unit": "cargo test --lib",
    "lint": "cargo clippy -- -D warnings",
    "format": "cargo fmt",
    "format:check": "cargo fmt -- --check",
    "clippy": "cargo clippy -- -D warnings",
    "doc": "cargo doc --no-deps",
    "clean": "cargo clean",
    "check": "cargo check",
    "publish": "cargo publish --dry-run"
  },
  "dependencies": {
    "fp-core": "0.1.9",
    "itertools": "0.14",
    "tool": "0.1",
    "rayon": "1.10"
  }
}
```

### 5.5 Individual Package Cargo.toml Examples

```toml
# packages/core/Cargo.toml
[package]
name = "wrikka-core"
version.workspace = true
edition.workspace = true
authors.workspace = true
license.workspace = true
repository.workspace = true
homepage.workspace = true
rust-version.workspace = true

[dependencies]
# Workspace dependencies
tokio = { workspace = true }
serde = { workspace = true }
serde_json = { workspace = true }
thiserror = { workspace = true }
anyhow = { workspace = true }
tracing = { workspace = true }
uuid = { workspace = true }
chrono = { workspace = true }

# Functional programming
fp-core = { workspace = true }
itertools = { workspace = true }
tool = { workspace = true }
rayon = { workspace = true }

[dev-dependencies]
mockall = { workspace = true }
proptest = { workspace = true }
tokio-test = { workspace = true }

[lib]
name = "wrikka_core"
path = "src/lib.rs"

[[bench]]
name = "core_benchmarks"
harness = false
```

```toml
# apps/cli/Cargo.toml
[package]
name = "wrikka-cli"
version.workspace = true
edition.workspace = true
authors.workspace = true
license.workspace = true
repository.workspace = true
homepage.workspace = true
rust-version.workspace = true

[[bin]]
name = "wrikka"
path = "src/main.rs"

[dependencies]
# Core
wrikka-core = { path = "../../packages/core" }
wrikka-infrastructure-config = { path = "../../packages/infrastructure/config" }
wrikka-presentation-cli = { path = "../../packages/presentation/cli" }
wrikka-shared-logging = { path = "../../packages/shared/logging" }

# Workspace dependencies
tokio = { workspace = true }
serde = { workspace = true }
serde_json = { workspace = true }
tracing = { workspace = true }
tracing-subscriber = { workspace = true }
clap = { workspace = true }
anyhow = { workspace = true }

[dev-dependencies]
mockall = { workspace = true }
tempfile = { workspace = true }
```

### 5.6 Enhanced Justfile for Monorepo

```makefile
# justfile for Rust Monorepo with Turborepo
default: help

# Help
help:
    @echo "Available commands:"
    @echo "  setup         - Setup development environment"
    @echo "  dev           - Start development mode"
    @echo "  build         - Build all packages"
    @echo "  test          - Run all tests"
    @echo "  lint          - Run linting"
    @echo "  format        - Format code"
    @echo "  clean         - Clean build artifacts"
    @echo "  bench         - Run benchmarks"
    @echo "  docs          - Generate documentation"
    @echo "  migration     - Run database migrations"
    @echo "  codegen       - Generate code"
    @echo ""
    @echo "Package-specific commands:"
    @echo "  build <pkg>   - Build specific package"
    @echo "  test <pkg>    - Test specific package"
    @echo "  run <pkg>     - Run specific package"

# Setup development environment
setup:
    @echo "Setting up Rust monorepo..."
    rustup update stable
    rustup component add clippy rustfmt rust-src
    cargo install cargo-nextest cargo-watch cargo-audit cargo-deny cargo-machete
    npm install -g pnpm
    pnpm install

# Development (uses Turborepo)
dev:
    pnpm turbo run dev

# Build all packages
build:
    pnpm turbo run build

# Build specific package
build pkg:
    pnpm turbo run build --filter={{pkg}}

# Test all packages
test:
    pnpm turbo run test

# Test specific package
test pkg:
    pnpm turbo run test --filter={{pkg}}

# Unit tests
test:unit:
    pnpm turbo run test:unit

# Integration tests
test:integration:
    pnpm turbo run test:integration

# Lint all packages
lint:
    pnpm turbo run lint

# Format all code
format:
    pnpm turbo run format

# Check formatting
format:check:
    pnpm turbo run format:check

# Run clippy
clippy:
    pnpm turbo run clippy

# Clean all artifacts
clean:
    pnpm turbo run clean
    cargo clean

# Run benchmarks
bench:
    pnpm turbo run bench

# Generate documentation
docs:
    pnpm turbo run doc

# Check all packages
check:
    pnpm turbo run check

# Security audit
audit:
    cargo audit
    pnpm audit

# Check for unused dependencies
check-unused:
    cargo machete

# Database migrations
migration:
    pnpm turbo run migration

# Code generation
codegen:
    pnpm turbo run codegen

# Run specific application
run app:
    cd apps/{{app}} && cargo run

# Watch specific package
watch pkg:
    cd packages/{{pkg}} && cargo watch -x test

# Install tools
install-tools:
    cargo install cargo-watch cargo-nextest cargo-audit cargo-deny cargo-machete cargo-expand
    cargo install cargo-criterion cargo-flamegraph

# Update dependencies
update-deps:
    cargo update
    pnpm update

# Release preparation
release-prep:
    pnpm turbo run build
    pnpm turbo run test
    pnpm turbo run lint
    pnpm turbo run doc

# Workspace information
workspace-info:
    @echo "Workspace members:"
    @cargo metadata --no-deps --format-version 1 | jq -r '.workspace_members[]'
    @echo ""
    @echo "Package graph:"
    @cargo tree --duplicates --workspace

# Dependency graph
deps:
    @cargo tree --workspace

# Check for circular dependencies
check-circular:
    @cargo machete

# Generate feature matrix
feature-matrix:
    @echo "Feature matrix:"
    @cargo tree --features --workspace

# Run in docker
docker-build:
    docker build -t rust-monorepo .

docker-run:
    docker run -it rust-monorepo

# Performance profiling
profile:
    cd packages/core && cargo flamegraph --bin core_benchmarks

# Memory profiling
memory-profile:
    cd packages/core && valgrind --tool=massif cargo test

# Coverage report
coverage:
    cargo install cargo-tarpaulin
    cargo tarpaulin --workspace --out Html --output-dir target/coverage

# Documentation server
docs-serve:
    cd packages/core && cargo doc --no-deps --open
```

## 6. Monorepo Development Patterns

### 6.1 Cross-Package Dependencies

```rust
// apps/cli/src/main.rs
use wrikka_core::domain::entities::Agent;
use wrikka_infrastructure_config::AppConfig;
use wrikka_presentation_cli::CliApp;
use wrikka_shared_logging::init_logger;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    init_logger();
    
    let config = AppConfig::load()?;
    let app = CliApp::new(config);
    app.run().await
}
```

### 6.2 Shared Configuration

```rust
// packages/infrastructure/config/src/lib.rs
use serde::{Deserialize, Serialize};
use std::path::PathBuf;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DatabaseConfig {
    pub url: String,
    pub max_connections: u32,
    pub timeout_seconds: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AppConfig {
    pub database: DatabaseConfig,
    pub log_level: String,
    pub server_port: u16,
}

impl AppConfig {
    pub fn load() -> Result<Self, config::ConfigError> {
        let settings = config::Config::builder()
            .add_source(config::File::with_name("config/default"))
            .add_source(config::File::with_name("config/local").required(false))
            .add_source(config::Environment::with_prefix("APP"))
            .build()?;
        
        settings.try_deserialize()
    }
}
```

### 6.3 Workspace Testing Utilities

```rust
// packages/shared/testing/src/lib.rs
use mockall::predicate::*;
use mockall::*;
use wrikka_core::domain::entities::agent::*;

// Mock implementations for testing
automock! {
    pub AgentRepository {
        async fn find_by_id(&self, id: AgentId) -> Result<Option<Agent<Idle>>, RepositoryError>;
        async fn save(&self, agent: &Agent<Idle>) -> Result<(), RepositoryError>;
    }
}

pub struct TestAgentFactory;

impl TestAgentFactory {
    pub fn create_test_agent(name: &str) -> Agent<Idle> {
        let config = AgentConfig::new(name.to_string())
            .with_description("Test agent".to_string());
        AgentFactory::create_agent(config)
    }
    
    pub fn create_test_agent_with_metrics(name: &str) -> Agent<Idle> {
        let mut agent = Self::create_test_agent(name);
        // Add test metrics
        agent
    }
}

#[cfg(test)]
pub mod test_utils {
    use super::*;
    use tempfile::TempDir;
    
    pub fn setup_test_database() -> (TempDir, String) {
        let temp_dir = TempDir::new().unwrap();
        let db_path = temp_dir.path().join("test.db");
        let db_url = format!("sqlite:{}", db_path.display());
        (temp_dir, db_url)
    }
    
    pub async fn setup_test_app() -> (TestApp, AppConfig) {
        let config = AppConfig {
            database: DatabaseConfig {
                url: "sqlite::memory:".to_string(),
                max_connections: 1,
                timeout_seconds: 30,
            },
            log_level: "debug".to_string(),
            server_port: 0,
        };
        
        let app = TestApp::new(config.clone()).await;
        (app, config)
    }
}
```

### 6.4 CI/CD for Monorepo

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    name: Test
    runs-on: ubuntu-latest
    
    strategy:
      matrix:
        rust: [stable, beta, nightly]
        
    steps:
      - uses: actions/checkout@v4
        
      - name: Install Rust
        uses: dtolnay/rust-toolchain@master
        with:
          toolchain: ${{ matrix.rust }}
          components: rustfmt, clippy
          
      - name: Cache dependencies
        uses: actions/cache@v3
        with:
          path: |
            ~/.cargo/registry
            ~/.cargo/git
            target
          key: ${{ runner.os }}-cargo-${{ hashFiles('**/Cargo.lock') }}
          
      - name: Install Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          
      - name: Install pnpm
        uses: pnpm/action-setup@v2
        with:
          version: 8
          
      - name: Install dependencies
        run: pnpm install
        
      - name: Check formatting
        run: pnpm turbo run format:check
        
      - name: Run clippy
        run: pnpm turbo run clippy
        
      - name: Run tests
        run: pnpm turbo run test
        
      - name: Run integration tests
        run: pnpm turbo run test:integration
        
      - name: Build
        run: pnpm turbo run build
        
      - name: Run benchmarks
        run: pnpm turbo run bench
        
      - name: Security audit
        run: |
          cargo audit
          pnpm audit

  coverage:
    name: Coverage
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
        
      - name: Install Rust
        uses: dtolnay/rust-toolchain@stable
        with:
          components: llvm-tools-preview
          
      - name: Install cargo-tarpaulin
        run: cargo install cargo-tarpaulin
        
      - name: Generate coverage report
        run: cargo tarpaulin --workspace --out Xml --output-dir target/coverage
        
      - name: Upload to codecov
        uses: codecov/codecov-action@v3
        with:
          file: target/coverage/cobertura.xml
```

## 7. Comprehensive Cargo.toml Template

```toml
[package]
name = "@wrikka/project-name"
version = "0.1.0"
edition = "2021"
authors = ["Your Name <your.email@example.com>"]
description = "Project description with value proposition"
license = "MIT OR Apache-2.0"
repository = "https://github.com/wrikka/project-name"
homepage = "https://github.com/wrikka/project-name"
documentation = "https://docs.rs/project-name"
keywords = ["cli", "terminal", "productivity"]
categories = ["command-line-utilities", "development-tools"]
readme = "README.md"
rust-version = "1.75.0"

[dependencies]
# Core async runtime
tokio = { version = "1.50", features = ["full"] }
tokio-util = "0.7"

# Serialization
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
toml = "0.9"

# Error handling
anyhow = "1.0"
thiserror = "2.0"

# CLI framework
clap = { version = "4.6", features = ["derive", "env"] }

# Configuration management
config = "0.15"
dotenvy = "0.15"

# Logging and telemetry
tracing = "0.1"
tracing-subscriber = { version = "0.3", features = ["env-filter", "fmt", "json"] }
tracing-appender = "0.2"

# HTTP client/server (choose based on needs)
reqwest = { version = "0.13", features = ["json", "rustls-tls"] }
# axum = { version = "0.8", features = ["tokio", "macros"], optional = true }

# Database (choose based on needs)
sqlx = { version = "0.8", features = ["runtime-tokio-rustls", "postgres", "uuid", "chrono"], optional = true }
# diesel = { version = "2.2", features = ["postgres", "uuid", "chrono"], optional = true }

# UUID and time
uuid = { version = "1.22", features = ["v4", "serde", "fast-rng"] }
chrono = { version = "0.4", features = ["serde"] }

# Utilities
regex = "1.12"
walkdir = "2.5"
dirs = "6.0"
arboard = "3.6"
tempfile = "3.27"

# Async traits
async-trait = "0.1"

# Futures utilities
futures = "0.3"
futures-util = "0.3"

# TUI (if needed)
ratatui = { version = "0.30", optional = true }
crossterm = { version = "0.29", optional = true }

# Metrics and monitoring
metrics = "0.25"
metrics-exporter-prometheus = { version = "0.16", optional = true }

# Security
ring = "0.18"
argon2 = "0.6"

[dev-dependencies]
tokio-test = "0.4"
criterion = { version = "0.8", features = ["html_reports"] }
tempfile = "3.27"
mockall = "0.14"
pretty_assertions = "1.4"
proptest = "1.6"

[features]
default = []
web = ["axum"]
database = ["sqlx"]
tui = ["ratatui", "crossterm"]
metrics = ["metrics-exporter-prometheus"]
all = ["web", "database", "tui", "metrics"]

[[bin]]
name = "project-name"
path = "src/main.rs"

[lib]
name = "project_name"
path = "src/lib.rs"

[profile.release]
lto = true
codegen-units = 1
strip = true
panic = "abort"
opt-level = "z"

[profile.dev]
debug = true
overflow-checks = true

[profile.bench]
debug = true

[[bench]]
name = "performance"
harness = false
```

## 6. Development Tools Configuration

### 6.1 justfile Template
```makefile
# Development tasks
default: help

help:
    @just --list

# Setup development environment
setup:
    @echo "Setting up development environment..."
    rustup update stable
    rustup component add clippy rustfmt
    cargo install cargo-watch cargo-nextest cargo-audit cargo-deny

# Run development server
dev:
    cargo run --features all

# Build for production
build:
    cargo build --release --features all

# Run tests
test:
    cargo nextest run --all-features

test-watch:
    cargo watch -x "nextest run --all-features"

# Run integration tests
test-integration:
    cargo test --test integration --features all

# Run benchmarks
bench:
    cargo bench --features all

# Code quality checks
lint:
    cargo clippy --all-features -- -D warnings -W clippy::all
    cargo fmt --check

format:
    cargo fmt

# Security audit
audit:
    cargo audit
    cargo deny check

# Documentation
docs:
    cargo doc --no-deps --document-private-items --open

# Clean build artifacts
clean:
    cargo clean
    rm -rf target/

# Generate coverage report
coverage:
    cargo tarpaulin --out Html --features all

# Release workflow
release: test lint audit build
    @echo "Ready for release!"
```

### 6.2 rust-toolchain.toml
```toml
[toolchain]
channel = "1.75.0"
components = ["clippy", "rustfmt", "rust-src"]
profile = "minimal"
```

### 6.3 .gitignore Template
```gitignore
# Rust
/target/
Cargo.lock
**/*.rs.bk

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Environment
.env
.env.local
.env.*.local

# Logs
*.log
logs/

# Coverage
tarpaulin-report.html
cobertura.xml

# Database
*.db
*.sqlite

# Temporary files
tmp/
temp/

# Documentation build
/docs/book/
/target/doc/