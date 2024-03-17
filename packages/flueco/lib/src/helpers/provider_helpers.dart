import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Read a viewmodel in context
T readOn<T>(BuildContext context) {
  return Provider.of<T>(context, listen: false);
}

/// Watch a viewmodel property in context
R selectOn<T, R>(BuildContext context, R Function(T value) selector) {
  return context.select<T, R>(selector);
}

/// Watch a viewmodel in context
T watchOn<T>(BuildContext context) {
  return Provider.of<T>(context, listen: true);
}
