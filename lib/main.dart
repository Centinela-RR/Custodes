// Importa las librerías necesarias

// Firestore
import 'package:firebase_core/firebase_core.dart';
import 'modelo/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Vistas
import 'package:custodes/vista/splashscreen.dart';

// Flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widgets
import 'package:custodes/controlador/widgets/run_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const bool useEmulator = true;

  if (useEmulator) {
    // [Authentication | localhost:9099]
    await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);

    // Setting the emulator after a hot restart breaks Firestore.
    // See: https://github.com/FirebaseExtended/flutterfire/issues/6216

    // [Firestore | localhost:8080]
    try {
      FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
    } catch (error) {
      // throws a JavaScript object instead of a FirebaseException
      final String code = (error as dynamic).code;
      if (code != "failed-precondition") {
        rethrow;
      }
    }
  }

  // Ejecuta la aplicación con el widget desde prueba.dart
  runApp(const PlatformApp(home: SplashScreen()));
}
