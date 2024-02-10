import 'package:custodes/vista/login.dart';
import 'package:flutter/material.dart';
import 'package:custodes/vista/mapa.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custodes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          const Mapa(), // * Cambiar a la vista de inicio de sesión, actualmente envia al mapa
    );
  }
}
