import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Service to show modals to the user.
///
/// This class provides methods to show modals to the user.
///
/// To use this service, you need to get an instance
/// through the service locator system using `FluecoSR.of<ModalService>(context)`
/// or dependency injection system by having the `ModalService` as a dependency in your class.
///
/// ```dart
/// final modalService = ModalService(
///   navigatorKeyProvider: navigatorKeyProvider,
/// );
/// ```
///
/// To show a modal, you can use the [showModal] method:
///
/// ```dart
/// await modalService.showModal(
///   (context) {
///     return Container(
///       color: Colors.white,
///       child: const Text('Hello, World!'),
///     );
///   },
/// );
/// ```
class ModalService {
  final NavigatorKeyProvider _navigatorKeyProvider;

  /// Create a new instance of [ModalService].
  ModalService({
    required NavigatorKeyProvider navigatorKeyProvider,
  }) : _navigatorKeyProvider = navigatorKeyProvider;

  /// Show a modal to the user.
  ///
  /// The [builder] parameter is used to build the modal.
  /// The [showMaterial] parameter is used to show a material modal or a cupertino modal.
  Future<T?> showModal<T>(
    WidgetBuilder builder, {
    bool showMaterial = true,
  }) async {
    final BuildContext? context =
        _navigatorKeyProvider.navigatorKey.currentContext;
    if (context == null) {
      return null;
    }

    final future = showMaterial
        ? showMaterialModalBottomSheet<T>(
            context: context,
            builder: builder,
          )
        : showCupertinoModalBottomSheet<T>(context: context, builder: builder);
    final result = await future;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return result;
  }
}
