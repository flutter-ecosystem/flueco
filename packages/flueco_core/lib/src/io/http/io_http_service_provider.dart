import 'package:flutter/foundation.dart';

import '../../foundation/di/service_injector.dart';
import '../../foundation/di/service_provider.dart';
import '../../foundation/di/service_resolver.dart';
import 'http_client.dart';

/// Service provider base class for Http services
abstract class IOHttpServiceProvider extends ServiceProvider {
  /// Factory method of [HttpClient]
  HttpClient httpClientFactory(ServiceResolver resolver);

  @override
  @mustCallSuper
  Future<void> register(ServiceInjector injector) async {
    injector.lazySingleton<HttpClient>(httpClientFactory);
  }

  @override
  @mustCallSuper
  Set<Type> registered() {
    return <Type>{
      HttpClient,
    };
  }
}
