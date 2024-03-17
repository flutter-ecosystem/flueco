import 'package:flueco/flueco.dart';
import 'package:flutter/foundation.dart';

import 'package:example/data/sources/remote/http/clients/installation_http_client.dart';
import 'package:example/data/sources/remote/http/requests/installations/create_installation_request.dart';
import 'package:example/data/sources/remote/http/responses/installations/create_installation_response.dart';

import 'device_info_provider.dart';

/// Handler for app installation
final class AppInstallationHandler implements InstallationIDProvider {
  static const String _installationIDKey = 'iid';
  final Dio _dio;
  final LocalStorage _localStorage;
  final InstallationHttpClient _client;
  final DeviceInfoProvider _deviceInfoProvider;

  String? _installationID;

  /// Creates an instance of [AppInstallationHandler]
  AppInstallationHandler({
    required Dio dio,
    required LocalStorage localStorage,
    required InstallationHttpClient client,
    required DeviceInfoProvider deviceInfoProvider,
  })  : _dio = dio,
        _localStorage = localStorage,
        _client = client,
        _deviceInfoProvider = deviceInfoProvider;

  /// Initialize the service
  Future<void> initialize() async {
    _dio.interceptors
        .add(_AppInstallationRequestInterceptor(installationIDProvider: this));
    await _initInstallationID();
  }

  Future<void> _initInstallationID() async {
    final String? installationID = await _localStorage.get(_installationIDKey);

    if (installationID != null) {
      _installationID = installationID;
    } else {
      try {
        final CreateInstallationResponse response = await _client.create(
          CreateInstallationRequest(
            appVersion: _deviceInfoProvider.appVersion,
            deviceOS: _deviceInfoProvider.os,
            deviceOSVersion: _deviceInfoProvider.osVersion,
          ),
        );
        _installationID = response.data.uuid;
        await _localStorage.set(_installationIDKey, _installationID!);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  String? getInstallationID() {
    return _installationID;
  }
}

final class _AppInstallationRequestInterceptor extends QueuedInterceptor {
  static const String installationHeader = 'X-APP-INSTALLATION-ID';

  final InstallationIDProvider _installationIDProvider;

  _AppInstallationRequestInterceptor({
    required InstallationIDProvider installationIDProvider,
  }) : _installationIDProvider = installationIDProvider;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? installationID = _installationIDProvider.getInstallationID();
    if (installationID != null) {
      options.headers.addAll(
        <String, dynamic>{installationHeader: installationID},
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}

/// Provides the installation ID to add in request headers
abstract interface class InstallationIDProvider {
  /// Get the installation ID
  String? getInstallationID();
}
