// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_installation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UpdateInstallationRequestToJson(
    UpdateInstallationRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('app_version', instance.appVersion);
  writeNotNull('device_os', instance.deviceOS);
  return val;
}
