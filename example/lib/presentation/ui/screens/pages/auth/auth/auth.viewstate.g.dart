// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.viewstate.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthViewStateCWProxy {
  AuthViewState authenticating(bool authenticating);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthViewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthViewState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthViewState call({
    bool authenticating,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthViewState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthViewState.copyWith.fieldName(...)`
class _$AuthViewStateCWProxyImpl implements _$AuthViewStateCWProxy {
  const _$AuthViewStateCWProxyImpl(this._value);

  final AuthViewState _value;

  @override
  AuthViewState authenticating(bool authenticating) =>
      this(authenticating: authenticating);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthViewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthViewState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthViewState call({
    Object? authenticating = const $CopyWithPlaceholder(),
  }) {
    return AuthViewState(
      authenticating: authenticating == const $CopyWithPlaceholder()
          ? _value.authenticating
          // ignore: cast_nullable_to_non_nullable
          : authenticating as bool,
    );
  }
}

extension $AuthViewStateCopyWith on AuthViewState {
  /// Returns a callable class that can be used as follows: `instanceOfAuthViewState.copyWith(...)` or like so:`instanceOfAuthViewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthViewStateCWProxy get copyWith => _$AuthViewStateCWProxyImpl(this);
}
