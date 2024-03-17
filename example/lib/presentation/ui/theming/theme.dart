// ignore_for_file: public_member_api_docs

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flueco/flueco.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = FlexThemeData.light(scheme: FlexScheme.aquaBlue);

final ThemeData darkTheme = FlexThemeData.dark(scheme: FlexScheme.aquaBlue);

final Appearance defaultAppearance = Appearance(
  key: 'default',
  lightTheme: darkTheme,
  darkTheme: darkTheme,
);
