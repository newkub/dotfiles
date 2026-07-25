---
title: Follow Functional Programming
description: à¸žà¸±à¸’à¸™à¸²à¹‚à¸›à¸£à¹€à¸ˆà¸à¸•à¹Œà¸”à¹‰à¸§à¸¢ functional programming principles à¸žà¸£à¹‰à¸­à¸¡ pure functions, immutability, composition
auto_execution_mode: 3
related:
  - /improve-architecture
---

## Goal

à¸žà¸±à¸’à¸™à¸²à¹‚à¸›à¸£à¹€à¸ˆà¸à¸•à¹Œà¸”à¹‰à¸§à¸¢ functional programming principles à¹€à¸žà¸·à¹ˆà¸­à¸¥à¸”à¸„à¸§à¸²à¸¡à¸‹à¸±à¸šà¸‹à¹‰à¸­à¸™ à¹€à¸žà¸´à¹ˆà¸¡à¸„à¸§à¸²à¸¡à¸›à¸¥à¸­à¸”à¸ à¸±à¸¢ à¹à¸¥à¸°à¸—à¸³à¹ƒà¸«à¹‰à¹‚à¸„à¹‰à¸” test à¹„à¸”à¹‰à¸‡à¹ˆà¸²à¸¢à¸‚à¸¶à¹‰à¸™

## Execute

### 1. Use Pure Functions

à¹€à¸‚à¸µà¸¢à¸™à¸Ÿà¸±à¸‡à¸à¹Œà¸Šà¸±à¸™à¸—à¸µà¹ˆ pure à¹€à¸ªà¸¡à¸­à¹€à¸¡à¸·à¹ˆà¸­à¹€à¸›à¹‡à¸™à¹„à¸›à¹„à¸”à¹‰

1. à¸«à¸¥à¸µà¸à¹€à¸¥à¸µà¹ˆà¸¢à¸‡ `side effects`: `API calls`, `DOM access`, `external state`
2. Return à¸„à¹ˆà¸²à¹€à¸”à¸´à¸¡à¹€à¸ªà¸¡à¸­à¹€à¸¡à¸·à¹ˆà¸­ input à¹€à¸”à¸´à¸¡
3. à¹à¸¢à¸ pure logic à¸ˆà¸²à¸ impure interactions
4. à¹ƒà¸Šà¹‰ `pure functions` à¸ªà¸³à¸«à¸£à¸±à¸š business logic
5. à¹ƒà¸Šà¹‰ `impure functions` à¹€à¸‰à¸žà¸²à¸°à¹ƒà¸™ imperative shell

### 2. Enforce Immutability

à¸—à¸³à¸•à¸²à¸¡ `/declarative-programming` à¹€à¸žà¸·à¹ˆà¸­à¹ƒà¸Šà¹‰ immutability

1. à¹ƒà¸Šà¹‰ `const` à¹à¸—à¸™ `let/var` à¹€à¸ªà¸¡à¸­
2. à¹ƒà¸Šà¹‰ `Readonly<>` type à¸ªà¸³à¸«à¸£à¸±à¸š objects/arrays
3. à¹ƒà¸Šà¹‰ `readonly modifier` à¸ªà¸³à¸«à¸£à¸±à¸š class properties
4. à¹ƒà¸Šà¹‰ `spread operator` à¹à¸—à¸™ mutation
5. à¹ƒà¸Šà¹‰ `array methods` à¸—à¸µà¹ˆà¹„à¸¡à¹ˆ mutate: `map`, `filter`, `reduce`

### 3. Function Composition

à¸—à¸³à¸•à¸²à¸¡ `/declarative-programming` à¹€à¸žà¸·à¹ˆà¸­à¹ƒà¸Šà¹‰ composition

1. à¹€à¸‚à¸µà¸¢à¸™à¸Ÿà¸±à¸‡à¸à¹Œà¸Šà¸±à¸™à¸‚à¸™à¸²à¸”à¹€à¸¥à¹‡à¸à¸—à¸µà¹ˆà¸—à¸³à¸«à¸™à¹‰à¸²à¸—à¸µà¹ˆà¹€à¸”à¸µà¸¢à¸§
2. à¹ƒà¸Šà¹‰ `higher-order functions`: `map`, `filter`, `reduce`
3. à¸ªà¸£à¹‰à¸²à¸‡ `compose function` à¸ªà¸³à¸«à¸£à¸±à¸š pipeline
4. à¹ƒà¸Šà¹‰ `type inference` à¸ªà¸³à¸«à¸£à¸±à¸š type safety
5. à¹ƒà¸Šà¹‰ `generics` à¸ªà¸³à¸«à¸£à¸±à¸š reusable composition

