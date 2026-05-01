import 'dart:io';

import 'package:flueco_dio/src/dio_base_options_provider.dart';
import 'package:flueco_dio/src/dio_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  const host = 'https://httpbin.org';
  final globalHttpOverrides = HttpOverrides.current;

  group(
    'DioHttpClient',
    () {
      late DioHttpClient client;
      late _MockHttpClient mockHttpClient;
      late _FakeHttpOverrides fakeHttpOverrides;

      setUpAll(() {
        registerFallbackValue(Uri());
      });

      setUp(() {
        final globalClient = (globalHttpOverrides ?? _FakeHttpOverrides(null))
            .createHttpClient(null);
        mockHttpClient = _MockHttpClient();
        fakeHttpOverrides = _FakeHttpOverrides(mockHttpClient);
        client = DioHttpClient(
          DefaultDioBaseOptionsProvider(
            host,
          ),
        );

        when(() => mockHttpClient.openUrl(any(), any())).thenAnswer(
          (inv) => globalClient.openUrl(
            inv.positionalArguments[0],
            inv.positionalArguments[1],
          ),
        );
        HttpOverrides.global = fakeHttpOverrides;
      });

      tearDown(() {
        HttpOverrides.global = globalHttpOverrides;
      });

      test(
        'get calls Dio.get',
        () async {
          // Arrange
          final queryParameters = {'param': 'value'};
          final uri = Uri.parse('$host/get').replace(
            queryParameters: queryParameters,
          );

          // Act
          await client.get(
            '/get',
            queryParameters: queryParameters,
          );

          // Assert
          verify(() => mockHttpClient.openUrl('GET', uri)).called(1);
        },
      );

      test(
        'post calls Dio.post',
        () async {
          // Arrange
          final body = {'key': 'value'};
          final uri = Uri.parse('$host/post');

          // Act
          await client.post(
            '/post',
            data: body,
          );
          // Assert
          verify(() => mockHttpClient.openUrl('POST', uri)).called(1);
        },
      );
    },
  );
}

class _FakeHttpOverrides extends HttpOverrides {
  final HttpClient? _httpClient;
  _FakeHttpOverrides(this._httpClient);
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _httpClient ?? super.createHttpClient(context);
  }
}

class _MockHttpClient extends Mock implements HttpClient {}
