import 'package:flueco_core/flueco_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_storage.dart';

class FluecoSharedPreferencesServiceProvider
    extends IOLocalStorageServiceProvider {
  @override
  Set<Type> dependsOn() {
    return <Type>{
      SharedPreferences,
    };
  }

  @override
  Future<void> register(ServiceInjector injector) {
    injector.singleton<SharedPreferencesStorage>(
      (resolver) =>
          SharedPreferencesStorage(resolver.resolve<SharedPreferences>()),
    );
    return super.register(injector);
  }

  @override
  Future<void> initialize(FluecoApp app) async {}

  @override
  LocalStorage localStorageFactory(ServiceResolver resolver) {
    return resolver.resolve<SharedPreferencesStorage>();
  }

  @override
  Set<Type> registered() {
    return <Type>{
      ...super.registered(),
      SharedPreferencesStorage,
    };
  }
}
