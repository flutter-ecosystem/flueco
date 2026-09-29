# Welcome

This is the example application for the Flueco package. It demonstrates how to use the package and provides a starting point for your own applications.

To understand the architecture of this application, please read [the documentation](https://flueco.dev/getting-started/create-an-app/#understand-the-generated-structure).

# Code Generation

### Localizations

The localizations use the `easy_localization` package. The translations are located inside the `assets/translations` directory. To generate the localization files, run the following command:

For the keys file:

```bash
flutter pub run easy_localization:generate --output-dir=lib/foundation/localizations --output-file=locale_keys.g.dart --format=keys --source-dir=assets/translations
```

For the translations file:

```bash
flutter pub run easy_localization:generate --output-dir=lib/foundation/localizations --output-file=localizations.g.dart --format=json --source-dir=assets/translations
```

Or you can use the VSCode build extensions through the command `ctrl+alt+b` or `cmd+alt+b`.

### Assets

The assets generation are available through the `flutter_gen` commands.

### Build runner

For others generations tools, you can use the `build_runner` command

```bash
dart run build_runner build
```
