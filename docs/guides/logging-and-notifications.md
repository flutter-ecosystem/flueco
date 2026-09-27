# Logging and Notifications

`flueco_core` provides `LogRegistry` and `NotificationRegistry` abstractions with handler and message types. The `flueco` package supplies handlers through app services, including `LoggerService`, `ToastService`, `DialogService`, and `ModalService`.

## Logging

Use `LoggerService` for direct application logs (`debug`, `info`, `warning`, `error`, and `verbose`). Its default enablement follows debug mode unless explicitly configured. For cross-package logs, use the `LogRegistry`; handlers can route actions such as warning or error to one or more configured channels. The bundle's default routing sends critical/error/warning to the logger, while informational/debug actions may also go to toast handlers according to the registry configuration.

Do not log access tokens, passwords, personal data, or raw request bodies by default. Include error and stack trace details only where they are safe to retain and useful to operators.

## Notifications and dialogs

Use `ToastService.show` for transient user feedback. `DialogService` supports generic dialogs, alerts, confirmations, prompts, and hiding the current dialog. Confirmation/prompt operations can return `null` when no navigator context is available or the interaction is dismissed without a result. Notification registry actions can be routed to the dialog handler, but modal dialogs are disruptive; reserve them for actions that need user attention or a decision.

The bundle's kernel configures default registries and connects the app services to them. These UI services depend on navigator services being configured and available in the widget tree; the `Flueco` root also installs toast and messaging wrappers. Applications can supply custom registries or handlers when they need different routing behavior. Use registry APIs for cross-cutting channel routing and app services for direct user-facing operations.

Dialog components include alert, confirm, loading, and prompt dialogs. See [Events and registries](../concepts/events-and-registries.md), [`flueco`](../reference/packages/flueco.md), and [`flueco_core`](../reference/packages/flueco_core.md).
