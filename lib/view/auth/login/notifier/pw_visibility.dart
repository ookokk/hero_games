import 'package:flutter/material.dart';

class PasswordVisibilityNotifier extends InheritedWidget {
  final bool isPasswordObscured;
  final VoidCallback togglePasswordVisibility;

  const PasswordVisibilityNotifier({
    super.key,
    required this.isPasswordObscured,
    required this.togglePasswordVisibility,
    required Widget child,
  }) : super(child: child);

  static PasswordVisibilityNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PasswordVisibilityNotifier>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
