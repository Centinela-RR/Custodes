import 'package:flutter/material.dart';

class Functions {
  void showAlertDialog(BuildContext context, String title, String message,
      String butText) async {
    await showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(butText),
            ),
          ],
        );
      },
    );
  }
}