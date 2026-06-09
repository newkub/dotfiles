# Global Workflows

<div align="center">
  <img src="https://placehold.co/120x120/6366f1/ffffff?text=GW" alt="Global Workflows Logo" width="80" />
  <h1>Global Workflows</h1>
  <h3>Standardized workflows for Windsurf IDE development</h3>
  <p>A comprehensive collection of 295+ workflows providing systematic approaches to common development tasks across all workspaces.<br/>Automated, repeatable, and consistent development practices.</p>

  <p>
    <a href="https://github.com/newkub/global_workflows/stargazers"><img src="https://img.shields.io/github/stars/newkub/global_workflows?style=flat-square&color=f59e0b" alt="Stars" /></a>
    <a href="https://github.com/newkub/global_workflows/releases/latest"><img src="https://img.shields.io/github/v/release/newkub/global_workflows?style=flat-square&color=10b981" alt="Release" /></a>
    <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square" alt="License" /></a>
    <a href="https://github.com/newkub/global_workflows/issues"><img src="https://img.shields.io/github/issues/newkub/global_workflows?style=flat-square&color=ef4444" alt="Issues" /></a>
  </p>

  <p>
    <a href="#introduction">Introduction</a> ·
    <a href="#features">Features</a> ·
    <a href="#installation">Installation</a> ·
    <a href="#usage">Usage</a> ·
    <a href="#reference">Reference</a>
  </p>
</div>

> [!TIP]
> **Quick Start**: Copy workflows to your Windsurf global workflows directory and start using them immediately with slash commands (`/workflow-name`).

> [!NOTE]
> **Coverage**: Workflows cover all aspects of development - from project setup to deployment, testing to maintenance, and everything in between.

> [!WARNING]
> **Beta**: Some workflows are in active development. Report issues via GitHub issues for rapid fixes and improvements.

> [!IMPORTANT]
> **Version**: Workflows are continuously updated. Check the latest version before using to ensure you have the most recent improvements.

> [!CAUTION]
> **Breaking Changes**: Some workflows may introduce breaking changes. Always test workflows in a non-production environment first.

<br/>

<div align="center">
  <img src="https://placehold.co/1280x720/6366f1/ffffff?text=Global+Workflows" alt="Global Workflows Banner">
</div>

## Introduction

This repository contains over 295+ standardized workflows that cover every aspect of software development, from project setup to maintenance. Each workflow is designed to be automated, repeatable, and consistent across all workspaces, ensuring uniform development practices regardless of project context.

## Why

<table border="1">
<tr>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:lightning-bolt.svg?color=%23f59e0b" width="32" height="32">
    <h3>Efficiency</h3>
    <p>Standardized workflows reduce development time by providing proven solutions to common problems.</p>
  </td>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:target.svg?color=%236366f1" width="32" height="32">
    <h3>Consistency</h3>
    <p>Uniform practices across all workspaces ensure code quality and maintainability.</p>
  </td>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:trending-up.svg?color=%2310b981" width="32" height="32">
    <h3>Scalability</h3>
    <p>Reusable workflows scale with your team and project complexity.</p>
  </td>
</tr>
</table>

## Key Concepts (What + Mental Model)

<table border="1">
<tr>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:book-multiple.svg?color=%236366f1" width="32" height="32">
    <h3>Standardized Workflows</h3>
    <p>A library of reusable, well-documented workflows that can be applied to any project type, ensuring consistency across development teams.</p>
  </td>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:autorenew.svg?color=%23f59e0b" width="32" height="32">
    <h3>Automation First</h3>
    <p>Every workflow is designed to be automated and repeatable, reducing manual effort and human error in development processes.</p>
  </td>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:earth.svg?color=%2310b981" width="32" height="32">
    <h3>Global Consistency</h3>
    <p>Workflows are shared across all workspaces, maintaining uniform development practices regardless of project context.</p>
  </td>
</tr>
</table>

