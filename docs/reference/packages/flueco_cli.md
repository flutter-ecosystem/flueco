# `flueco_cli`

The `flueco` executable creates a Flutter application from the repository example and delegates platform/project generation to Flutter's `create` command. Install with `dart pub global activate flueco_cli`, then run `flueco create <output-directory> [Flutter create options]`.

## Options and behavior

The CLI supports `--interactive` for prompted project values, forwards Flutter create options (including options with values), and supports `--no-pub` to skip dependency resolution. Use `--pub` to retain dependency resolution. Run `flueco create --help` for the command's option list.

The command obtains the `example/` project from the Flueco repository and uses Flutter to generate platform files. Git and Flutter must be available on `PATH`. Generated projects inherit the example's structure and should be reviewed for example-specific configuration, API endpoints, identifiers, and credentials before release.

This package is for project creation, not a runtime framework dependency. If the example is not an appropriate starting point, create a standard Flutter project and add the Flueco packages you need.

See [Flueco CLI](../../getting-started/create-an-app.md) and the package [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_cli/README.md).
