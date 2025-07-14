เวลาเขียน code อะไรให้ทำตามนี้

# OS Environment
- OS => Windows
- Package Manager => Scoop
- Shell => PowerShell

## devdependencies
- linter => biome
- formatter => biome
- husky => husky

# JavaScript/TypeScript
- file extension => .ts
- TypeScript mode => strict mode
- code style => ESLint + Prettier
- dependencies tracking => bun.lockb

# Runtime/Package Management
- runtime => Bun
- package manager => Bun
- child_process alternative => execa
- prompt library => @clack/prompts

# Vue
- file extension => .vue with <script lang="ts"> setup
- API style => Vue 3 Composition API with <script setup>
- state management => Pinia
- routing => Vue Router

# React 
- file extension => .tsx
- component style => Functional Components + Hooks
- state management => Context API or Zustand
- routing => React Router

# Testing
- unit tests => Vitest
- E2E tests => Playwright

# Project Structure
- organization => feature-based or domain-driven folder structure
- separation => business logic separate from UI components
- large projects => monorepo with Turborepo or