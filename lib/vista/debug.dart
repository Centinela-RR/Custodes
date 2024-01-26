import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../modelo/db.dart';

class DebugApp extends StatefulWidget {
  const DebugApp({super.key});

  @override
  DebugAppState createState() => DebugAppState();
}

class DebugAppState extends State<DebugApp> {
  String buttonText = 'Sugma';
  String buttonTitle = '';
  FirebaseConnection fb = FirebaseConnection();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debug App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(buttonText),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 20.0, height: 100.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Custodia tu',
                    style: TextStyle(fontSize: 43.0),
                  ),
                ),
                const SizedBox(width: 20.0, height: 100.0),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Horizon',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Seguridad'),
                      RotateAnimatedText('Paz'),
                      RotateAnimatedText('Tranquilidad'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                    isRepeatingAnimation: false,
                    totalRepeatCount: 3,
                    pause: const Duration(milliseconds: 0),

                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      buttonTitle = "Botón 1";
                      buttonText = fb.generateLocalIdentifier();
                    });
                    _showAlertDialog(context, buttonTitle, buttonText);
                  },
                  child: const Text("Botón 1"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      buttonTitle = "Botón 2";
                      buttonText = fb.generateLocalIdentifier();
                    });
                    _showAlertDialog(context, buttonTitle, buttonText);
                  },
                  child: const Text("Botón 2"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(buttonTitle),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
