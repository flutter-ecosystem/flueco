# Compatibility

Compatibility constraints are declared independently by each package's `pubspec.yaml`. In the current repository manifests, the framework libraries declare Dart SDK `>=3.6.0 <4.0.0`; Flutter libraries also declare Flutter `>=3.0.0`. `flueco_cli` declares a Dart SDK constraint and is a command-line tool rather than a Flutter library. Treat the manifests for the exact release you install as authoritative.

Adapter packages depend on upstream libraries such as Dio, AutoRoute, GetIt, Hive CE, `messaging`, and `shared_preferences`. Their constraints are managed independently in each package manifest, so a compatible Flueco release does not imply that every version of every upstream package is compatible. Resolve dependencies with Flutter or Dart Pub and inspect the lockfile's selected versions when troubleshooting.

This repository is a Melos workspace; workspace resolution can differ from installing published packages into an application. For release issues, reproduce with the published package constraints rather than assuming workspace overrides apply. Update this page when manifests or release support policy change. See the [package catalog](packages.md) for package links.
