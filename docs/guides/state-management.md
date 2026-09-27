# State Management

`flueco_state_management` is an optional package built on Provider. It exports `ViewModel`, `StateNotifier`, `ViewState`, `StateDataProvider`, and helper APIs such as `SafeZoneResultMixin` and `Computation`. It is separate from the service-provider/container lifecycle: provide view models to widgets with Provider's widget APIs.

## Model observable state

`ViewState` is an Equatable-based base class. Make state immutable and include all fields that determine equality; `StateNotifier` only notifies when the new value differs from the current value by `==`.

```dart
class CounterState extends ViewState {
 final int count;

 const CounterState(this.count);

 @override
 List<Object?> get props => <Object?>[count];
}

class CounterViewModel extends ViewModel<CounterState> {
 CounterViewModel() : super(const CounterState(0));

 void increment() => setState(CounterState(state.count + 1));
}
```

`setState` is protected, so expose intent-specific methods from the view model rather than allowing widgets to replace state arbitrarily. `ViewModel.read`, `watch`, and `select` delegate to the configured `StateDataProvider` (Provider by default). Use `read` for one-time access/actions, `watch` when the widget depends on the whole model, and `select` when it depends on a projection.

Provide the model in the widget subtree with Provider, for example `ChangeNotifierProvider(create: (_) => CounterViewModel(), child: ...)`. Let the provider own and dispose instances it creates. Avoid mutating a state object in place: that can make equality-based change detection miss updates.

`SafeZoneResultMixin` and `Computation` are additional helpers; consult their API when using them rather than treating them as required parts of every view model. This package is not re-exported from `flueco`; add it as a separate dependency. See the [`flueco_state_management` reference](../reference/packages/flueco_state_management.md) for its public exports.