## Principles (Why + Rules)

<table border="1">
<tr>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:check-circle.svg?color=%2310b981" width="32" height="32">
    <h3>Deterministic Execution</h3>
    <p>Every workflow must produce the same result when run multiple times with the same inputs. No ambiguous or subjective steps.</p>
  </td>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:layers.svg?color=%236366f1" width="32" height="32">
    <h3>Layered Architecture</h3>
    <p>Workflows follow a clear structure: Prepare → Analyze → Planning → Write → Reflex → Report. Never skip steps.</p>
  </td>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:code-tags-check.svg?color=%23ef4444" width="32" height="32">
    <h3>Code Quality First</h3>
    <p>All workflows enforce best practices for linting, formatting, type checking, and testing before any code changes.</p>
  </td>
</tr>
<tr>
  <td align="center" valign="top">
    <img src="https://api.iconify.design/mdi:git.svg?color=%23f97316" width="32" height="32">
    <h3>Git-Native Operations</h3>
    <p>Prefer git commands for file operations. Fall back to pwsh only when git is not available.</p>
  </td>
  <td align="center" valign="top">
    <img src="https://api.iconify.design/mdi:rocket-launch.svg?color=%236366f1" width="32" height="32">
    <h3>Bun-First Automation</h3>
    <p>Use Bun shell for all automation tasks. Use `bunx` instead of `npx` for package execution.</p>
  </td>
</tr>
</table>

## Features

<table border="1">
<tr>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:book-multiple.svg?color=%236366f1" width="32" height="32">
    <h3>Comprehensive Workflow Library</h3>
    <p>Over 295+ workflows covering every aspect of software development from project setup to maintenance.</p>
  </td>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:tools.svg?color=%23f59e0b" width="32" height="32">
    <h3>CLI Commands</h3>
    <p>Built-in CLI tools for workflow management including unused workflow detection and file length validation.</p>
  </td>
  <td align="center" width="33%">
    <img src="https://api.iconify.design/mdi:sync.svg?color=%2310b981" width="32" height="32">
    <h3>Workflow Interconnectivity</h3>
    <p>Workflows reference and build upon each other, creating a cohesive system with standards for creation and linking.</p>
  </td>
</tr>
<tr>
  <td align="center" valign="top">
    <img src="https://api.iconify.design/mdi:target.svg?color=%23ef4444" width="32" height="32">
    <h3>Specialized Workflows</h3>
    <p>Domain-specific workflows for advanced use cases including testing, performance, security, and documentation.</p>
  </td>
</tr>
</table>

## Quick Start

### Installation

#### Clone the Repository

```bash
git clone https://github.com/newkub/global_workflows.git
cd global_workflows
```

#### Install CLI Commands

Navigate to the commands directory and install dependencies:

```bash
cd commands
bun install
bun run build
```

This will build the CLI tools and make them available globally via npm.

#### Add to Windsurf

Copy the workflow files to your Windsurf global workflows directory:

```bash
# Windows
xcopy /E /I . "C:\Users\YourUsername\.codeium\windsurf\global_workflows"

# macOS/Linux
cp -r . ~/.codeium/windsurf/global_workflows/
```

## Usage

### 1. Usage via CLI

<table>
<tr>
<td width="50%" valign="top">
<h3><img src="https://api.iconify.design/mdi:terminal.svg?color=%236366f1" width="32" height="32" style="vertical-align: middle; margin-right: 8px;"> CLI Commands</h3>
<p>The CLI commands provide direct access to workflow management utilities for quick automation and batch processing.</p>
</td>
<td width="50%" valign="top">

```bash
# Check for unused workflows
check-unused-workflows

# Validate workflow file lengths
check-file-length
```

</td>
</tr>
</table>

### 2. Usage via Windsurf IDE

