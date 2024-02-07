import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
//import 'package:custodes/vista/debug.dart';
import 'package:custodes/vista/inicio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget
{
  const SplashScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
          gifPath: 'assets/splash.gif',
          //gifWidth: 269,
          //gifHeight: 474,
          //duration: const Duration(milliseconds: 3515),
          gifWidth: 202,
          gifHeight: 360,
          backgroundColor: const Color.fromRGBO(206, 229, 208, 1.0),
          nextScreen: const MainApp(), //* Al terminar la splashscreen, nos abre MainApp en inicio.dart
          //nextScreen: const DebugApp(), 
          duration: const Duration(milliseconds: 4500),

          onInit: () async {
            debugPrint("onInit");
          },
          onEnd: () async {
            debugPrint("onEnd 1");
          },
        );
  }
  
}