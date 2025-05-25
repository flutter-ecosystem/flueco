# Contributing to Flueco

Thank you for your interest in contributing to Flueco! We welcome contributions from the community and appreciate your efforts to make this project better.

## How to Contribute

### 1. Fork and Clone

- Fork the repository to your own GitHub account.
- Clone your fork to your local machine.

### 2. Branching

- Create a new branch for your feature or bugfix:

  ```sh
  git checkout -b feat/your-feature-name
  ```

- Use clear and descriptive branch names (e.g., `fix/auth-bug`, `feat/add-logout-usecase`).

- Your branch should be based on the default branch.

- Your branch name should match like `[prefix]/[issue-number]/[short-description]` with the following prefixes:
  - `feat/` for new features
  - `fix/` for bug fixes
  - `chore/` for maintenance tasks
  - `docs/` for documentation changes
  - Others conventional commit types allowed.

### 3. Code Style

- Follow the Dart and Flutter style guides.
- Run `dart format .` before committing.
- Ensure your code passes all static analysis (`dart analyze`).

### 4. Commit Messages

- Use clear, conventional commit messages:
  - `feat(flueco): add authentication manager`
  - `fix(flueco): correct user state on logout`
  - `chore(flueco): update dependencies`
- Reference issues or pull requests when relevant.
- Use the following format for commit messages:

  ```text
  <type>(<scope>): <subject>

  <body>
  ```

  - **type**: The type of change (e.g., feat, fix, chore)
  - **scope**: The area of the codebase affected (e.g., flueco_auth, flueco_core)
  - **subject**: A brief description of the change
  - **body**: Optional detailed description.

### 5. Testing

- Add or update tests for your changes.
- Run all tests locally before submitting:

  ```sh
  flutter test
  ```

- Ensure your changes do not break existing functionality.

### 6. Pull Requests

- Submit a pull request to the default branch.
- Provide a clear description of your changes and the motivation behind them.
- Link related issues or discussions.
- Be responsive to feedback and requested changes.

### 7. Documentation

- Update documentation and README files as needed.
- Add code comments where appropriate.

### 8. Code of Conduct

- Be respectful and inclusive in all interactions.
- Follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## Project Structure

- `packages/` — Core and feature packages (e.g., `flueco_auth`, `flueco_core`)
- `example/` — Example application demonstrating usage
- `doc/` — Project documentation

## Additional Notes

- Use [Melos](https://melos.invertase.dev/) for managing packages in the monorepo.
- If you are unsure about a change, open an issue or discussion first.

---

Thank you for helping make Flueco better!
