import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Device info provider
class DeviceInfoProvider {
  /// Operating System
  final String os;

  /// Version of the operating system
  final String osVersion;

  /// Version of the application
  final String appVersion;

  /// Creates an instance of [DeviceInfoProvider]
  const DeviceInfoProvider({
    required this.os,
    required this.osVersion,
    required this.appVersion,
  });

  /// Creates an instance of [DeviceInfoProvider] from [infoPlugin] and
  /// [packageInfo]
  static Future<DeviceInfoProvider> create({
    required DeviceInfoPlugin infoPlugin,
    required PackageInfo packageInfo,
  }) async {
    final String os = Platform.operatingSystem;
    String osVersion = 'unknown';
    final String appVersion =
        '${packageInfo.version}+${packageInfo.buildNumber}';

    if (Platform.isAndroid) {
      final AndroidDeviceInfo deviceInfo = await infoPlugin.androidInfo;
      osVersion = deviceInfo.version.toString();
    }
    if (Platform.isIOS) {
      final IosDeviceInfo deviceInfo = await infoPlugin.iosInfo;
      osVersion = deviceInfo.systemVersion;
    }

    return DeviceInfoProvider(
      os: os,
      osVersion: osVersion,
      appVersion: appVersion,
    );
  }
}
