import 'package:custodes/vista/login.dart';
import 'package:custodes/vista/prueba_inicio.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const AuthCheck(), // * Verifica el estado de autenticación
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();

  // Método estático para acceder al estado del widget desde cualquier lugar de la jerarquía de widgets
  static _AuthCheckState? of(BuildContext context) => context.findAncestorStateOfType<_AuthCheckState>();
}

class _AuthCheckState extends State<AuthCheck> {
  // Variable estática para controlar el estado de autenticación
  static bool _isLoggedIn = true;

  // Método para actualizar el estado _isLoggedIn
  void updateLoginStatus() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      print('Entró a InicioPage');
      return const MyPruebaWidget(); // Mostrar la pantalla de inicio
    } else {
      print('Entró a LoginPage');
      return const LoginPage(); // Mostrar la pantalla de inicio de sesión
    }
  }
}