import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


/// Modal service
class ModalService {
  final NavigatorKeyProvider _navigatorKeyProvider;

  ModalService({
    required NavigatorKeyProvider navigatorKeyProvider,
  }) : _navigatorKeyProvider = navigatorKeyProvider;

  Future<T?> showModal<T>(WidgetBuilder builder) async {
    final BuildContext? context =
        _navigatorKeyProvider.navigatorKey.currentContext;
    if (context == null) {
      return null;
    }
    final result = await showMaterialModalBottomSheet<T>(
      context: context,
      builder: builder,
    );
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return result;
  }
}