### 4. Type Safety

à¸—à¸³à¸•à¸²à¸¡ `/typescript` à¹€à¸žà¸·à¹ˆà¸­à¹€à¸žà¸´à¹ˆà¸¡à¸„à¸§à¸²à¸¡à¸›à¸¥à¸­à¸”à¸ à¸±à¸¢

1. à¹ƒà¸Šà¹‰ `function types` à¸­à¸¢à¹ˆà¸²à¸‡à¸Šà¸±à¸”à¹€à¸ˆà¸™
2. à¹ƒà¸Šà¹‰ `generics` à¸ªà¸³à¸«à¸£à¸±à¸š reusable functions
3. à¹ƒà¸Šà¹‰ `union types` à¸ªà¸³à¸«à¸£à¸±à¸š multiple return types
4. à¹ƒà¸Šà¹‰ `type guards` à¸ªà¸³à¸«à¸£à¸±à¸š type narrowing
5. à¹ƒà¸Šà¹‰ `discriminated unions` à¸ªà¸³à¸«à¸£à¸±à¸š complex state

### 5. Separate Core and Shell

à¹à¸¢à¸ functional core à¸ˆà¸²à¸ imperative shell

1. à¸—à¸³ business logic à¹ƒà¸™ `pure functions`
2. à¹à¸¢à¸ `side effects` à¹„à¸›à¸—à¸µà¹ˆ outer layer
3. à¹ƒà¸Šà¹‰ `dependency injection` à¸ªà¸³à¸«à¸£à¸±à¸š impure dependencies
4. à¸—à¸³ `I/O` à¹ƒà¸™ imperative shell à¹€à¸—à¹ˆà¸²à¸™à¸±à¹‰à¸™
5. à¸—à¸³ validation à¹ƒà¸™ pure functions
6. à¸—à¸³ `/improve-architecture` à¹€à¸žà¸·à¹ˆà¸­à¸ˆà¸±à¸”à¸à¸²à¸£ side effects

### 6. Avoid Mutable State

à¸«à¸¥à¸µà¸à¹€à¸¥à¸µà¹ˆà¸¢à¸‡ mutable state à¸—à¸µà¹ˆà¹„à¸¡à¹ˆà¸ˆà¸³à¹€à¸›à¹‡à¸™

1. à¹ƒà¸Šà¹‰ `state machines` à¸ªà¸³à¸«à¸£à¸±à¸š complex state
2. à¹ƒà¸Šà¹‰ `reducers` à¸ªà¸³à¸«à¸£à¸±à¸š state updates
3. à¹ƒà¸Šà¹‰ `immutable data structures`
4. à¸«à¸¥à¸µà¸à¹€à¸¥à¸µà¹ˆà¸¢à¸‡ `shared state`
5. à¹ƒà¸Šà¹‰ `message passing` à¹à¸—à¸™ shared state

### 7. Error Handling

à¸ˆà¸±à¸”à¸à¸²à¸£ errors à¸”à¹‰à¸§à¸¢ functional approach

1. à¹ƒà¸Šà¹‰ `Result/Either types` à¹à¸—à¸™ exceptions
2. à¹ƒà¸Šà¹‰ `Option/Maybe types` à¸ªà¸³à¸«à¸£à¸±à¸š nullable values
3. Propagate errors à¸œà¹ˆà¸²à¸™ types à¹„à¸¡à¹ˆà¹ƒà¸Šà¹ˆ exceptions
4. à¹ƒà¸Šà¹‰ `typed error classes`
5. Handle errors à¸­à¸¢à¹ˆà¸²à¸‡ explicit

### 8. Testing

à¹€à¸‚à¸µà¸¢à¸™ tests à¸ªà¸³à¸«à¸£à¸±à¸š pure functions

1. `Pure functions` test à¸‡à¹ˆà¸²à¸¢à¸”à¹‰à¸§à¸¢ input/output
2. Mock impure dependencies à¹ƒà¸™ imperative shell
3. Test composition à¹à¸¢à¸à¸ˆà¸²à¸ individual functions
4. à¹ƒà¸Šà¹‰ `property-based testing`
5. Test edge cases à¸”à¹‰à¸§à¸¢ pure functions

## Rules

### Pure Functions

à¸Ÿà¸±à¸‡à¸à¹Œà¸Šà¸±à¸™à¸•à¹‰à¸­à¸‡à¹€à¸›à¹‡à¸™ pure à¹€à¸¡à¸·à¹ˆà¸­à¹€à¸›à¹‡à¸™à¹„à¸›à¹„à¸”à¹‰

