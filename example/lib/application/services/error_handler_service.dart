import 'package:flueco/flueco.dart';

/// Code of failure
enum RequestFailureCode {
  /// Code when invalid installation header
  invalidInstallationException(value: 'InvalidInstallationException'),

  /// Code when failure unknown
  unknown(value: 'unknown');

  /// Value of code
  final String value;

  const RequestFailureCode({required this.value});
}

/// Service to handle errors
final class ErrorHandler {
  final DialogService _dialogService;
  final LoggerService _loggerService;

  /// Creates an instance of [ErrorHandler]
  ErrorHandler({
    required DialogService dialogService,
    required LoggerService loggerService,
  })  : _dialogService = dialogService,
        _loggerService = loggerService;

  /// Extract code from [exception]
  static RequestFailureCode extractCodeOn(DioException exception) {
    final dynamic data = exception.response?.data;
    if (data is Map<String, dynamic>) {
      final dynamic code = data['code'];

      return RequestFailureCode.values.firstWhere(
        (RequestFailureCode element) => element.value == code,
        orElse: () => RequestFailureCode.unknown,
      );
    }

    return RequestFailureCode.unknown;
  }

  /// Handle [error]
  Future<void> handleError(
    Object error, {
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.normal,
  }) async {
    if (error is DioException) {
      return _handleDioException(
        error,
        stackTrace: stackTrace,
        severity: severity,
      );
    } else {
      _log(
        error.toString(),
        error,
        severity: severity,
      );
    }
  }

  Future<void> _handleDioException(
    DioException exception, {
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.normal,
  }) async {
    final StringBuffer messageBuffer = StringBuffer()
      ..writeln(
        'FAILED REQUEST: '
        '(${exception.requestOptions.method}) '
        '${exception.requestOptions.uri.toString()}',
      );

    if (exception.type == DioExceptionType.badResponse) {
      final String errorMessage = exception.message ??
          exception.error?.toString() ??
          exception.toString();
      messageBuffer.writeln('ERROR: $errorMessage');

      final dynamic responseBody = exception.response?.data;
      if (responseBody != null) {
        messageBuffer.writeln('BODY: ${responseBody.toString()}');
      }

      _log(
        messageBuffer.toString(),
        exception,
        severity: severity,
      );

      if (severity == ErrorSeverity.high) {
        await _dialogService.alert(
          data: AlertDialogData(
            title: 'Error',
            content: errorMessage,
          ),
        );
      }
    } else {
      final String errorMessage = exception.message ??
          exception.error?.toString() ??
          exception.toString();
      messageBuffer.writeln('ERROR: $errorMessage');

      _log(
        messageBuffer.toString(),
        exception,
        severity: severity,
      );
    }
  }

  void _log(
    String message,
    Object error, {
    StackTrace? stackTrace,
    required ErrorSeverity severity,
  }) {
    if (severity == ErrorSeverity.minor) {
      _loggerService.warning(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      _loggerService.error(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

/// Type of severity
enum ErrorSeverity {
  /// Only log a warning
  minor,

  /// Only log an error
  normal,

  /// Log an error and inform through a dialog
  high,

  /// Log an error and inform through a dialog and send it to remote
  critical,
}
