import 'package:flueco_core/flueco_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'BasicMemoryStorage',
    () {
      late BasicMemoryStorage storage;
      setUp(() {
        storage = BasicMemoryStorage();
      });

      test(
        'stores, retrieves, and deletes values in memory',
        () {
          expect(storage.get<String>('foo'), isNull);
          storage.set<String>('foo', 'bar');
          expect(storage.get<String>('foo'), 'bar');
          storage.remove('foo');
          expect(storage.get<String>('foo'), isNull);
        },
      );

      test(
        'overwrites values for the same key',
        () {
          storage.set<String>('key', 'value1');
          storage.set<String>('key', 'value2');
          expect(storage.get<String>('key'), 'value2');
        },
      );

      test(
        'contains returns true if key exists',
        () {
          storage.set<String>('key', 'value');
          expect(storage.contains('key'), isTrue);
        },
      );

      test(
        'contains returns false if key does not exist',
        () {
          expect(storage.contains('missing'), isFalse);
        },
      );

      test(
        'getAll returns all stored items',
        () {
          storage.set<String>('a', 'A');
          storage.set<String>('b', 'B');
          final all = storage.getAll();
          expect(all, containsPair('a', 'A'));
          expect(all, containsPair('b', 'B'));
          expect(all.length, 2);
        },
      );
    },
  );
}
