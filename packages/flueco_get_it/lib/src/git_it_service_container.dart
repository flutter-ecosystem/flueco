import 'dart:async';

import 'package:flueco_core/flueco_core.dart';
import 'package:get_it/get_it.dart';

import 'get_it_instance_provider.dart';

/// ServiceContainer
class GetItServiceContainer
    implements ServiceContainer, GetItInstanceProvider, GetIt {
  late final GetIt _getIt;

  final List<Type> _registeredType;

  /// Constructor
  ///
  /// Every call will create a new one rather than the same instance
  GetItServiceContainer({GetIt? getIt}) : _registeredType = <Type>[] {
    _getIt = getIt ?? GetIt.asNewInstance();
  }

  @override
  bool get allowReassignment => _getIt.allowReassignment;

  @override
  set allowReassignment(bool allowReassignment) {
    _getIt.allowReassignment = allowReassignment;
  }

  @override
  String? get currentScopeName => _getIt.currentScopeName;

  /// GetIt instance used by this container
  @override
  GetIt get getIt => this;

  @override
  void Function(bool pushed)? get onScopeChanged => _getIt.onScopeChanged;

  @override
  set onScopeChanged(void Function(bool pushed)? onScopeChanged) {
    _getIt.onScopeChanged = onScopeChanged;
  }

  @override
  Future<void> allReady(
      {Duration? timeout, bool ignorePendingAsyncCreation = false}) {
    return _getIt.allReady(
      timeout: timeout,
      ignorePendingAsyncCreation: ignorePendingAsyncCreation,
    );
  }

  @override
  bool allReadySync([bool ignorePendingAsyncCreation = false]) {
    return _getIt.allReadySync(ignorePendingAsyncCreation);
  }

  @override
  T call<T extends Object>({String? instanceName, param1, param2, Type? type}) {
    return _getIt.call<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
      type: type,
    );
  }

  @override
  void factory<T extends Object>(T Function(ServiceResolver resolver) factory,
      {String? name, bool force = false}) {
    if (_getIt.isRegistered<T>(instanceName: name)) {
      if (force) {
        unregister<T>(instanceName: name);
      } else {
        return;
      }
    }
    _getIt.registerFactory(
      () => factory(this),
      instanceName: name,
    );
    _addRegisteredType(T);
  }

  @override
  T get<T extends Object>({String? instanceName, param1, param2, Type? type}) {
    return _getIt.get<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
      type: type,
    );
  }

  @override
  Future<T> getAsync<T extends Object>(
      {String? instanceName, param1, param2, Type? type}) {
    return _getIt.getAsync<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
      type: type,
    );
  }

  @override
  Future<void> isReady<T extends Object>(
      {Object? instance,
      String? instanceName,
      Duration? timeout,
      Object? callee}) {
    return _getIt.isReady<T>(
      instance: instance,
      instanceName: instanceName,
      timeout: timeout,
      callee: callee,
    );
  }

  @override
  bool isReadySync<T extends Object>({Object? instance, String? instanceName}) {
    return _getIt.isReadySync<T>(
      instance: instance,
      instanceName: instanceName,
    );
  }

  @override
  bool isRegistered<T extends Object>(
      {Object? instance, String? instanceName}) {
    return _getIt.isRegistered<T>(
      instance: instance,
      instanceName: instanceName,
    );
  }

  @override
  bool isResolvable(Type type) {
    return _registeredType.contains(type);
  }

  @override
  bool isResolvableByName<T extends Object>(String name) {
    return _getIt.isRegistered<T>(instanceName: name);
  }

  @override
  void lazySingleton<T extends Object>(
    T Function(ServiceResolver resolver) factory, {
    String? name,
    bool force = false,
  }) {
    if (_getIt.isRegistered<T>(instanceName: name)) {
      if (force) {
        unregister<T>(instanceName: name);
      } else {
        return;
      }
    }
    _getIt.registerLazySingleton<T>(
      () => factory(this),
      instanceName: name,
    );
    _addRegisteredType(T);
  }

  @override
  Future<void> popScope() {
    return _getIt.popScope();
  }

  @override
  void pushNewScope(
      {void Function(GetIt getIt)? init,
      String? scopeName,
      ScopeDisposeFunc? dispose,
      bool isFinal = false}) {
    _getIt.pushNewScope(
      init: init,
      scopeName: scopeName,
      dispose: dispose,
      isFinal: isFinal,
    );
  }

  @override
  void registerFactory<T extends Object>(FactoryFunc<T> factoryFunc,
      {String? instanceName}) {
    _getIt.registerFactory<T>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerFactoryAsync<T extends Object>(FactoryFuncAsync<T> factoryFunc,
      {String? instanceName}) {
    _getIt.registerFactoryAsync<T>(
      factoryFunc,
      instanceName: instanceName,
    );
    _addRegisteredType(T);
  }

  @override
  void registerFactoryParam<T extends Object, P1, P2>(
      FactoryFuncParam<T, P1, P2> factoryFunc,
      {String? instanceName}) {
    _getIt.registerFactoryParam<T, P1, P2>(
      factoryFunc,
      instanceName: instanceName,
    );
    _addRegisteredType(T);
  }

  @override
  void registerFactoryParamAsync<T extends Object, P1, P2>(
      FactoryFuncParamAsync<T, P1?, P2?> factoryFunc,
      {String? instanceName}) {
    _getIt.registerFactoryParamAsync<T, P1, P2>(
      factoryFunc,
      instanceName: instanceName,
    );
    _addRegisteredType(T);
  }

  @override
  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
    bool useWeakReference = false,
  }) {
    _getIt.registerLazySingleton(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
      useWeakReference: useWeakReference,
    );
    _addRegisteredType(T);
  }

  @override
  void registerLazySingletonAsync<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
    bool useWeakReference = false,
  }) {
    _getIt.registerLazySingletonAsync(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
      useWeakReference: useWeakReference,
    );
    _addRegisteredType(T);
  }

  @override
  T registerSingleton<T extends Object>(T instance,
      {String? instanceName, bool? signalsReady, DisposingFunc<T>? dispose}) {
    _addRegisteredType(T);
    return _getIt.registerSingleton<T>(
      instance,
      instanceName: instanceName,
      signalsReady: signalsReady,
      dispose: dispose,
    );
  }

  @override
  void registerSingletonAsync<T extends Object>(FactoryFuncAsync<T> factoryFunc,
      {String? instanceName,
      Iterable<Type>? dependsOn,
      bool? signalsReady,
      DisposingFunc<T>? dispose}) {
    _getIt.registerSingletonAsync<T>(
      factoryFunc,
      instanceName: instanceName,
      dependsOn: dependsOn,
      signalsReady: signalsReady,
      dispose: dispose,
    );
    _addRegisteredType(T);
  }

  @override
  void registerSingletonWithDependencies<T extends Object>(
      FactoryFunc<T> factoryFunc,
      {String? instanceName,
      Iterable<Type>? dependsOn,
      bool? signalsReady,
      DisposingFunc<T>? dispose}) {
    _getIt.registerSingletonWithDependencies<T>(
      factoryFunc,
      instanceName: instanceName,
      dependsOn: dependsOn,
      signalsReady: signalsReady,
      dispose: dispose,
    );
    _addRegisteredType(T);
  }

  @override
  Future<void> reset({bool dispose = true}) {
    return _getIt.reset(dispose: dispose);
  }

  @override
  FutureOr resetLazySingleton<T extends Object>(
      {T? instance,
      String? instanceName,
      FutureOr Function(T p1)? disposingFunction}) {
    return _getIt.resetLazySingleton<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }

  @override
  Future<void> resetScope({bool dispose = true}) {
    return _getIt.resetScope(dispose: dispose);
  }

  @override
  T resolve<T extends Object>({String? name}) {
    return _getIt.get<T>(instanceName: name);
  }

  @override
  void signalReady(Object? instance) {
    _getIt.signalReady(instance);
  }

  @override
  void singleton<T extends Object>(
    T Function(ServiceResolver resolver) factory, {
    String? name,
    bool force = false,
  }) {
    if (_getIt.isRegistered<T>(instanceName: name)) {
      if (force) {
        unregister<T>(instanceName: name);
      } else {
        return;
      }
    }
    _getIt.registerSingleton(
      factory(this),
      instanceName: name,
    );
    _addRegisteredType(T);
  }

  @override
  FutureOr unregister<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(T p1)? disposingFunction,
    bool ignoreReferenceCount = false,
  }) {
    _removeRegisteredType(T);
    return _getIt.unregister<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
      ignoreReferenceCount: ignoreReferenceCount,
    );
  }

  void _addRegisteredType(Type type) {
    _registeredType.add(type);
  }

  void _removeRegisteredType(Type type) {
    _registeredType.remove(type);
  }

  @override
  Future<void> singletonAsync<T extends Object>(
    Future<T> Function(ServiceResolver resolver) factory, {
    String? name,
    bool force = false,
  }) async {
    final injected = await factory(this);
    singleton<T>((_) => injected, name: name, force: force);
  }

  @override
  Future<void> pushNewScopeAsync(
      {Future<void> Function(GetIt getIt)? init,
      String? scopeName,
      ScopeDisposeFunc? dispose}) {
    return _getIt.pushNewScopeAsync(
      init: init,
      dispose: dispose,
      scopeName: scopeName,
    );
  }

  @override
  Future<bool> popScopesTill(String name, {bool inclusive = true}) {
    return _getIt.popScopesTill(
      name,
      inclusive: inclusive,
    );
  }

  @override
  Future<void> dropScope(String scopeName) {
    return _getIt.dropScope(scopeName);
  }

  @override
  bool hasScope(String scopeName) {
    return _getIt.hasScope(scopeName);
  }

  @override
  bool allowRegisterMultipleImplementationsOfoneType = false;

  @override
  bool skipDoubleRegistration = false;

  @override
  void enableRegisteringMultipleInstancesOfOneType() {
    _getIt.enableRegisteringMultipleInstancesOfOneType();
  }

  @override
  Iterable<T> getAll<T extends Object>({
    param1,
    param2,
    bool fromAllScopes = false,
  }) {
    return _getIt.getAll<T>(
      param1: param1,
      param2: param2,
      fromAllScopes: fromAllScopes,
    );
  }

  @override
  Future<Iterable<T>> getAllAsync<T extends Object>({
    param1,
    param2,
    bool fromAllScopes = false,
  }) {
    return _getIt.getAllAsync<T>(
      param1: param1,
      param2: param2,
      fromAllScopes: fromAllScopes,
    );
  }

  @override
  void unlink<T extends Object>({String? name}) {
    unregister<T>(instanceName: name);
  }

  @override
  void changeTypeInstanceName<T extends Object>({
    String? instanceName,
    required String newInstanceName,
    T? instance,
  }) {
    _getIt.changeTypeInstanceName<T>(
      instanceName: instanceName,
      newInstanceName: newInstanceName,
      instance: instance,
    );
  }

  @override
  bool checkLazySingletonInstanceExists<T extends Object>({
    String? instanceName,
  }) {
    return _getIt.checkLazySingletonInstanceExists<T>(
      instanceName: instanceName,
    );
  }

  @override
  void registerCachedFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _getIt.registerCachedFactory<T>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerCachedFactoryAsync<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _getIt.registerCachedFactoryAsync<T>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerCachedFactoryParam<T extends Object, P1, P2>(
    FactoryFuncParam<T, P1, P2> factoryFunc, {
    String? instanceName,
  }) {
    _getIt.registerCachedFactoryParam<T, P1, P2>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerCachedFactoryParamAsync<T extends Object, P1, P2>(
    FactoryFuncParam<T, P1, P2> factoryFunc, {
    String? instanceName,
  }) {
    _getIt.registerCachedFactoryParamAsync<T, P1, P2>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  T registerSingletonIfAbsent<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    return _getIt.registerSingletonIfAbsent<T>(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void releaseInstance(Object instance) {
    _getIt.releaseInstance(instance);
  }
}
