import 'package:flutter/foundation.dart';

import '../../core/di/service_injector.dart';
import '../../core/di/service_provider.dart';
import '../../core/di/service_resolver.dart';
import 'local_storage.dart';

/// Service provider for storage
abstract class IOLocalStorageServiceProvider extends ServiceProvider {
  /// Factory method of [LocalStorage]
  LocalStorage localStorageFactory(ServiceResolver resolver);

  @override
  @mustCallSuper
  Future<void> register(ServiceInjector injector) async {
    injector.lazySingleton<LocalStorage>(localStorageFactory);
  }

  @override
  @mustCallSuper
  Set<Type> registered() {
    return <Type>{
      LocalStorage,
    };
  }
}
