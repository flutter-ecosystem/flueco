import 'package:example/foundation/localizations/localizations.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converter for [DateTime]
class DateTimeFormattedConverter implements JsonConverter<DateTime, String> {
  /// Format for UTC date string like 2023-12-31
  static const String date = 'y-M-d';

  /// Format for UTC date and time string like 2023-12-31T12:59:59
  static const String dateTime = 'y-M-dTH:m:s';

  /// Format for UTC date and time and milliseconds string
  /// like 2023-12-31T12:59:59.999
  static const String dateTimeMillisecond = 'y-M-dTH:m:s.S';

  /// Format to use during conversion to String
  final String format;

  /// Creates an instance of [DateTimeFormattedConverter]
  const DateTimeFormattedConverter({required this.format});

  @override
  DateTime fromJson(String json) {
    return DateFormat(format).parseUtc(json);
  }

  @override
  String toJson(DateTime object) {
    return DateFormat(format).format(object.toUtc());
  }
}

/// Converter for [DateTime]
class DateConverter extends DateTimeFormattedConverter {
  /// Creates an instance of [DateConverter]
  const DateConverter() : super(format: DateTimeFormattedConverter.date);
}

/// Converter for [DateTime]
class DateTimeConverter extends DateTimeFormattedConverter {
  /// Creates an instance of [DateTimeConverter]
  const DateTimeConverter()
      : super(format: DateTimeFormattedConverter.dateTime);
}

/// Converter for [DateTime]
class DateTimeMillisecondsConverter extends DateTimeFormattedConverter {
  /// Creates an instance of [DateTimeMillisecondsConverter]
  const DateTimeMillisecondsConverter()
      : super(format: DateTimeFormattedConverter.dateTimeMillisecond);
}
