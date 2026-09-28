# `flueco_state_management`

Optional Provider-based state-management APIs for Flutter. Public exports include Provider, `StateDataProvider`, `StateNotifier`, `ViewModel`, `ViewState`, `SafeZoneResultMixin`, and `Computation`.

`ViewState` uses Equatable semantics; `StateNotifier` stores a value and notifies only when equality changes. `ViewModel<S>` specializes it for a `ViewState`, exposes context helpers to `read`, `watch`, or `select`, and mixes in safe-zone result helpers. Provide view models in the widget tree with Provider; this package does not register view models through the Flueco service-provider kernel.

`StateDataProvider.instance` is a replaceable global adapter with a Provider-backed default. `StateNotifier.mock`/`ViewModel.mock` also keep static mock state, so reset it between tests. This package is not exported by the `flueco` bundle; add it separately. See the [State management guide](../../guides/state-management.md) and package [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_state_management/README.md).
