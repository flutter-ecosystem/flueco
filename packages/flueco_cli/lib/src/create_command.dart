import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

const usage = '''
Flueco CLI

Usage:
  flueco create [flutter create options] <output-directory> [--interactive]

Creates a Flutter application from the Flueco example. Flutter create options
are forwarded to Flutter. Use --interactive to prompt for common project values.
Run "flueco create --help" to see Flutter's create options.
''';

const _flutterValueOptions = <String>{
  '--android-language',
  '-a',
  '--description',
  '--org',
  '--platforms',
  '--project-name',
  '--template',
  '-t',
};

class CreateArguments {
  const CreateArguments({
    required this.outputDirectory,
    required this.flutterArguments,
    required this.interactive,
    required this.runPub,
  });

  final String? outputDirectory;
  final List<String> flutterArguments;
  final bool interactive;
  final bool runPub;
}

CreateArguments parseCreateArguments(List<String> arguments) {
  final flutterArguments = <String>[];
  String? outputDirectory;
  var interactive = false;
  var runPub = true;
  var skipNext = false;

  for (final argument in arguments) {
    if (skipNext) {
      flutterArguments.add(argument);
      skipNext = false;
      continue;
    }

    if (argument == '--interactive') {
      interactive = true;
      continue;
    }
    if (argument == '--no-pub') {
      runPub = false;
      continue;
    }
    if (argument == '--pub') {
      runPub = true;
      continue;
    }

    if (argument.startsWith('-')) {
      flutterArguments.add(argument);
      if (_flutterValueOptions.contains(argument)) skipNext = true;
      continue;
    }

    outputDirectory ??= argument;
  }

  return CreateArguments(
    outputDirectory: outputDirectory,
    flutterArguments: flutterArguments,
    interactive: interactive,
    runPub: runPub,
  );
}

Future<int> createFluecoApp(List<String> arguments) async {
  if (arguments.contains('--help') || arguments.contains('-h')) {
    return _run('flutter', ['create', '--help'], printOutput: true);
  }

  final parsed = parseCreateArguments(arguments);
  final createArguments = [...parsed.flutterArguments];
  var outputDirectory = parsed.outputDirectory;

  if (parsed.interactive) {
    outputDirectory ??= _prompt('Output directory');
    _promptFlutterOption(createArguments, '--project-name', 'Project name');
    _promptFlutterOption(
        createArguments, '--org', 'Organization', 'com.example');
    _promptFlutterOption(
      createArguments,
      '--description',
      'Description',
      'A Flueco application.',
    );
    _promptFlutterOption(
      createArguments,
      '--platforms',
      'Platforms (comma-separated)',
      'android,ios,web,windows,linux,macos',
    );
    _promptFlutterOption(
      createArguments,
      '--android-language',
      'Android language (kotlin or java)',
      'kotlin',
    );
  }

  if (outputDirectory == null || outputDirectory.trim().isEmpty) {
    stderr.writeln('An output directory is required.\n');
    stderr.writeln(usage);
    return 64;
  }

  final target = Directory(outputDirectory).absolute;
  if (await target.exists() && (await target.list().isEmpty)) {
    // An empty directory is fine; Flutter will populate it.
  } else if (await target.exists()) {
    stderr.writeln('The output directory is not empty: ${target.path}');
    return 1;
  }

  final projectName =
      _optionValue(createArguments, '--project-name') ?? _projectName(target);
  if (!_hasOption(createArguments, '--project-name')) {
    createArguments.addAll(['--project-name', projectName]);
  }

  final tempDirectory = await Directory.systemTemp.createTemp('flueco_cli_');
  try {
    stdout.writeln('Generating app in progress...');
    final repository =
        Directory('${tempDirectory.path}${Platform.pathSeparator}repo');
    var result = await _run('git', [
      'clone',
      '--depth',
      '1',
      '--filter=blob:none',
      '--sparse',
      'https://github.com/flutter-ecosystem/flueco.git',
      repository.path,
    ]);
    if (result != 0) return result;

    result = await _run('git', [
      '-C',
      repository.path,
      'sparse-checkout',
      'set',
      'example',
    ]);
    if (result != 0) return result;

    final templateDirectory = Directory(
      '${repository.path}${Platform.pathSeparator}example',
    );
    await _copyDirectory(templateDirectory, target);

    final flutterArguments = ['create', '.', ...createArguments, '--no-pub'];
    result = await _run(
      'flutter',
      flutterArguments,
      workingDirectory: target.path,
    );
    if (result != 0) return result;
    await _mergePubspec(
      File('${templateDirectory.path}${Platform.pathSeparator}pubspec.yaml'),
      File('${target.path}${Platform.pathSeparator}pubspec.yaml'),
      projectName: projectName,
      description: _optionValue(createArguments, '--description'),
    );

    if (parsed.runPub) {
      final pubArguments = ['pub', 'get'];
      if (createArguments.contains('--offline')) pubArguments.add('--offline');
      result =
          await _run('flutter', pubArguments, workingDirectory: target.path);
      if (result != 0) return result;

      result = await _run(
        'dart',
        ['run', 'build_runner', 'build'],
        workingDirectory: target.path,
      );
      if (result != 0) return result;
    }

    stdout.writeln('Generation finished at ${target.path}');
    stdout.writeln('Next steps:');
    stdout.writeln('  cd "${target.path}"');
    if (!parsed.runPub) {
      stdout.writeln('  flutter pub get');
      stdout.writeln('  flutter run --dart-define-from-file=.env.json');
    }
    stdout.writeln('  flutter run');
    return 0;
  } finally {
    await tempDirectory.delete(recursive: true);
  }
}

