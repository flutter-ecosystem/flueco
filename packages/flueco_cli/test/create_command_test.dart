import 'package:flueco_cli/flueco_cli.dart';
import 'package:test/test.dart';

void main() {
  group('parseCreateArguments', () {
    test('extracts the output directory and preserves Flutter options', () {
      final parsed = parseCreateArguments([
        '--org',
        'dev.flueco',
        '--platforms=android,web',
        'my_app',
        '--android-language',
        'java',
      ]);

      expect(parsed.outputDirectory, 'my_app');
      expect(parsed.flutterArguments, [
        '--org',
        'dev.flueco',
        '--platforms=android,web',
        '--android-language',
        'java',
      ]);
      expect(parsed.interactive, isFalse);
      expect(parsed.runPub, isTrue);
    });

    test('handles the interactive and no-pub wrapper options', () {
      final parsed = parseCreateArguments([
        'my_app',
        '--interactive',
        '--no-pub',
      ]);

      expect(parsed.outputDirectory, 'my_app');
      expect(parsed.flutterArguments, isEmpty);
      expect(parsed.interactive, isTrue);
      expect(parsed.runPub, isFalse);
    });
  });
}
