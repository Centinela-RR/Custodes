import 'package:flutter/material.dart'
    show
        AlertDialog,
        BuildContext,
        Navigator,
        Text,
        TextButton,
        Widget,
        showAdaptiveDialog;

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

class FutureFunctions {
  Future<void> showAlertDialog(BuildContext context, String title,
      String message, String butText) async {
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

  Future<void> showConfirmationDialog(BuildContext context, String title,
      String message, String butText1, String butText2, Function action) async {
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
              child: Text(butText1),
            ),
            TextButton(
              onPressed: () {
                action();
                Navigator.of(context).pop();
              },
              child: Text(butText2),
            ),
          ],
        );
      },
    );
  }
}
