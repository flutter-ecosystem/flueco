import 'package:flueco_dio/src/dio_base_options_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'DefaultDioBaseOptionsProvider',
    () {
      test(
        'returns provided BaseOptions',
        () {
          const baseUrl = 'https://test.com';
          final provider = DefaultDioBaseOptionsProvider(baseUrl);
          final options = provider.getBaseOptions();
          expect(options.baseUrl, equals(baseUrl));
        },
      );
    },
  );
}
