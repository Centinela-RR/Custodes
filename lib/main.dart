//import 'package:custodes/vista/prueba.dart'; // Importa el widget desde prueba.dart
import 'package:custodes/vista/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'modelo/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ejecuta la aplicación con el widget desde prueba.dart
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(), // Usa el widget desde prueba.dart aquí
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), //* Empezar con la splashscreen, en splashscreen.dart
    );
  }
}