void _promptFlutterOption(
  List<String> arguments,
  String option,
  String label, [
  String? defaultValue,
]) {
  if (_hasOption(arguments, option)) return;
  final suffix = defaultValue == null ? '' : ' [$defaultValue]';
  stdout.write('$label$suffix: ');
  final value = stdin.readLineSync()?.trim() ?? '';
  if (value.isNotEmpty) arguments.addAll([option, value]);
}

bool _hasOption(List<String> arguments, String option) => arguments.any(
      (argument) => argument == option || argument.startsWith('$option='),
    );

String? _optionValue(List<String> arguments, String option) {
  for (var index = 0; index < arguments.length; index++) {
    final argument = arguments[index];
    if (argument.startsWith('$option=')) {
      return argument.substring(option.length + 1);
    }
    if (argument == option && index + 1 < arguments.length) {
      return arguments[index + 1];
    }
  }
  return null;
}

String _projectName(Directory directory) {
  final directoryName = directory.path
      .split(Platform.pathSeparator)
      .where((segment) => segment.isNotEmpty)
      .last;
  var projectName = directoryName
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9_]+'), '_')
      .replaceAll(RegExp(r'_+'), '_');
  if (!RegExp(r'^[a-z]').hasMatch(projectName)) {
    projectName = 'app_$projectName';
  }
  return projectName;
}

String _prompt(String label) {
  stdout.write('$label: ');
  return stdin.readLineSync()?.trim() ?? '';
}

Future<int> _run(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
  bool printOutput = false,
}) async {
  final result = await Process.run(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    runInShell: Platform.isWindows,
    stdoutEncoding: systemEncoding,
    stderrEncoding: systemEncoding,
  );
  if (printOutput || result.exitCode != 0) {
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  }
  return result.exitCode;
}

Future<void> _copyDirectory(Directory source, Directory destination) async {
  await destination.create(recursive: true);
  await for (final entity in source.list(followLinks: false)) {
    final name = entity.uri.pathSegments.where((part) => part.isNotEmpty).last;
    final outputPath = '${destination.path}${Platform.pathSeparator}$name';
    if (entity is Directory) {
      await _copyDirectory(entity, Directory(outputPath));
    } else if (entity is File) {
      await entity.copy(outputPath);
    }
  }
}

Future<void> _mergePubspec(
  File templateFile,
  File generatedFile, {
  required String projectName,
  String? description,
}) async {
  final template = _toNativeMap(loadYaml(await templateFile.readAsString()));
  final generated = YamlEditor(await generatedFile.readAsString());
  final generatedMap = _toNativeMap(loadYaml(generated.toString()));

  for (final section in ['dependencies', 'dev_dependencies', 'flutter']) {
    final generatedSection = generatedMap[section];
    final templateSection = template[section];
    final merged = <String, Object?>{
      if (generatedSection is Map<String, Object?>) ...generatedSection,
      if (templateSection is Map<String, Object?>) ...templateSection,
    };
    generated.update([section], merged);
  }

  final flutterGen = template['flutter_gen'];
  if (flutterGen != null) generated.update(['flutter_gen'], flutterGen);
  if (generatedMap.containsKey('resolution')) {
    generated.remove(['resolution']);
  }
  generated.update(['name'], projectName);
  if (description != null) generated.update(['description'], description);
  await generatedFile.writeAsString(generated.toString());
}

Map<String, Object?> _toNativeMap(Object? value) {
  if (value is! YamlMap) return {};
  return value.map((key, item) => MapEntry(key.toString(), _toNative(item)));
}

Object? _toNative(Object? value) {
  if (value is YamlMap) return _toNativeMap(value);
  if (value is YamlList) return value.map(_toNative).toList();
  return value;
}