<table>
<tr>
<td width="50%" valign="top">
<h3><img src="https://api.iconify.design/mdi:chat.svg?color=%23f59e0b" width="32" height="32" style="vertical-align: middle; margin-right: 8px;"> Windsurf Integration</h3>
<p>Workflows are integrated directly into Windsurf through slash commands for seamless development workflow.</p>
</td>
<td width="50%" valign="top">

```bash
# Analyze a project
/analyze-project

# Fix errors systematically
/resolve-errors

# Deploy to Cloudflare
/deploy-to-cloudflare

# Update dependencies
/update-dependencies
```

</td>
</tr>
</table>

### 3. Usage via Programmatic API

<table>
<tr>
<td width="50%" valign="top">
<h3><img src="https://api.iconify.design/mdi:code-braces.svg?color=%2310b981" width="32" height="32" style="vertical-align: middle; margin-right: 8px;"> Programmatic API</h3>
<p>For advanced users, workflows can be executed programmatically for custom integrations and automation pipelines.</p>
</td>
<td width="50%" valign="top">

```typescript
import { executeWorkflow } from 'global-workflows-commands';

// Execute a specific workflow
await executeWorkflow('analyze-project', {
  target: './my-project',
  options: {
    deep: true
  }
});
```

</td>
</tr>
</table>

## Reference

| Topic | Description |
|-------|-------------|
| **Core Workflows** | Project analysis, code quality, development, deployment, and maintenance workflows |
| **Architecture Workflows** | Clean Architecture, DDD, Microservices, and Monorepo patterns |
| **Framework Workflows** | Vue, React, Rust, and Bun framework-specific workflows |
| **Utility Workflows** | Git, testing, and documentation utilities |
| **Configuration** | Workflow, CLI, and environment variable configuration |

### Core Workflows

| Category | Workflows |
|----------|-----------|
| **Project Analysis** | `/analyze-project`, `/deep-analyze`, `/check-architecture` |
| **Code Quality** | `/run-lint`, `/run-test`, `/run-typecheck`, `/run-verify` |
| **Development** | `/run-dev`, `/run-build`, `/run-watch-build` |
| **Deployment** | `/deploy`, `/deploy-to-cloudflare`, `/deploy-to-vercel` |
| **Maintenance** | `/update-dependencies`, `/cleanup`, `/refactor` |

### Architecture Workflows

| Pattern | Workflows |
|---------|-----------|
| **Clean Architecture** | `/clean-architecture` |
| **DDD** | `/ddd` |
| **Microservices** | `/microservices` |
| **Monorepo** | `/monorepo`, `/turborepo`, `/moonrepo` |

### Framework Workflows

| Framework | Workflows |
|-----------|-----------|
| **Vue** | `/vue`, `/nuxt`, `/vueuse` |
| **React** | `/react`, `/next` |
| **Rust** | `/rust` |
| **Bun** | `/bun`, `/bun-native` |

### Utility Workflows

| Category | Workflows |
|----------|-----------|
| **Git** | `/git-branch`, `/git-worktree`, `/git-submodule-add` |
| **Testing** | `/test-function`, `/test-e2e`, `/test-integration` |
| **Documentation** | `/update-readme`, `/update-docs` |

### Configuration

#### Workflow Configuration

Workflows can be configured through `.windsurf/` directory:

- `.windsurf/rules` - Project-specific rules
- `.windsurf/workflows/` - Custom workflows
- `.windsurf/skills/` - Custom skills

#### CLI Configuration

CLI tools use standard configuration files:

- `biome.jsonc` - Linting and formatting rules
- `tsconfig.json` - TypeScript configuration
- `vitest.config.ts` - Test configuration

#### Environment Variables

Optional environment variables for customization:

```bash
# Set custom workflow directory
export WINDSURF_WORKFLOWS_PATH="/path/to/workflows"

# Enable verbose logging
export WINDSURF_VERBOSE=true
```

## Release

<details>
<summary><strong>v1.0.0</strong> (2024-01-15)</summary>

