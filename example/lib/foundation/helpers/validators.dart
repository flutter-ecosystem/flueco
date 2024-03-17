import 'package:example/foundation/localizations/localizations.dart';

/// Helper used to validate string
class Validators {
  /// Creates an instance of [Validators]
  const Validators();

  /// Validate email
  Validation validate(
    String? value, {
    required Iterable<Validator> validators,
  }) {
    assert(validators.isNotEmpty);

    for (final Validator validator in validators) {
      final Validation validation = validator.validate(value);
      if (validation.failed) {
        return validation;
      }
    }

    return const Validation.succeed();
  }
}

/// Validator
abstract interface class Validator {
  /// Check that [value] passes the requirements
  Validation validate(String? value);
}

/// Implementation of [Validator] to validate email.
final class EmailValidator implements Validator {
  /// Creates an instance of [EmailValidator]
  const EmailValidator();

  @override
  Validation validate(String? value) {
    if (value?.isNotEmpty != true) {
      return Validation.failed(message: LocaleKeys.fieldRequired.tr());
    }

    final RegExp emailRegExp = RegExp(
      r'^[\w\.-_]+@[\w\.-_]+\.\w+$',
      caseSensitive: false,
    );

    if (!emailRegExp.hasMatch(value!)) {
      return Validation.failed(message: LocaleKeys.invalidEmail.tr());
    }

    return const Validation.succeed();
  }
}

/// Implementation of [Validator] to validate required not empty.
final class NotEmptyValidator implements Validator {
  /// Creates an instance of [NotEmptyValidator]
  const NotEmptyValidator();

  @override
  Validation validate(String? value) {
    if (value?.isNotEmpty != true) {
      return Validation.failed(message: LocaleKeys.fieldRequired.tr());
    }

    return const Validation.succeed();
  }
}

/// Implementation of [Validator] to validate length of value.
final class LengthValidator implements Validator {
  /// Value to validate
  final int length;

  /// Creates an instance of [LengthValidator]
  const LengthValidator({
    required this.length,
  });

  @override
  Validation validate(String? value) {
    if (length != value?.length) {
      return Validation.failed(message: LocaleKeys.incorrectValue.tr());
    }

    return const Validation.succeed();
  }
}

/// Validation data
class Validation {
  /// Message of the validation
  final String? message;

  /// Creates an instance of [Validation] that succeed
  const Validation.succeed() : message = null;

  /// Creates an instance of [Validation] that failed
  const Validation.failed({required this.message}) : assert(message != null);

  /// Wether the validation succeed
  bool get succeed => message == null;

  /// Wether the validation failed
  bool get failed => message != null;
}
