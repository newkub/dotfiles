---
description: update-readme-and-test
auto_execution_mode: 1
---

1. ลองดูในpackage.json แล้วไล่อ่านไปเรื่อยๆ เพื่อให้ใจ และการเขียนใน README โดยมีหัวข้อ introduction, design principle, usage, file structure, script command ให้แต่ละหัวข้อมีคำอธิบาย และสรุปในตาราง

2. อัพเดท test/ ให้เข้ากับ readm.md

-------------------

````markdown
# Project Name

## Introduction
This project is designed to demonstrate best practices in TypeScript development, focusing on **type safety**, maintainability, and clear project structure. It includes scripts for building, testing, linting, and running the application efficiently.

## Design Principle
The project follows these core principles:
- **Type Safety:** Use TypeScript features such as interfaces, generics, literal types, and branded types.
- **Modularity:** Separate concerns using distinct modules and files.
- **Consistency:** Use a unified coding style enforced by linting and formatting scripts.
- **Test-driven:** Always write tests to validate features before merging.

## Usage
To start using the project:

```bash
# Install dependencies
bun install

# Run the project
bun run start

# Run tests
bun run test

# Lint and format code
bun run lint
bun run format
````

## File Structure

The project follows a clear structure to separate source, tests, and configuration:

| Folder/File     | Description                          |
| --------------- | ------------------------------------ |
| `src/`          | Contains all source TypeScript files |
| `test/`         | Unit and integration tests           |
| `package.json`  | Project metadata and scripts         |
| `tsconfig.json` | TypeScript configuration             |
| `README.md`     | Project documentation                |
| `scripts/`      | Custom helper scripts (optional)     |

## Script Command

All important scripts are defined in `package.json`:

| Script   | Command          | Description                                |
| -------- | ---------------- | ------------------------------------------ |
| `start`  | `bun run start`  | Runs the application                       |
| `build`  | `bun run build`  | Builds the TypeScript project              |
| `test`   | `bun run test`   | Runs unit and integration tests            |
| `lint`   | `bun run lint`   | Runs linter to check code style and errors |
| `format` | `bun run format` | Auto-formats code using configured rules   |

```


