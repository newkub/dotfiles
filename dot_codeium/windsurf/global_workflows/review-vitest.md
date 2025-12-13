---
description: review-vitest
auto_execution_mode: 1
---

Keep test files close to source code (recommended)

But beware of duplicate folder structure.

Incorrect example:
src/components/button/__tests__/button.test.ts and tests/components/button.test.ts

Problem: Duplicate tests, coverage tracking becomes difficult.

Avoid overly deep folders

Deep folder structures → long import paths, confusing.

Use index/barrel files to consolidate exports for large modules.

Naming consistency

Test files should end with .test.ts or .spec.ts.

Problem: ButtonTests.ts → some Vitest configs may not pick up the file automatically.

For mocks / fixtures → use clear folders like __mocks__ or __fixtures__.

Separate unit / integration / e2e tests

Unit tests should be close to the code.

Integration / e2e tests should be in separate folders, e.g., tests/integration/, tests/e2e/.

Problem: Mixing all tests in one folder → slow tests, side effects across tests.

Shared helpers / utils

Do not scatter helper functions across test files.

Create tests/utils/ or __tests__/helpers.ts.

Problem: Duplicate code, hard to maintain.

Avoid circular imports

Test file importing a module that imports the test file → Vitest will error or cause stack overflow.

Check the dependency tree before adding tests.

Environment-specific files

If using Node + DOM (jsdom), do not mix test files of both environments in the same folder.

Vitest will use the environment based on config → tests may fail.

Mock data / fixtures structure

Separate fixtures into a folder like __fixtures__/.

Avoid inline mock data repeated across multiple tests → hard to maintain, duplicates.