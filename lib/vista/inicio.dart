import 'package:custodes/controlador/widgets/run_app.dart';
import 'package:custodes/vista/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget getHomePage() {
    // Cambia esta línea para cambiar la vista de inicio
    return const LoginPage();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // * Cambio de MaterialApp a CupertinoApp, en base a la plataforma utilizada
    return PlatformApp(
      home: getHomePage(),
    );
  }
}
