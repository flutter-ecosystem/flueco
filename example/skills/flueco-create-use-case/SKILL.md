---
name: flueco-create-use-case
description: Add a domain use case to the Flueco example using its UseCase contract and Injectable wiring. Use when implementing a user or business action that coordinates application behavior.
---

# Create a use case

Use cases represent an application/domain action, not a screen or a data source. The example defines `UseCase<R>` in `lib/foundation/abstractions/use_case.dart`; implementations expose `Future<R> execute()` and are registered through `lib/bootstrap/injections/domain.module.dart`.

## Workflow

1. Search existing use cases and callers first. Reuse a use case if it already represents the action.
2. Add the implementation under `lib/domain/use_cases/<feature>/<name>.usecase.dart`, following nearby naming and constructor-injection style.
3. Implement `UseCase<R>` and put the action's orchestration in `execute()`. Keep UI widgets, BuildContext, and concrete router types out of the use case.
4. Inject the smallest set of required collaborators through the constructor. Depend on domain contracts where available instead of concrete infrastructure classes.
5. If the use case needs mutable input before execution, follow the existing pattern only when necessary; prefer explicit immutable input or method arguments when that better fits the action and nearby APIs.
6. Register the use case in `DomainModule` with the appropriate Injectable scope. Regenerate dependency configuration; do not edit generated `.config.dart` files by hand.
7. Add focused tests for success, invalid input, and collaborator failures.

## Example-specific guidance

`AuthUseCase` is the nearest reference for `UseCase<void>`, constructor injection, and async orchestration. It currently coordinates authentication, a Flueco dialog service, and a domain navigation contract. Preserve contract-based navigation; do not copy a dependency on `AppRouter` into domain code.

## Validate

From `example/`, run the relevant tests and `flutter analyze`. If registrations changed, run the configured build_runner command and confirm generated Injectable output resolves the use case.
