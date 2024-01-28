import 'package:custodes/vista/debug.dart';
import 'package:custodes/vista/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Run the app
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
    @override
  Widget build(BuildContext context){
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }
}



