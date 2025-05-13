import 'package:flutter/material.dart';

class Modals {
  static Future<T?> openModal<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool? barrierDismissible,
    Color? barrierColor,
    RouteSettings? routeSettings,
  }) async {
    return showDialog<T>(
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: barrierColor ?? Colors.black.withAlpha(50),
      context: context,
      routeSettings: routeSettings,
      builder: (context) => Center(
        child: Material(
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: builder(context),
          ),
        ),
      ),
    );
  }
}
