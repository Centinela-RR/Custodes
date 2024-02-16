//import 'package:firebase_app_check/firebase_app_check.dart';
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

  // Prevent abuse of the app by using Firebase App Check - GOD FUCKING DAMN IT FOR APPLE WE NEED DEV ACCOUNT, FUCK
  /*await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.debug,
  );*/

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
