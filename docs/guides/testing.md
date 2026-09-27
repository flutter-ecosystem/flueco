# Testing

Flueco's abstractions make infrastructure replaceable at the container boundary. Test application behavior through core contracts and keep plugin/network behavior in narrower adapter integration tests.

## Unit tests

Pass fakes directly to application services where possible. If testing provider composition, create the same registrations the service expects and await bootstrap. Do not rely on provider iteration order; include real `dependsOn()` prerequisites. Fake `HttpClient`, `LocalStorage`, `SecureStorage`, and `EventHandler` at their contract boundary to avoid network calls, persistence, and plugin setup in unit tests.

## Widget tests

Wrap widgets with the providers/inherited widgets they consume and use Flutter's widget-test utilities. If testing the bundle's root `Flueco` widget, provide the required services such as `Messaging` and a navigator/router because the wrapper installs lifecycle and toast behavior. For `flueco_state_management`, provide view models with Provider and reset static `ViewModel.mock` state after tests that use it.

## Integration tests

Test adapter behavior separately where it matters: persistence across app restarts, HTTP request configuration, route integration, or platform plugin behavior. Use controlled test servers/data and avoid production credentials. Dispose resources and reset shared/static state between tests.

Adapter packages have their own tests and may require adapter-specific fakes. Consult the package tests and [package catalog](../reference/packages.md) for the implementation under test; exact test helpers vary by package.
