import 'package:flutter/rendering.dart' show Locale;

export 'locale_keys.g.dart';
export 'localizations.g.dart';
export 'package:easy_localization/easy_localization.dart';

const fallbackLocale = Locale('en');
const supportedLocales = <Locale>[fallbackLocale];
