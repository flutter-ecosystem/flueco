import 'package:flutter/foundation.dart';

import '../../core/di/service_injector.dart';
import '../../core/di/service_provider.dart';
import '../../core/di/service_resolver.dart';
import 'secure_storage.dart';

/// Service provider for storage
abstract class IOSecureStorageServiceProvider extends ServiceProvider {
  /// Factory method of [SecureStorage]
  SecureStorage secureStorageFactory(ServiceResolver resolver);

  @override
  @mustCallSuper
  Future<void> register(ServiceInjector injector) async {
    injector.lazySingleton<SecureStorage>(secureStorageFactory);
  }

  @override
  @mustCallSuper
  Set<Type> registered() {
    return {SecureStorage};
  }
}
