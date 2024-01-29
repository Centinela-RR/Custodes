import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../modelo/db.dart';

class DebugApp extends StatefulWidget {
  const DebugApp({super.key});

  @override
  DebugAppState createState() => DebugAppState();
}

class DebugAppState extends State<DebugApp> {
  late String widgetTitle, uniqId;
  String buttonTitle = '';
  FirebaseConnection fb = FirebaseConnection();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    widgetTitle = ''; // Initial value
    uniqId = ''; // Initial value
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 438), (timer) {
      setState(() {
        // Change the value of widgetTitle here
        widgetTitle = widgetTitle == "Fuck" ? "This" : "Fuck"; 
        uniqId = fb.generateLocalIdentifier();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custodes - Debug App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(widgetTitle),
        ),
        body: //const SplashScreen3(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinningCylinder(), // This for a spinning bean
            const SizedBox(height: 20), // Add some spacing
            Row(
              mainAxisSize: MainAxisSize.min,
              children: 
              // FIXME: wtf why does this not show up in mobile?
              <Widget>[
                //const SizedBox(width: 20.0, height: 100.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Custodia tu',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                const SizedBox(width: 5.0, height: 10.0),
                SizedBox(
                  // FIXME: If width too big, breaks mobile too
                  // JK IT DOESNT SHOW AT ALL FUCK WHY TF DOES IT SHOW IN WEB BUT NOT IN IOS DUD WTFFF
                  // Se ve bonito en web pero en iOS no sale at all wtf
                  width: 90,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Horizon',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText('Seguridad', alignment: Alignment.centerLeft, transitionHeight: 20),
                        RotateAnimatedText('Paz', alignment: Alignment.centerLeft, transitionHeight: 20),
                        RotateAnimatedText('Tranquilidad', alignment: Alignment.centerLeft, transitionHeight: 20),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                      /*onFinished: () {
                        //FIXME: FUCKING MAKE THIS SHOW LAST AND NOT LEAVE FFS
                        RotateAnimatedText('aaa', alignment: Alignment.center);
                      },*/
                      //isRepeatingAnimation: true,
                      //totalRepeatCount: 1,
                      repeatForever: true,
                      pause: const Duration(milliseconds: 50),
                    ),
                  ),
                )
              ],
            ),
            Text("Unique id: $uniqId"), // Display uniqId directly as Text widget
            const SizedBox(height: 20), // Add some spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonTitle = "Botón 1";
                      uniqId = fb.generateLocalIdentifier();
                    });
                    _showAlertDialog(context, buttonTitle, uniqId);
                  },
                  child: const Text("Botón 1"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonTitle = "Botón 2";
                      uniqId = fb.generateLocalIdentifier();
                    });
                    _showAlertDialog(context, buttonTitle, uniqId);
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


class SpinningCylinder extends StatefulWidget {
  const SpinningCylinder({super.key});

  @override
  SpinningCylinderState createState() => SpinningCylinderState();
}

class SpinningCylinderState extends State<SpinningCylinder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 438*4),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: 100,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue, // You can adjust the color as needed
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}