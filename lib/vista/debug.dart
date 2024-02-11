import 'dart:async';
import 'package:flutter/material.dart';
import '../modelo/db.dart';
import 'package:custodes/controlador/reportes.dart';

class DebugApp extends StatefulWidget {
  const DebugApp({super.key});

  @override
  DebugAppState createState() => DebugAppState();
}

class DebugAppState extends State<DebugApp> {
  late String widgetTitle, uniqId;
  String buttonTitle = '';
  FirebaseConnection fb = FirebaseConnection();
  Reportes reportes = Reportes();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    widgetTitle = ''; // Initial value
    uniqId = 'b'; // Initial value
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 438), (timer) {
      setState(() {
        // Change the value of widgetTitle here
        widgetTitle = widgetTitle == "Ku" ? "Chau" : "Ku";
        //uniqId = fb.generateLocalIdentifier();
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
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //const SizedBox(width: 20.0, height: 100.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Custodia tu vida:)',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                SizedBox(width: 5.0, height: 10.0),
              ],
            ),
            Text(
                "Unique id: $uniqId"), // Display uniqId directly as Text widget
            const SizedBox(height: 20), // Add some spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonTitle = "Preparar información";
                      uniqId = fb.generateLocalIdentifier();
                      reportes.generarReporte(
                          idUsuario: 'test',
                          ubicacion: 'test2',
                          tipoReporte: 6);
                    });
                    fb.addNewElement();
                    _showAlertDialog(context, buttonTitle, uniqId);
                  },
                  child: const Text("Preparar información"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonTitle = "Enviar información";
                      uniqId = fb.generateLocalIdentifier();
                    });
                    String res = reportes.enviarReporte();
                    if (!res.contains("Error")) {
                      _showAlertDialog(context, "Success!",
                          "Report sent succesfully! Result: $res");
                    } else {
                      _showAlertDialog(context, "Error", res);
                    }
                    //fb.fetchElement();
                    _showAlertDialog(context, buttonTitle, uniqId);
                  },
                  child: const Text("Enviar información"),
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
        return AlertDialog.adaptive(
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

class SpinningCylinderState extends State<SpinningCylinder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 438 * 4),
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
