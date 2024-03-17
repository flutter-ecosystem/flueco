import 'package:flueco_core/flueco_core.dart';

import 'hive_secure_storage.dart';

/// Service provider for Hive
class FluecoHiveServiceProvider extends IOSecureStorageServiceProvider {
  @override
  Set<Type> dependsOn() {
    return <Type>{
      HiveSecureStorageGetInstanceConfig,
    };
  }

  @override
  Future<void> register(ServiceInjector injector) {
    injector.singleton<HiveSecureStorage>(
      (resolver) => HiveSecureStorage.getInstance(
        resolver.resolve<HiveSecureStorageGetInstanceConfig>(),
      ),
    );
    return super.register(injector);
  }

  @override
  Future<void> initialize(FluecoApp app) async {
    await app.resolver.resolve<HiveSecureStorage>().init();
  }

  @override
  SecureStorage secureStorageFactory(ServiceResolver resolver) {
    return resolver.resolve<HiveSecureStorage>();
  }

  @override
  Set<Type> registered() {
    return <Type>{
      ...super.registered(),
      HiveSecureStorage,
    };
  }
}
