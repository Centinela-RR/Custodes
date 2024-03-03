import 'dart:async';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:custodes/controlador/sistema/auth.dart';
import 'package:flutter/material.dart';
import '../modelo/db.dart';
import 'package:custodes/controlador/reportes.dart' as reportes;
import 'package:custodes/controlador/sistema/general.dart' as sysfunc;
import 'package:custodes/controlador/sistema/widgets.dart' as syswid;

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
  reportes.Functions repFun = reportes.Functions();
  reportes.Buttons repBut = reportes.Buttons();
  sysfunc.Functions sysfun = sysfunc.Functions();

  late String widgetTitle, uniqId;
  String buttonTitle = '';
  Timer? timer;

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
      home: ConnectivityWidgetWrapper(
          disableInteraction: true,
          offlineWidget: syswid.Widgets.offlineMessage(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(widgetTitle),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SpinningCylinder(), // This for a spinning bean, fucks up the emulator - Slow af
                const SizedBox(height: 20), // Add some spacing
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
                    repBut.buttonRep(
                        context: context, ubicacion: 'here', tipoReporte: 1),
                    const SizedBox(width: 20),
                    repBut.buttonRep(
                        context: context, ubicacion: 'there', tipoReporte: 2),
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
                        sysfun.showAlertDialog(
                            context,
                            'Gracias por utilizar Custodes',
                            'Esperamos que hayas tenido una buena experiencia. ¡Hasta luego!',
                            'Nos vemos!');
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
          )),
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
