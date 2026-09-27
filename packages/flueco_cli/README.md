# Flueco CLI

Create a Flutter application from the Flueco example project. The CLI downloads
the `example/` directory from the Flueco GitHub repository and uses Flutter's
own project generator for platform files and project configuration.

## Usage

```shell
dart pub global activate flueco_cli
flueco create my_app --org com.example --platforms android,ios,web
```

Flutter `create` options are forwarded to `flutter create`. For an interactive
setup, omit the values you want prompted for and pass `--interactive`:

```shell
flueco create --interactive
```

The CLI requires Git and Flutter to be available on `PATH`. Use `--no-pub` to
skip resolving the generated application's dependencies.
