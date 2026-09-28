# AI Agent Skills

Flueco packages include Agent Skills: concise instructions, examples, and guardrails that help AI coding agents use Flueco APIs and architecture correctly. Package skills live under each package's top-level `skills/` directory and are included when the package is published. The example app also has repository-specific skills for common feature-development tasks.

Skills complement the package references and guides; they do not replace API documentation, tests, or engineering review. A skill is most useful when a request matches the workflow it describes.

## Install Package Skills

From a Flutter app that depends on Flueco packages, run the `package:skills` CLI:

```shell
dart run skills@ get
```

The command scans direct dependencies and lets you select available skills. Add the package you need as a direct dependency first. To install all skills from a particular package, use `-p`:

```shell
dart run skills@ get -p flueco_dio
```

To install one skill, specify both the package and exact skill name:

```shell
dart run skills@ get -p flueco_core -s flueco-core-custom-router
```

To install all available dependency skills without a prompt, use `dart run skills@ get --all`. Run `dart run skills@ list` to inspect managed skills, and rerun `dart run skills@ get` to update them after changing package versions. The CLI installs skills into the directory used by the selected AI coding agent, commonly `.agents/skills/`.

After installation, describe the task normally or name the relevant skill in your request, for example: “Use the Flueco Dio skill to configure the HTTP client and register its provider.” The agent can load the skill's `SKILL.md` when that workflow is relevant.

## Package Skills

The following skills ship with package dependencies. Each link opens the source `SKILL.md` in this repository.

| Package | Skill | Use it for |
| --- | --- | --- |
| [`flueco`](../reference/packages/flueco.md) | [flueco-app](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco/skills/flueco-app/SKILL.md) | Compose an app with the bundle, bootstrap providers, and use app-facing services. |
| [`flueco_core`](../reference/packages/flueco_core.md) | [flueco-core](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_core/skills/flueco-core/SKILL.md) | Compose with core contracts, providers, lifecycle, registries, and events. |
| `flueco_cli` | [flueco-cli](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_cli/skills/flueco-cli/SKILL.md) | Scaffold and prepare an app generated from the repository example. |
| `flueco_get_it` | [flueco-get-it](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_get_it/skills/flueco-get-it/SKILL.md) | Configure the GetIt service container and provider registrations. |
| `flueco_dio` | [flueco-dio](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_dio/skills/flueco-dio/SKILL.md) | Configure the Dio HTTP adapter, options, and interceptors. |
| `flueco_auto_route` | [flueco-auto-route](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_auto_route/skills/flueco-auto-route/SKILL.md) | Connect an AutoRoute router and generate routes. |
| `flueco_messaging` | [flueco-messaging](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_messaging/skills/flueco-messaging/SKILL.md) | Connect the messaging instance to Flueco event handling. |
| `flueco_hive` | [flueco-hive](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_hive/skills/flueco-hive/SKILL.md) | Configure Hive secure storage and review key handling. |
| `flueco_shared_preferences` | [flueco-shared-preferences](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_shared_preferences/skills/flueco-shared-preferences/SKILL.md) | Use shared preferences through the `LocalStorage` contract. |
| `flueco_theming` | [flueco-theming](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_theming/skills/flueco-theming/SKILL.md) | Configure appearances and consume theme updates. |
| `flueco_auth` | [flueco-auth](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_auth/skills/flueco-auth/SKILL.md) | Compose authentication providers and manage authentication lifecycle. |
| `flueco_auth_basic` | [flueco-auth-basic](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_auth_basic/skills/flueco-auth-basic/SKILL.md) | Configure HTTP Basic authentication and protect credentials. |
| `flueco_auth_token` | [flueco-auth-token](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_auth_token/skills/flueco-auth-token/SKILL.md) | Configure token authentication, storage, expiry, and refresh policy. |
| `flueco_auth_dio_interceptor` | [flueco-auth-dio-interceptor](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_auth_dio_interceptor/skills/flueco-auth-dio-interceptor/SKILL.md) | Wire auth lifecycle and safely scope credentials on Dio requests. |
| `flueco_state_management` | [flueco-state-management](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_state_management/skills/flueco-state-management/SKILL.md) | Build Provider-backed view models and test state updates. |

### Custom `flueco_core` integrations

These skills guide the creation of app-owned adapters. Each recommends putting the implementation and provider in a separate internal package that depends on `flueco_core`, then adding that package to the app:

- [flueco-core-custom-service-provider](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_core/skills/flueco-core-custom-service-provider/SKILL.md): create a provider for app-owned services.
- [flueco-core-custom-http-client](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_core/skills/flueco-core-custom-http-client/SKILL.md): implement `HttpClient` and its provider.
- [flueco-core-custom-local-storage](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_core/skills/flueco-core-custom-local-storage/SKILL.md): implement `LocalStorage` and its provider.
- [flueco-core-custom-secure-storage](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_core/skills/flueco-core-custom-secure-storage/SKILL.md): implement `SecureStorage` and its provider.
- [flueco-core-custom-router](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_core/skills/flueco-core-custom-router/SKILL.md): implement `Router` and `NavigatorKeyProvider` with a router provider.

## Example App Skills

The example's six skills are repository-specific workflows stored in `example/skills/`. They are not distributed by a published Flueco package. When working in this repository, ask the agent to follow the relevant skill by name or path. To use one in another project, copy it into that agent's recognized project skills directory and adapt its example-specific paths.

- [flueco-create-use-case](https://github.com/flutter-ecosystem/flueco/blob/main/example/skills/flueco-create-use-case/SKILL.md): add and register a domain use case.
- [flueco-create-repository](https://github.com/flutter-ecosystem/flueco/blob/main/example/skills/flueco-create-repository/SKILL.md): define a repository boundary and data implementation.
- [flueco-create-view-viewmodel](https://github.com/flutter-ecosystem/flueco/blob/main/example/skills/flueco-create-view-viewmodel/SKILL.md): add a Provider-backed view and view model.
- [flueco-create-route](https://github.com/flutter-ecosystem/flueco/blob/main/example/skills/flueco-create-route/SKILL.md): add a route using the router currently configured by the app.
- [flueco-create-application-service](https://github.com/flutter-ecosystem/flueco/blob/main/example/skills/flueco-create-application-service/SKILL.md): choose and create either a focused service or a component manager.
- [flueco-create-feature](https://github.com/flutter-ecosystem/flueco/blob/main/example/skills/flueco-create-feature/SKILL.md): build an end-to-end feature slice using only the layers it needs.

## Authoring and Publishing

Package skills must live under `<package-root>/skills/<package-name>-<skill-name>/SKILL.md`. The skill directory prefix must match the package name; package names with underscores may use hyphens in the prefix. For example, `flueco_core` skills use the `flueco-core-` prefix. Keep the skill focused, provide prescriptive guidance, and update it when package APIs or recommendations change.

Before publishing, run `dart pub publish --dry-run` from the package directory and verify the `skills/` files appear in the archive. For an end-to-end install check, use a consumer app with a path dependency and run `dart run skills@ get` there.

See Dart's guides to [package skills](https://dart.dev/ai/package-skills) and [shipping skills with packages](https://dart.dev/tools/pub/package-skills) for the full workflow and Agent Skills specification links.
