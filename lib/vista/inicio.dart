import 'package:custodes/vista/login.dart';
//import 'package:custodes/vista/prueba_inicio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Si estamos esperando una respuesta de autenticación,
          // se puede mostrar un indicador de carga o algo similar
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // Si hay un usuario autenticado, muestra la pantalla de inicio
          print('Entró a InicioPage');
          return const SizedBox(); // No se muestra ninguna pantalla
        } else {
          // Si no hay un usuario autenticado, muestra la pantalla de inicio de sesión
          print('Entró a LoginPage');
          return const LoginPage();
        }
      },
    );
  }
}
