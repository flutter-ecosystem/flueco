// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthStateCWProxy {
  AuthState user(User? user);

  AuthState authentication(Authentication? authentication);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthState call({User? user, Authentication? authentication});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthState.copyWith(...)` or call `instanceOfAuthState.copyWith.fieldName(value)` for a single field.
class _$AuthStateCWProxyImpl implements _$AuthStateCWProxy {
  const _$AuthStateCWProxyImpl(this._value);

  final AuthState _value;

  @override
  AuthState user(User? user) => call(user: user);

  @override
  AuthState authentication(Authentication? authentication) =>
      call(authentication: authentication);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AuthState call({
    Object? user = const $CopyWithPlaceholder(),
    Object? authentication = const $CopyWithPlaceholder(),
  }) {
    return AuthState(
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User?,
      authentication: authentication == const $CopyWithPlaceholder()
          ? _value.authentication
          // ignore: cast_nullable_to_non_nullable
          : authentication as Authentication?,
    );
  }
}

extension $AuthStateCopyWith on AuthState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthState.copyWith(...)` or `instanceOfAuthState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthStateCWProxy get copyWith => _$AuthStateCWProxyImpl(this);
}
