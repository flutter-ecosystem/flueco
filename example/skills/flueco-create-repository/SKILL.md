---
name: flueco-create-repository
description: Add a repository boundary and implementation to the Flueco example for feature data access. Use when a feature needs to coordinate remote or local data sources behind a stable API.
---

# Create a repository

The example currently has data sources under `lib/data/sources/` but no repository layer. Introduce a repository when it gives domain/application code a stable feature-oriented API or combines sources; do not add one just to forward every source method unchanged.

## Workflow

1. Identify the feature's data needs and existing sources under `lib/data/sources/`. Reuse current HTTP clients, DB wrappers, and models where appropriate.
2. Define the repository contract in the domain layer, preferably under `lib/domain/repositories/<feature>_repository.dart`. Keep plugin and transport types out of the contract; use domain entities and feature-level inputs/results.
3. Implement the contract under `lib/data/repositories/`, using the existing remote/local sources and translating transport/storage models to domain entities at this boundary.
4. Make failure behavior explicit. Preserve useful errors or map them to the app's established failure conventions; do not silently convert failed requests into success-shaped empty values.
5. Register the implementation in `lib/bootstrap/injections/data.module.dart` with Injectable. Bind the domain contract to that implementation using the pattern supported by the installed Injectable version.
6. Add repository tests for source success, mapping, missing/local data, and failures. Prefer fakes or mocks at the source boundary.

## Guardrails

- Keep business orchestration in use cases and persistence/network details in data sources or repository implementations.
- Do not expose Dio, Hive boxes, generated Retrofit clients, or plugin models through a domain repository contract.
- Do not modify generated Injectable files by hand; regenerate them after module changes.

## Validate

From `example/`, run repository tests, `flutter analyze`, and the configured build_runner command when registration changes. Confirm the domain contract resolves to the data implementation in the generated dependency graph.
