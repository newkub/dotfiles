---
description: type-safe
auto_execution_mode: 1
---

TypeScript is designed to provide strong type safety at compile-time, helping developers catch errors before runtime. By following structured rules and best practices, you can ensure that your code is robust, maintainable, and less prone to bugs. The following list organizes type-safe techniques into groups based on their context and usage.

## 1. Object & Property Safety

- Use `interface` or `type` to define object/function structures  
- Use `readonly` to prevent property/array modification  
- Use const assertions (`as const`) to make literal types immutable  
- Use literal types to restrict values to predefined options  
- Use `enum` / `const enum` for limited and clear values  
- Define domain-specific types, e.g., `UserId = string & { readonly brand: unique symbol }`

## 2. Function & Generics

- Use Generics to make functions/classes type-safe and flexible  
- Use `keyof` and `typeof` for type-safe object key lookups  
- Use utility types like `ReturnType`, `Parameters`, `Partial`, `Required`, `Pick`, `Omit`  
- Use mapped types for type-safe transformations

## 3. Compile-time Safety

- Use `unknown` instead of `any` to force type checks before use  
- Use template literal types for pattern-based validation, e.g., `'user-${number}'`  
- Use branded types to distinguish types that are structurally identical but semantically different  
- Use const assertions + literal unions instead of magic strings/numbers  
- Avoid `any` or `as any` unless absolutely necessary  
- Apply ESLint rules like `@typescript-eslint/strict-boolean-expressions`

## 4. Runtime Safety

- Use `zod` / `io-ts` for runtime type validation  
- Perform runtime schema validation to ensure type safety for API/data input
