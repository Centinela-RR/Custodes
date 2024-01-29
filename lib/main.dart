import 'package:custodes/vista/debug.dart';
//import 'package:custodes/vista/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'modelo/firebase_options.dart';
import 'package:flutter/material.dart';
//import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Run the app
  runApp(const MaterialApp(home: DebugApp()));
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
    @override
  Widget build(BuildContext context){
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DebugApp(),//SplashScreen aún no tiene un archivo
      );
    }
}