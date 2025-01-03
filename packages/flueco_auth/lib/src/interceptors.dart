import 'dart:async';
import 'dart:collection';

import 'package:flueco_auth/src/authentication.dart';
import 'package:flueco_auth/src/authentication_credentials.dart';
import 'package:flueco_auth/src/authentication_provider.dart';
import 'package:flueco_auth/src/exceptions/authentication_exception.dart';

/// Interceptors used to intercept the authentication process.
class AuthenticationInterceptors {
  final Queue<AuthenticationInterceptor> _interceptors;

  AuthenticationInterceptors(
      {required Iterable<AuthenticationInterceptor> interceptors})
      : _interceptors = Queue.from(interceptors);

  /// Add an interceptor to the first position.
  void addFirstInterceptor(AuthenticationInterceptor interceptor) {
    _interceptors.addFirst(interceptor);
  }

  /// Add an interceptor to the last position.
  void addInterceptor(AuthenticationInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  /// Remove an interceptor.
  void removeInterceptor(AuthenticationInterceptor interceptor) {
    _interceptors.remove(interceptor);
  }

  /// Get the interceptor at the given [index].
  AuthenticationInterceptor at(int index) {
    return _interceptors.elementAt(index);
  }

  /// Get the length of the interceptors.
  int get length => _interceptors.length;
}

/// Handler used to handle the interception of the authentication process.
class AuthenticationInterceptionHandler {
  final AuthenticationInterceptors _interceptors;

  /// Creates an instance of [AuthenticationInterceptionHandler]
  AuthenticationInterceptionHandler(
      {required AuthenticationInterceptors interceptors})
      : _interceptors = interceptors;

  /// Handle the start of the authentication process.
  Future<void> handleStart(StartAuthenticationContext context) {
    final completer = Completer<void>();
    _handle(
      context: context,
      completer: completer,
      process: (interceptor, handler) {
        interceptor.onStart(
          context: context,
          handler: handler,
        );
      },
    );
    return completer.future;
  }

  /// Handle the done of the authentication process.
  Future<void> handleDone(DoneAuthenticationContext context) {
    final completer = Completer<void>();
    _handle(
      context: context,
      completer: completer,
      process: (interceptor, handler) {
        interceptor.onDone(
          context: context,
          handler: handler,
        );
      },
    );
    return completer.future;
  }

  /// Handle the failed of the authentication process.
  Future<void> handleFailed(FailedAuthenticationContext context) {
    final completer = Completer<void>();
    _handle(
      context: context,
      completer: completer,
      process: (interceptor, handler) {
        interceptor.onFailed(
          context: context,
          handler: handler,
        );
      },
    );
    return completer.future;
  }

  void _handle<T extends AuthenticationContext>({
    required T context,
    required Completer<void> completer,
    required void Function(
            AuthenticationInterceptor interceptor, NextHandler handler)
        process,
    int current = 0,
  }) {
    if (_interceptors.length <= 0) return;

    final interceptor = _interceptors.at(current);
    final nextHandler = NextHandler(
      onNext: () {
        final nextIndex = current + 1;
        final canContinue = nextIndex < _interceptors.length;
        if (canContinue) {
          _handle<T>(
            completer: completer,
            context: context,
            process: process,
            current: nextIndex,
          );
        } else {
          completer.complete();
        }
      },
      onAbort: (AbortedInterceptionException reason) {
        completer.completeError(
          reason,
          reason.stackTrace,
        );
      },
    );
    process(interceptor, nextHandler);
  }
}

/// Interceptor used to intercept the authentication process.
abstract class AuthenticationInterceptor {
  /// Called when the authentication process start
  void onStart(
      {required StartAuthenticationContext context,
      required NextHandler handler}) {
    handler.next();
  }

  /// Called when the authentication process is done and the [Authentication]
  /// but not stored yet.
  void onDone(
      {required DoneAuthenticationContext context,
      required NextHandler handler}) {
    handler.next();
  }

  /// Called when the authentication process failed.
  void onFailed(
      {required FailedAuthenticationContext context,
      required NextHandler handler}) {
    handler.next();
  }
}

/// Handler used to process the next action or to abort all.
class NextHandler {
  final void Function() _onNext;
  final void Function(AbortedInterceptionException reason) _onAbort;

  bool _called = false;

  /// Creates an instance of [NextHandler]
  NextHandler({
    required void Function() onNext,
    required void Function(AbortedInterceptionException reason) onAbort,
  })  : _onNext = onNext,
        _onAbort = onAbort;

  /// Continue the process
  void next() {
    if (_called) return;
    _called = true;

    _onNext();
  }

  /// Abort the process.
  ///
  /// If [reason] is not null it will throw an
  /// [AbortedInterceptionException] and if [stackTrace]
  /// is not null it will use [reason] as `cause` of the
  /// exception.
  void abort({
    Object? reason,
    StackTrace? stackTrace,
  }) {
    if (_called) return;
    _called = true;

    _onAbort(
      AbortedInterceptionException(
        cause: reason,
        stackTrace: stackTrace,
      ),
    );
  }
}

/// Exception thrown when an interception is aborted.
class AbortedInterceptionException extends AuthenticationException {
  /// Creates a new [AbortedInterceptionException].
  AbortedInterceptionException({
    super.cause,
    super.stackTrace,
  });
}

/// Type of context of authentication
enum AuthenticationContextType {
  /// Authentication made during the call
  /// of the authenticate
  authenticate,

  /// Authentication made during the call
  /// of the refresh
  refresh,

  /// Authentication made during the call
  /// of the populate
  populate,

  /// Authentication made during the call
  /// of the invalidate
  invalidate,
}

/// Context of the authentication
class AuthenticationContext {
  final AuthenticationContextType type;
  final AuthenticationProvider? provider;

  /// Creates an instance of [AuthenticationContext]
  AuthenticationContext({required this.type, this.provider});
}

/// Context of the authentication when the authenticate process is done
class StartAuthenticationContext extends AuthenticationContext {
  /// Credentials to use during the authentication.
  ///
  /// In [AuthenticationContextType.authenticate], this
  /// will be a subtype of [AuthenticationCredentials].
  /// In [AuthenticationContextType.refresh], this
  /// will be a subtype of [RefreshCredentials].
  final Credentials? credentials;

  /// Creates an instance of [StartAuthenticationContext]
  StartAuthenticationContext({
    required super.type,
    super.provider,
    this.credentials,
  }) : assert([
              AuthenticationContextType.invalidate,
              AuthenticationContextType.populate
            ].contains(type) ||
            credentials != null);

  /// Whether there's credentials provided.
  ///
  /// It will return false for [AuthenticationContextType.invalidate]
  /// and [AuthenticationContextType.populate]
  bool get hasCredentials => credentials != null;
}

/// Context of the authentication when the authenticate process is done
class DoneAuthenticationContext extends AuthenticationContext {
  late Authentication? authentication;
  final Authentication? originalAuthentication;

  /// Creates an instance of [DoneAuthenticationContext]
  DoneAuthenticationContext({
    required super.type,
    super.provider,
    this.authentication,
  }) : originalAuthentication = authentication;

  void updateAuthentication({required Authentication authentication}) {
    this.authentication = authentication;
  }
}

/// Context of the authentication when the authenticate process failed
class FailedAuthenticationContext extends AuthenticationContext {
  final Object failure;

  /// Creates an instance of [FailedAuthenticationContext]
  FailedAuthenticationContext({
    required super.type,
    super.provider,
    required this.failure,
  });
}
