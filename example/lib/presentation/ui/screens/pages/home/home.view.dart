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
    final dialogService = FluecoSR.of(context).resolve<DialogService>();
    final modalService = FluecoSR.of(context).resolve<ModalService>();
    final toastService = FluecoSR.of(context).resolve<ToastService>();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: useCase.execute,
            icon: Icons.logout.icon(),
          )
        ],
      ),
      body: Center(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await dialogService.alert(
                  data: AlertDialogData(
                    title: 'Dialog service',
                    content: 'This is a dialog from DialogService.',
                  ),
                );
              },
              child: const Text('Show dialog'),
            ),
            ElevatedButton(
              onPressed: () async {
                await modalService.showModal(
                  (modalContext) => Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'This is a modal from ModalService.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => Navigator.of(modalContext).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Show modal'),
            ),
            ElevatedButton(
              onPressed: () async {
                await toastService.show('This is a toast from ToastService.');
              },
              child: const Text('Show toast'),
            ),
          ],
        ),
      ),
    );
  }
}
