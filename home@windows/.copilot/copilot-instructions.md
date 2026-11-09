# Global Settings
autopilot: on
permission allow: on

# Custom Slash Commands

## /run-lint

When you invoke `/run-lint`, perform the following:

1. Detect the project type and find the appropriate lint command:
   - **Node.js/npm projects**: Run `npm run lint` or `npx eslint .` or `npm run lint:fix`
   - **Python projects**: Run `ruff check .` or `flake8 .` or `pylint .`
   - **Go projects**: Run `golangci-lint run ./...` or `go vet ./...`
   - **Rust projects**: Run `cargo clippy` or `cargo fmt --check`
   - **Other projects**: Try common lint tools available in PATH

2. Execute the lint command and report results

3. If lint passes without errors, confirm success

4. If lint fails, show the errors and offer to fix them if the tool supports auto-fix (e.g., `eslint --fix`, `ruff check --fix`)