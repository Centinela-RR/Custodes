//import 'package:custodes/vista/prueba.dart'; // Importa el widget desde prueba.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custodes/vista/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'modelo/firebase_options.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Emulador de Firebase: true para usar el emulador, false para usar la base de datos en la nube
  // No usar la nube porque +10 mensajes por mes cuestan dinero :'D
  const bool useEmulator = true;
  const String host = "10.0.0.8";

  // ignore: dead_code
  if (useEmulator) {
    // [Authentication | localhost:9099]
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);

    // Setting the emulator after a hot restart breaks Firestore.
    // See: https://github.com/FirebaseExtended/flutterfire/issues/6216

    // [Firestore | localhost:8080]
    try {
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    } catch (error) {
      // throws a JavaScript object instead of a FirebaseException
      final String code = (error as dynamic).code;
      if (code != "failed-precondition") {
        rethrow;
      }
    }
  }

  // Ejecuta la aplicación con el widget desde prueba.dart
  runApp(const StartApp());
}

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Custodes',
      debugShowCheckedModeBanner: false,
      home:
          SplashScreen(), //* Empezar con la splashscreen, en splashscreen.dart
    );
  }
}
