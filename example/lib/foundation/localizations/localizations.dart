import 'package:flutter/rendering.dart' show Locale;

export 'package:easy_localization/easy_localization.dart';

export 'locale_keys.g.dart';
export 'localizations.g.dart';

const fallbackLocale = Locale('en');
const supportedLocales = <Locale>[fallbackLocale];
