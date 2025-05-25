import 'package:example/application/services/error_handler_service.dart';
import 'package:example/domain/use_cases/auth/auth.usecase.dart';
import 'package:example/foundation/extensions/strings.dart';
import 'package:example/foundation/extensions/widgets.dart';
import 'package:example/foundation/localizations/localizations.dart';
import 'package:flueco/flueco.dart' show FluecoSR, RoutePage;
import 'package:flueco_state_management/flueco_state_management.dart'
    show ChangeNotifierProvider, ViewModel;
import 'package:flutter/material.dart';

import 'auth.viewmodel.dart';

///
@RoutePage(name: 'AuthRoute')
class AuthView extends StatelessWidget {
  ///
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AuthProvider(
      child: _AuthViewBody(),
    );
  }
}

class _AuthViewBody extends StatelessWidget {
  const _AuthViewBody();

  @override
  Widget build(BuildContext context) {
    final AuthViewModel viewModel = ViewModel.read<AuthViewModel>(context);

    return Scaffold(
      body: Form(
        key: viewModel.formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: viewModel.emailController,
                  validator: viewModel.validateEmail,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.email.tr(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      viewModel.passwordFocusNode.requestFocus(),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: true,
                  controller: viewModel.passwordController,
                  validator: viewModel.validatePassword,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.password.tr(),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (_) => viewModel.handleContinue(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: viewModel.handleContinue,
                      child: LocaleKeys.submit.tr().text().atLeft(
                            spacing: 8,
                            of: Icons.arrow_right.icon(),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthProvider extends StatelessWidget {
  const _AuthProvider({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AuthUseCase useCase = FluecoSR.of(context).resolve<AuthUseCase>();
    final ErrorHandler errorHandler =
        FluecoSR.of(context).resolve<ErrorHandler>();

    return ChangeNotifierProvider<AuthViewModel>(
      create: (_) {
        return AuthViewModel(
          authUseCase: useCase,
          errorHandler: errorHandler,
        );
      },
      builder: (_, __) {
        return child;
      },
    );
  }
}
