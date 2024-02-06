import 'package:flutter/material.dart';

class CustomAlert extends ChangeNotifier {
  Future<void> showAuthAlertDialog(
      bool dismissible,
      BuildContext context,
      String? alertTitle,
      String? errorMessage,
      String? btnText,
      VoidCallback? onTextBtnPressed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            alertTitle ?? 'Error',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorMessage ?? 'An error Occured',
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onTextBtnPressed,
              child: Text(btnText ?? 'Okay',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        );
      },
    );
  }
}
