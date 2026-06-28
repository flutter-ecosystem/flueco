import 'package:dio/dio.dart' show Dio, Response, RequestOptions;
import 'package:flueco_dio/src/dio_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(
    'DioHttpClient',
    () {
      late DioHttpClient client;
      late _MockDio mockDio;

      setUp(() {
        mockDio = _MockDio();
        client = DioHttpClient.fromDio(
          mockDio,
        );
      });

      test(
        'get calls Dio.get',
        () async {
          // Arrange
          final queryParameters = {'param': 'value'};
          when(() => mockDio.get(
                any(),
                queryParameters: any(named: 'queryParameters'),
                options: any(named: 'options'),
              )).thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/get'),
              ));

          // Act
          await client.get(
            '/get',
            queryParameters: queryParameters,
          );

          // Assert
          verify(
            () => mockDio.get(
              '/get',
              queryParameters: queryParameters,
              options: any(named: 'options'),
            ),
          ).called(1);
        },
      );

      test(
        'post calls Dio.post',
        () async {
          // Arrange
          final body = {'key': 'value'};
          when(() => mockDio.post<dynamic>(
                any(),
                data: any(named: 'data'),
                queryParameters: any(named: 'queryParameters'),
                options: any(named: 'options'),
              )).thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/post'),
              ));

          // Act
          await client.post(
            '/post',
            data: body,
          );
          // Assert
          verify(
            () => mockDio.post(
              '/post',
              data: body,
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ),
          ).called(1);
        },
      );
    },
  );
}

class _MockDio extends Mock implements Dio {}