<table>
<tr>
<td width="50%" valign="top">
<img src="https://api.iconify.design/mdi:rocket-launch.svg?color=%236366f1" width="32" height="32">
<h3>Initial Release</h3>
<p>First stable release with comprehensive workflow coverage for all development aspects.</p>
</td>
<td width="50%" valign="top">

- 295+ standardized workflows
- Complete project structure
- Full documentation
- Integration guides

</td>
</tr>
</table>

</details>

<details>
<summary><strong>v0.9.0</strong> (2024-01-10)</summary>

<table>
<tr>
<td width="50%" valign="top">
<img src="https://api.iconify.design/mdi:handshake.svg?color=%23f59e0b" width="32" height="32">
<h3>Contribution Guide</h3>
<p>Added comprehensive contribution guidelines with numbered steps for easier onboarding.</p>
</td>
<td width="50%" valign="top">

- Contribution accordion with numbered steps
- Setup, Development, Submit PR, Sync workflows
- Git workflow documentation
- PR template guidelines

</td>
</tr>
</table>

</details>

<details>
<summary><strong>v0.8.0</strong> (2024-01-05)</summary>

<table>
<tr>
<td width="50%" valign="top">
<img src="https://api.iconify.design/mdi:table-column.svg?color=%2310b981" width="32" height="32">
<h3>Usage Layout</h3>
<p>Redesigned Usage section with 2-column layout and inline icons for better readability.</p>
</td>
<td width="50%" valign="top">

- 2-column table layout
- Inline icons with titles
- Visual code examples
- Improved accessibility

</td>
</tr>
</table>

</details>

<details>
<summary><strong>v0.7.0</strong> (2024-01-01)</summary>

<table>
<tr>
<td width="50%" valign="top">
<img src="https://api.iconify.design/mdi:alert-circle.svg?color=%23ef4444" width="32" height="32">
<h3>Enhanced Callouts</h3>
<p>Added IMPORTANT and CAUTION callouts to hero section for better information hierarchy.</p>
</td>
<td width="50%" valign="top">

- [!IMPORTANT] callout for version info
- [!CAUTION] callout for breaking changes
- Improved information hierarchy
- Better user guidance

</td>
</tr>
</table>

</details>

<details>
<summary><strong>v0.6.0</strong> (2023-12-28)</summary>

<table>
<tr>
<td width="50%" valign="top">
<img src="https://api.iconify.design/mdi:image-multiple.svg?color=%238b5cf6" width="32" height="32">
<h3>Hero Section</h3>
<p>Restructured README with Hero Section, Callouts, and Banner Image for professional presentation.</p>
</td>
<td width="50%" valign="top">

- Hero Section with logo and badges
- 5 types of callouts
- 16:9 banner image
- Improved visual hierarchy

</td>
</tr>
</table>

</details>

## MIT License

[LICENSE.md](LICENSE.md)

- Free to use
- Modify
- Distribute

## Contribution

### 1. Setup

1. Fork the repository
2. Clone your fork locally

```bash
git clone https://github.com/YOUR_USERNAME/global_workflows.git
cd global_workflows
```

3. Add upstream remote

```bash
git remote add upstream https://github.com/newkub/global_workflows.git
```

### 2. Development

1. Create a new branch for your workflow

```bash
git checkout -b feature/my-workflow
```

2. Follow `/write-windsurf-global-workflows` for workflow structure
3. Follow `/content-quality` for content standards
4. Test workflows thoroughly before submitting
5. Commit your changes

```bash
git add .
git commit -m "Add: my-workflow description"
```

### 3. Submit PR

1. Push your branch to your fork

```bash
git push origin feature/my-workflow
```

2. Create a Pull Request on GitHub
3. Update this README with new workflow descriptions
4. Wait for review and merge

### 4. Sync

1. After merge, sync your fork with upstream

```bash
git checkout main
git fetch upstream
git merge upstream/main
git push origin main
```

