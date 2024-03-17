import 'package:flueco_core/flueco_core.dart';

import 'dio_base_options_provider.dart';
import 'dio_http_client.dart';
import 'dio_instance_provider.dart';

/// Dio Service provider
class DioServiceProvider extends IOHttpServiceProvider {
  @override
  Set<Type> dependsOn() {
    return <Type>{
      DioBaseOptionsProvider,
    };
  }

  @override
  HttpClient httpClientFactory(ServiceResolver resolver) {
    return resolver.resolve<DioHttpClient>();
  }

  @override
  Future<void> initialize(FluecoApp app) async {}

  @override
  Future<void> register(ServiceInjector injector) {
    injector.lazySingleton<DioHttpClient>(
      (resolver) => DioHttpClient(
        resolver.resolve<DioBaseOptionsProvider>(),
      ),
    );
    injector.factory<DioInstanceProvider>(
      (resolver) => resolver.resolve<DioHttpClient>(),
    );
    return super.register(injector);
  }

  @override
  Set<Type> registered() {
    return <Type>{
      ...super.registered(),
      DioHttpClient,
      DioInstanceProvider,
    };
  }
}
