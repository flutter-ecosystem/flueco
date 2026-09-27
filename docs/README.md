<p align="center">
 <img src="../logo-flueco.jpg" alt="Flueco logo" width="160" />
</p>

# Flueco Documentation

Flueco is a modular Flutter ecosystem built around shared service abstractions and replaceable implementations. These docs cover the architecture, onboarding path, task guides, and public package surface. If you are new to the project, read the [ecosystem overview](overview/ecosystem.md) first; it explains which parts are foundation, bundle, adapters, and optional features.

## Start here

- [Ecosystem overview](overview/ecosystem.md)
- [Install Flueco](getting-started/installation.md)
- [Create an application](getting-started/create-an-app.md)
- [Bootstrap your first application](getting-started/first-app.md)

## Learn the foundations

- [Architecture](overview/architecture.md)
- [Kernel and bootstrap](concepts/kernel-and-bootstrap.md)
- [Service providers](concepts/service-providers.md)
- [Dependency injection](concepts/dependency-injection.md)
- [Events and registries](concepts/events-and-registries.md)

The foundations explain how the app composes services. They are useful even when using the `flueco` bundle because adapters still need to be selected and configured explicitly.

## Guides and reference

- Pick a task-oriented guide: [HTTP](guides/http.md), [storage](guides/storage.md), [routing](guides/routing.md), [authentication](guides/authentication.md), [state management](guides/state-management.md), [theming](guides/theming.md), [logging and notifications](guides/logging-and-notifications.md), or [testing](guides/testing.md).
- Browse the [package catalog](reference/packages.md) for package roles and setup requirements.
- Check [compatibility](reference/compatibility.md) before choosing integrations.

## Learning paths

- **Build an app:** [Install](getting-started/installation.md) → [create a project](getting-started/create-an-app.md) or [bootstrap manually](getting-started/first-app.md) → [architecture](overview/architecture.md).
- **Add an integration:** choose a capability guide → check its package reference for prerequisites → register the provider in the composition root.
- **Understand a package:** use the [catalog](reference/packages.md), then follow the links from its reference page to concepts and guides.

The [`example/`](../example/) directory is the source for a complete sample application and is particularly useful for seeing provider composition in context. Package pages describe intended usage and public exports; generated Dart API documentation can complement them with full signatures. Contributions should keep examples aligned with the exported package APIs and verify documentation links after moving pages.
