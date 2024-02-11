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
      //home: const LoginPage(), // * Verifica el estado de autenticación
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  AuthCheckState createState() => AuthCheckState();

  // Método estático para acceder al estado del widget desde cualquier lugar de la jerarquía de widgets
  static AuthCheckState? of(BuildContext context) =>
      context.findAncestorStateOfType<AuthCheckState>();
}

class AuthCheckState extends State<AuthCheck> {
  LoginPageState loginPageState = LoginPageState();

  // Variable para controlar el estado de autenticación
  bool _isLoggedIn = false;

  // Método para actualizar el estado _isLoggedIn
  void updateLoginStatus() async {
    bool loginStatus = await getLoginStatus();
    setState(() {
      _isLoggedIn = loginStatus;
    });
  }

  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    getLoginStatus();
    if (_isLoggedIn) {
      debugPrint('Entró a InicioPage');
      return const MyPruebaWidget(); // Mostrar la pantalla de inicio
    } else {
      debugPrint('Entró a LoginPage');
      return const LoginPage(); // Mostrar la pantalla de inicio de sesión
    }
  }
}
