import 'dart:async';
import 'package:custodes/controlador/sistema/auth.dart';
import 'package:flutter/material.dart';
import '../modelo/db.dart';
import 'package:custodes/controlador/reportes.dart';

class DebugApp extends StatefulWidget {
  const DebugApp({super.key});

  @override
  DebugAppState createState() => DebugAppState();
}

class DebugAppState extends State<DebugApp> {
  // Firebase connection controller
  FirebaseConnection fb = FirebaseConnection();

  // User authentication controller
  UserAuth auth = UserAuth();
  // Reportes controller
  Reportes reportes = Reportes();

  late String widgetTitle, uniqId;
  String buttonTitle = '';
  Timer? timer;
  bool _buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    debugPrint('Usuario: ${auth.getUid() ?? "null"}');
    widgetTitle = 'Debug View'; // Initial value
    uniqId = 'b'; // Initial value
    //startTimer();
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
    if (timer?.isActive ?? false) {
      timer
          ?.cancel(); // Cancel the timer if it got initialized to avoid memory leaks
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custodes - Debug App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widgetTitle),
        ),
        body: //const SplashScreen3(),
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const SpinningCylinder(), // This for a spinning bean, fucks up the emulator - Slow af
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
                    uniqId = fb.generateLocalIdentifier();
                    //String usuario = fb.getUsuario();
                    String usuario = auth.getUid() ?? 'null';
                    String ubicacionTr = 'test2';
                    int reporteType = 6;
                    reportes.generarReporte(
                        idUsuario: usuario,
                        ubicacion: ubicacionTr,
                        tipoReporte: reporteType);
                    //fb.addNewElement();
                    _showAlertDialog(
                        context,
                        'Información preparada para ser reportada exitosamente',
                        'idUsuario: $usuario \nubicacion: $ubicacionTr \ntipoReporte: $reporteType');
                    setState(() {
                      _buttonEnabled = true;
                    });
                  },
                  child: const Text("Preparar información"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  // Está habilitado? Si no, no hace nada (null), si está habilitado ejecuta la función
                  onPressed: _buttonEnabled
                      ? () async {
                          String res = await reportes.enviarReporte();
                          if (!mounted) {
                            return;
                          }
                          if (!res.contains("Error")) {
                            _showAlertDialog(context, "Éxito!",
                                "Reporte enviado satisfactoriamente!\nDetalles: \n$res");
                          } else {
                            _showAlertDialog(context, "Error", res);
                            return;
                          }
                          setState(() {
                            _buttonEnabled = false;
                          });
                          //fb.fetchElement();
                        }
                      : null,
                  child: const Text("Enviar información"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Acciones al presionar el botón
                    debugPrint('Botón presionado');
                    await showAdaptiveDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog.adaptive(
                          title: const Text('Gracias por utilizar Custodes!'),
                          content: const Text(
                              'Esperamos que hayas tenido una buena experiencia. ¡Hasta luego!'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Nos vemos!'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    await auth.signOut();
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthCheck()),
                    );
                  },
                  child: const Text('Cerrar sesión'),
                ),
              ],
            )
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
          title: Text(title),
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
