// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAuthResponse _$LoginAuthResponseFromJson(Map<String, dynamic> json) =>
    LoginAuthResponse(
      data: LoginAuthData.fromJson(json['d'] as Map<String, dynamic>),
    );

LoginAuthData _$LoginAuthDataFromJson(Map<String, dynamic> json) =>
    LoginAuthData(
      token: json['t'] as String,
    );
