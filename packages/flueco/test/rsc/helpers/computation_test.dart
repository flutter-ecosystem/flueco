import 'package:flueco/src/helpers/computation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ComputedValue', () {
    setUp(() {
      // Ensure we start each test in a clean state:
      ComputedValue.evict();
    });

    test('should create a ComputedValue with a compute function', () {
      // Arrange
      int callCount = 0;
      final computed = ComputedValue<int>(
        computeFunction: () {
          callCount++;
          return callCount;
        },
      );

      // Act
      final value1 = computed.value;
      final value2 = computed.value;

      // Assert
      expect(value1, 1);
      expect(value2, 1, reason: 'Should not recompute on subsequent calls');
      expect(callCount, 1, reason: 'Compute function should only run once');
    });

    test('should recompute value when dependencies change', () {
      // Arrange
      final listValues = [1, 2, 3];
      int callCount = 0;
      final computed = ComputedValue<int>(
        computeFunction: () {
          callCount++;
          return listValues.reduce((a, b) => a + b);
        },
        dependencies: [listValues],
      );

      // Act
      final value1 = computed.value; // triggers compute
      computed.recalculate(); // no change in dependencies → no recompute
      final value2 = computed.value;

      // Assert
      expect(value1, 6);
      expect(value2, 6, reason: 'No dependencies change → no recompute');
      expect(callCount, 1);

      // Now let's change the dependencies
      listValues.add(4);
      computed.recalculate(); // dependencies changed → recompute
      final value3 = computed.value;

      expect(value3, 10, reason: 'Dependencies changed → recompute');
      expect(callCount, 2);
    });

    test('ComputedValue.of returns the same instance for the same key', () {
      // Arrange
      int callCount = 0;
      final key = 'testKey';

      // Act
      final computed1 = ComputedValue<int>.of(
        key: key,
        computeFunction: () {
          callCount++;
          return callCount;
        },
      );
      final computed2 = ComputedValue<int>.of(
        key: key,
        computeFunction: () {
          callCount++;
          return callCount;
        },
      );

      // Assert
      expect(computed1, same(computed2),
          reason: 'Should return the exact same instance for the same key');
    });

    test('ComputedValue.of should return a new instance after eviction', () {
      // Arrange
      int callCount = 0;
      final key = 'evictKey';

      // First creation
      final computed1 = ComputedValue<int>.of(
        key: key,
        computeFunction: () {
          callCount++;
          return callCount;
        },
      );

      // Act
      ComputedValue.evict(key); // Evict the existing ComputedValue

      // Recreate a new ComputedValue with the same key
      final computed2 = ComputedValue<int>.of(
        key: key,
        computeFunction: () {
          callCount++;
          return callCount;
        },
      );

      // Assert
      expect(computed1, isNot(same(computed2)),
          reason: 'After eviction, a new instance should be created');
    });

    test('ComputedValue.get returns null if not created', () {
      // Arrange
      final key = 'unknownKey';

      // Act
      final result = ComputedValue.get<int>(key);

      // Assert
      expect(result, isNull,
          reason:
              'Should return null if no ComputedValue was created with that key');
    });

    test('ComputedValue.get returns the existing instance', () {
      // Arrange
      final key = 'myKey';
      final computed = ComputedValue<int>.of(
        key: key,
        computeFunction: () => 42,
      );

      // Act
      final fetched = ComputedValue.get<int>(key);

      // Assert
      expect(fetched, isNotNull);
      expect(fetched, same(computed),
          reason: 'Should fetch the same instance from the cache');
      expect(fetched?.value, 42);
    });

    test('evict without a key clears all computed values', () {
      // Arrange
      ComputedValue<int>.of(
        key: 'key1',
        computeFunction: () => 1,
      );
      ComputedValue<int>.of(
        key: 'key2',
        computeFunction: () => 2,
      );

      // Act
      ComputedValue.evict(); // Evict all
      final fetched1 = ComputedValue.get<int>('key1');
      final fetched2 = ComputedValue.get<int>('key2');

      // Assert
      expect(fetched1, isNull);
      expect(fetched2, isNull);
    });
  });
}
