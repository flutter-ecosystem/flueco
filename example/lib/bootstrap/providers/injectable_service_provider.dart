import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';
import 'package:injectable/injectable.dart';

import '../../foundation/config/app_config.dart';
import '../../presentation/routing/app_router.dart';
import 'injectable_service_provider.config.dart';

const List<Type> _dependencies = <Type>[
  AppConfig,
  AppRouter,
  Authenticator,
  EventHandler,
  Messaging,
  ServiceInjector,
  ServiceResolver,
  DioInstanceProvider,
  SecureStorage,
  LocalStorage,
  DialogService,
  LoggerService,
  ModalService,
  ToastService,
  HiveBoxFactory,
];

///
/// Setup injector
///
@InjectableInit(
  ignoreUnregisteredTypes: _dependencies,
)
Future<GetIt> _initializeInjections(
  GetItInstanceProvider getItInstanceProvider,
  String environment,
) =>
    getItInstanceProvider.getIt.init(environment: environment);

///
class InjectableServiceProvider extends ServiceProvider {
  final GetItServiceContainer _container;
  final String _environment;

  ///
  InjectableServiceProvider({
    required GetItServiceContainer container,
    required String environment,
  })  : _container = container,
        _environment = environment;

  @override
  Set<Type> dependsOn() {
    return <Type>{
      ..._dependencies,
    };
  }

  @override
  // ignore: no-empty-block
  Future<void> initialize(FluecoApp app) async {
    //
  }

  @override
  Future<void> register(ServiceInjector injector) async {
    injector.singleton<GetItServiceContainer>(
      (ServiceResolver resolver) => _container,
    );
    await _initializeInjections(_container, _environment);
  }

  @override
  Set<Type> registered() {
    return <Type>{
      GetItServiceContainer,
    };
  }
}
