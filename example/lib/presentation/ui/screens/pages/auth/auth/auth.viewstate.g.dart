// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.viewstate.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthViewStateCWProxy {
  AuthViewState authenticating(bool authenticating);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthViewState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthViewState(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthViewState call({bool authenticating});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthViewState.copyWith(...)` or call `instanceOfAuthViewState.copyWith.fieldName(value)` for a single field.
class _$AuthViewStateCWProxyImpl implements _$AuthViewStateCWProxy {
  const _$AuthViewStateCWProxyImpl(this._value);

  final AuthViewState _value;

  @override
  AuthViewState authenticating(bool authenticating) =>
      call(authenticating: authenticating);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthViewState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthViewState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AuthViewState call({Object? authenticating = const $CopyWithPlaceholder()}) {
    return AuthViewState(
      authenticating:
          authenticating == const $CopyWithPlaceholder() ||
              authenticating == null
          ? _value.authenticating
          // ignore: cast_nullable_to_non_nullable
          : authenticating as bool,
    );
  }
}

extension $AuthViewStateCopyWith on AuthViewState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthViewState.copyWith(...)` or `instanceOfAuthViewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthViewStateCWProxy get copyWith => _$AuthViewStateCWProxyImpl(this);
}
