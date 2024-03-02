import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:custodes/controlador/sistema/auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      gifPath: 'assets/splash.gif',
      gifWidth: 202,
      gifHeight: 360,
      backgroundColor: const Color.fromARGB(255, 206, 229, 208),
      nextScreen:
          const AuthCheck(), // * Al terminar la splashscreen, nos abre el chequeo de autenticación
      duration: const Duration(milliseconds: 4500),

      onInit: () async {
        debugPrint("Animación iniciada");
      },
      onEnd: () async {
        debugPrint("Animación terminada");
      },
    );
  }
}
