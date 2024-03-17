import 'package:example/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flueco/flueco.dart' show EquatableMixin;
import 'package:flueco_auth/flueco_auth.dart';

part 'auth.state.g.dart';

/// State of Auth view
@CopyWith()
final class AuthState with EquatableMixin {
  /// Authenticated user
  final User? user;

  /// Authentication
  final Authentication? authentication;

  /// Creates an instance of [AuthState]
  const AuthState({
    required this.user,
    required this.authentication,
  });

  /// Creates an instance of [AuthState]
  const AuthState.initial()
      : user = null,
        authentication = null;

  @override
  List<Object?> get props => <Object?>[user, authentication];
}
