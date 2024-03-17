import 'package:flueco/flueco.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/use_cases/logout/logout.usecase.dart';
import '../../../../../foundation/extensions/strings.dart';

///
@RoutePage(name: 'HomeRoute')
class HomeView extends StatelessWidget {
  ///
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final LogoutUseCase useCase = FluecoSR.of(context).resolve<LogoutUseCase>();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: useCase.execute,
            icon: Icons.logout.icon(),
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Home',
        ),
      ),
    );
  }
}
