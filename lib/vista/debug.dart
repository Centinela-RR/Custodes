import 'dart:async';
import 'package:flutter/material.dart';
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
      title: 'Debug App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(widgetTitle),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinningCylinder(), // Add SpinningWheel_TODO here
            const SizedBox(height: 20), // Add some spacing
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