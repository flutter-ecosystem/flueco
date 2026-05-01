import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_dio/src/dio_service_provider.dart';
import 'package:flueco_dio/src/dio_http_client.dart';
import 'package:flueco_dio/src/dio_instance_provider.dart';
import 'package:flueco_dio/src/dio_base_options_provider.dart';
import 'package:flueco_core/flueco_core.dart';

void main() {
  group(
    'DioServiceProvider',
    () {
      test(
        'dependsOn returns DioBaseOptionsProvider',
        () {
          final provider = DioServiceProvider();
          expect(provider.dependsOn(), contains(DioBaseOptionsProvider));
        },
      );

      test(
        'registered contains DioHttpClient and DioInstanceProvider',
        () {
          final provider = DioServiceProvider();
          final registered = provider.registered();
          expect(registered, contains(DioHttpClient));
          expect(registered, contains(DioInstanceProvider));
        },
      );

      test(
        'register registers DioHttpClient and DioInstanceProvider',
        () async {
          final provider = DioServiceProvider();
          final injector = _MockServiceInjector();
          await provider.register(injector);
          expect(injector.lazySingletonCalled, isTrue);
          expect(injector.factoryCalled, isTrue);
        },
      );
    },
  );
}

class _MockServiceInjector implements ServiceInjector {
  bool lazySingletonCalled = false;
  bool factoryCalled = false;

  @override
  void lazySingleton<T extends Object>(T Function(ServiceResolver) factory,
      {bool force = false, String? name}) {
    if (T == DioHttpClient) lazySingletonCalled = true;
  }

  @override
  void factory<T extends Object>(T Function(ServiceResolver) factory,
      {bool force = false, String? name}) {
    if (T == DioInstanceProvider) factoryCalled = true;
  }

  @override
  void singleton<T extends Object>(T Function(ServiceResolver) factory,
      {bool force = false, String? name}) {}

  @override
  Future<void> singletonAsync<T extends Object>(
      Future<T> Function(ServiceResolver) factory,
      {bool force = false,
      String? name}) async {}

  @override
  void unlink<T extends Object>({String? name}) {}
}
