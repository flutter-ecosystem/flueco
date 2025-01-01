// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "helloWorld": "Hello World",
    "email": "Email",
    "password": "Password",
    "submit": "Submit",
    "hello": "Hey",
    "invalidEmail": "Invalid email",
    "fieldRequired": "Field required",
    "incorrectValue": "Incorrect value",
    "logout": "Logout",
    "logoutConfirmationMessage": "Are you sure you want to logout ?"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"en": en};
}
