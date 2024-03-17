// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthAuthResponse _$AuthAuthResponseFromJson(Map<String, dynamic> json) =>
    AuthAuthResponse(
      data: AuthAuthData.fromJson(json['d'] as Map<String, dynamic>),
    );

AuthAuthData _$AuthAuthDataFromJson(Map<String, dynamic> json) => AuthAuthData(
      codeLength: json['c_l'] as int,
    );
