import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAlert extends StatelessWidget {
  const ShowAlert({
    super.key,
    required this.context,
    required this.title,
    required this.content,
    required this.actions,
  });

  final BuildContext context;
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    }
    throw Exception('ShowAlert function must return a Widget.');
  }
}
