# Project Review Workflow

This workflow helps review projects to ensure they follow best practices and have proper structure.

## Package.json Requirements

### Required Fields
- **name**: Project name (required)
- **description**: Project description (required)
- **scripts**: Build and development scripts (required)
- **type**: Module type (required)

### Type Requirements
- **type**: Must be set to `"module"` for ESM support

### Required Scripts
Every package.json should have these essential scripts:

#### Development Script
```json
"dev": "bun run build && bun run --watch src/index.ts"
```
- Enables development mode with hot reload
- Builds project and watches for changes

#### Build Script
```json
"build": "tsdown --exports && bun link"
```
- Builds the project for production
- Creates distribution files
- Links the package locally

#### Code Quality Scripts
```json
"lint": "biome lint ."
"format": "biome format ."
```
- Lints code for issues
- Formats code consistently

## Project Structure

A well-structured project should have:

### Source Code
- `src/` directory with TypeScript files
- `test/` directory with test files
- `dist/` directory (auto-generated)

### Configuration Files
- `package.json` - Project configuration
- `tsconfig.json` - TypeScript configuration
- `biome.json` - Code formatting and linting
- `README.md` - Project documentation

## Framework-Specific Requirements

### Nuxt.js Projects
- **nuxt.config.ts** - Nuxt configuration file
- **pages/** directory for file-based routing
- **components/** directory for Vue components
- **composables/** directory for reactive logic
- **layouts/** directory for page layouts
- **middleware/** directory for route middleware
- **plugins/** directory for Vue plugins

### Vite Projects
- **vite.config.ts** - Vite configuration file
- **index.html** - Entry HTML file
- **public/** directory for static assets
- **src/** directory for source code
- **dist/** directory for built output

### TypeScript Projects
- **tsconfig.json** - TypeScript configuration
- **@types/** dependencies for type definitions
- **src/**/*.ts** files with proper typing
- **Strict mode enabled** in tsconfig.json
- **ESNext target** for modern JavaScript features

## Quality Checks

### Code Quality
- ✅ No linting errors
- ✅ Consistent code formatting
- ✅ Proper TypeScript types
- ✅ Test coverage

### Dependencies
- ✅ Up-to-date dependencies
- ✅ No security vulnerabilities
- ✅ Proper peer dependencies

### Documentation
- ✅ Clear README with usage examples
- ✅ API documentation for public methods
- ✅ Installation and setup instructions

## Best Practices

### Package.json
- Use descriptive names and descriptions
- Include proper keywords for discoverability
- Specify correct license information
- Include repository and issue tracker links

### Code Organization
- Separate source and test files
- Use consistent naming conventions
- Export only public APIs
- Include proper error handling

### Development Workflow
- Use conventional commits
- Run tests before committing
- Format code before pushing
- Update dependencies regularly

## Usage

Run this workflow to review your project structure and ensure it follows best practices.