import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flueco_state_management/flueco_state_management.dart'
    show ViewState;

part 'auth.viewstate.g.dart';

/// State of Auth view
@CopyWith()
class AuthViewState extends ViewState {
  /// Whether authentication is ongoing
  final bool authenticating;

  /// Creates an instance of [AuthViewState]
  const AuthViewState({required this.authenticating});

  /// Creates an instance of [AuthViewState] with initial values
  const AuthViewState.initial() : this(authenticating: false);

  @override
  List<Object?> get props => <Object?>[authenticating];
}