- à¹„à¸¡à¹ˆà¸¡à¸µ `side effects`
- Return à¸„à¹ˆà¸²à¹€à¸”à¸´à¸¡à¹€à¸ªà¸¡à¸­à¹€à¸¡à¸·à¹ˆà¸­ `input` à¹€à¸”à¸´à¸¡
- à¹„à¸¡à¹ˆ access `external state`
- à¹„à¸¡à¹ˆ mutate `input parameters`
- à¹à¸¢à¸ pure logic à¸ˆà¸²à¸ `I/O`

### Immutability

à¸—à¸³à¸•à¸²à¸¡ `/declarative-programming` à¹€à¸žà¸·à¹ˆà¸­à¹ƒà¸Šà¹‰ immutability

- à¹ƒà¸Šà¹‰ `const` à¹à¸—à¸™ `let/var`
- à¹ƒà¸Šà¹‰ `Readonly<>` type
- à¹ƒà¸Šà¹‰ `spread operator`
- à¹ƒà¸Šà¹‰ `array methods` à¸—à¸µà¹ˆà¹„à¸¡à¹ˆ mutate
- à¹„à¸¡à¹ˆ mutate `objects/arrays` à¹‚à¸”à¸¢à¸•à¸£à¸‡

### Function Composition

à¸—à¸³à¸•à¸²à¸¡ `/declarative-programming` à¹€à¸žà¸·à¹ˆà¸­à¹ƒà¸Šà¹‰ composition

- à¸Ÿà¸±à¸‡à¸à¹Œà¸Šà¸±à¸™à¸‚à¸™à¸²à¸”à¹€à¸¥à¹‡à¸ `single responsibility`
- à¹ƒà¸Šà¹‰ `higher-order functions`
- à¹ƒà¸Šà¹‰ `pipeline pattern`
- `Type-safe` composition
- `Reusable generic functions`

### Type Safety

à¸—à¸³à¸•à¸²à¸¡ `/typescript` à¹€à¸žà¸·à¹ˆà¸­à¸„à¸§à¸²à¸¡à¸›à¸¥à¸­à¸”à¸ à¸±à¸¢

- Explicit `function types`
- `Generics` à¸ªà¸³à¸«à¸£à¸±à¸š reusability
- `Type guards` à¸ªà¸³à¸«à¸£à¸±à¸š narrowing
- `Discriminated unions`
- `Strict TypeScript config`

### Core and Shell

à¹à¸¢à¸ functional core à¸ˆà¸²à¸ imperative shell

- Business logic à¹€à¸›à¹‡à¸™ `pure functions`
- `Side effects` à¹ƒà¸™ outer layer
- `Dependency injection`
- `I/O` à¹€à¸‰à¸žà¸²à¸°à¹ƒà¸™ shell
- Validation à¹ƒà¸™ `pure functions`

### State Management

à¸ˆà¸±à¸”à¸à¸²à¸£ state à¸”à¹‰à¸§à¸¢ functional approach

- `Immutable state`
- `Reducers` à¸ªà¸³à¸«à¸£à¸±à¸š updates
- `State machines`
- No `shared state`
- `Message passing`

### Error Handling

à¸ˆà¸±à¸”à¸à¸²à¸£ errors à¸”à¹‰à¸§à¸¢ types à¹„à¸¡à¹ˆà¹ƒà¸Šà¹ˆ exceptions

- `Result/Either types`
- `Option/Maybe types`
- `Typed error classes`
- Explicit `error propagation`
- No `try/catch` à¹ƒà¸™ pure functions

## Expected Outcome

- Pure functions à¸ªà¸³à¸«à¸£à¸±à¸š business logic
- Immutability à¸—à¸±à¹ˆà¸§à¸—à¸±à¹‰à¸‡ codebase
- Function composition à¸—à¸µà¹ˆ type-safe
- Clear separation à¸£à¸°à¸«à¸§à¹ˆà¸²à¸‡ core à¹à¸¥à¸° shell
- Error handling à¸”à¹‰à¸§à¸¢ types
- State management à¸—à¸µà¹ˆ predictable
- Tests à¸—à¸µà¹ˆà¹€à¸‚à¸µà¸¢à¸™à¸‡à¹ˆà¸²à¸¢
- Code à¸—à¸µà¹ˆ maintain à¹„à¸”à¹‰à¸‡à¹ˆà¸²à¸¢

