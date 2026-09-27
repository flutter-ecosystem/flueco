import 'dart:io';

import 'package:flueco_cli/src/create_command.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty ||
      arguments.first == '--help' ||
      arguments.first == '-h') {
    print(usage);
    return;
  }

  if (arguments.first != 'create') {
    stderr.writeln('Unknown command: ${arguments.first}\n');
    stderr.writeln(usage);
    exitCode = 64;
    return;
  }

  exitCode = await createFluecoApp(arguments.skip(1).toList());
}
