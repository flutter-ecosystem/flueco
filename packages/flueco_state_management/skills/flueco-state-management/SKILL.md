---
name: flueco-state-management
description: Build Provider-backed Flutter features with Flueco ViewModel, ViewState, and StateNotifier. Use when modeling UI state or testing view-model updates.
---

# Build a Provider-backed view model

`flueco_state_management` is a Provider-based UI state package. It is separate from the Flueco service-provider kernel and is not re-exported by `flueco`.

## Workflow

1. Define an immutable `ViewState` and include every state field that determines equality in its Equatable `props`.
2. Extend `ViewModel<State>` and expose intent-specific methods that update state; do not let widgets replace state arbitrarily.
3. Provide the view model in the widget tree using Provider APIs. Let the provider own and dispose instances it creates.
4. In widgets, use `read` for one-time actions, `watch` when the whole model affects rendering, and `select` for a specific projection.
5. Use `SafeZoneResultMixin` or `Computation` only when their APIs fit the feature; they are optional helpers.
6. In tests, isolate or reset static mock state used by `StateNotifier.mock` and `ViewModel.mock`.

## Guardrails

- Mutating a state object in place can prevent equality-based change detection from notifying listeners.
- Do not register view models as kernel service providers; provide them through the widget tree.
- Keep dependency injection and UI state ownership distinct unless the app has an explicit integration pattern.

## Validate

Test initial state, each intent method, equality-driven notifications, selected widget rebuilds, and disposal of provider-owned instances.
