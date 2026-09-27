# Installation

Flueco packages currently declare Dart SDK `>=3.6.0 <4.0.0`; Flutter packages also declare Flutter `>=3.0.0`. Check the individual package's `pubspec.yaml` and the [compatibility page](../reference/compatibility.md) for current constraints.

## Use the app bundle

```shell
flutter pub add flueco
```

The `flueco` library re-exports core and selected integrations. Authentication and state management remain separate packages.

## Select packages individually

For an app assembled from individual packages, add `flueco_core` and the adapters/features you use. For example, add `flueco_core` with `flueco_get_it` for the container and then the service adapters required by your app. Use `flutter pub add <package-name>` for each dependency.

| Need | Packages to evaluate |
| --- | --- |
| Bundle defaults and app-facing services/widgets | `flueco` |
| Core contracts without the app bundle | `flueco_core` |
| GetIt-backed service container | `flueco_get_it` |
| Dio-backed HTTP | `flueco_dio` |
| AutoRoute-backed navigation | `flueco_auto_route` |
| Preferences or Hive storage | `flueco_shared_preferences` or `flueco_hive` |
| Authentication or Provider-based view models | `flueco_auth` plus a strategy, or `flueco_state_management` |

Adding a package does not automatically register its services. Follow its reference page for required instances/configuration and include its provider at the composition root. Avoid registering competing implementations for the same contract unless you intentionally use named registrations or another explicit selection strategy.

See the [package catalog](../reference/packages.md) for roles and the [first-app guide](first-app.md) for bootstrap composition. To scaffold an app from the repository example, see [Create an application](create-an-app.md).
