//import 'package:custodes/vista/debug.dart' show DebugApp;
import 'package:custodes/vista/login.dart' show LoginPage;
import 'package:custodes/vista/map.dart' show MapBuild;

//import 'package:custodes/vista/prueba_inicio.dart' show MyPruebaWidget;

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, PhoneAuthProvider, AuthCredential, FirebaseAuthException;
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  AuthCheckState createState() => AuthCheckState();

  // Método estático para acceder al estado del widget desde cualquier lugar de la jerarquía de widgets
  static AuthCheckState? of(BuildContext context) =>
      context.findAncestorStateOfType<AuthCheckState>();
}

class AuthCheckState extends State<AuthCheck> {
  // Variable para controlar el estado de autenticación
  bool _isLoggedIn = false;

  // A donde se va a ir después de la autenticación?
  final Widget nextScreen = const MapBuild();
  //final Widget nextScreen = const MyPruebaWidget();

  // Método para actualizar el estado _isLoggedIn con el valor de las preferencias compartidas
  void updateLoginStatus() async {
    bool loginStatus = await getLoginStatus();
    setState(() {
      _isLoggedIn = loginStatus;
    });
  }

  // Método para establecer el estado de autenticación en las preferencias compartidas
  void setLoginStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!value) {
      prefs.remove('uid');
      prefs.remove('isLoggedIn');
    } else {
      prefs.setString('uid', UserAuth().getUid() ?? '');
      prefs.setBool('isLoggedIn', value);
    }
    updateLoginStatus();
  }

  // Método para obtener el estado de autenticación desde las preferencias compartidas
  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Método para inicializar el estado del widget
  @override
  void initState() {
    super.initState();
    // Inicializar el estado de autenticación
    // Funciona como un constructor, pero se ejecuta después de que el widget se ha insertado en el árbol de widgets
    // 1. Obtiene el estado de autenticación desde las preferencias compartidas con el método 'getLoginStatus'
    // 2. Espera a que termine la operación
    // 3. Establece el estado de autenticación en la variable 'status'
    // 4. Asigna el valor de 'status' a la variable '_isLoggedIn' con el método 'setLoginStatus'
    // 5. Actualiza el estado de autenticación con el método 'updateLoginStatus'
    getLoginStatus().then((bool status) {
      setLoginStatus(status);
    });
    updateLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator
              .adaptive(); // Mostrar un indicador de progreso en lo que se verifica el estado de autenticación
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            _isLoggedIn = snapshot.data ?? false;
            if (_isLoggedIn) {
              debugPrint('Entró a InicioPage');
              return nextScreen; // Mostrar la pantalla de inicio
            } else {
              debugPrint('Entró a LoginPage');
              return const LoginPage(); // Mostrar la pantalla de acceso al sistema
            }
          }
        }
      },
    );
  }
}

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _verificationId = '';
  int? _resendToken = 0;

  Future<void> signInWithPhone({required String phoneNumber}) async {
    verificationCompleted(AuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
    }

    verificationFailed(FirebaseAuthException authException) {
      throw Exception(authException.message);
    }

    codeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
    }

    codeSent(String verificationId, int? resendToken) {
      // Almacenar el verificationId y resendToken
      _verificationId = verificationId;
      _resendToken = resendToken;
    }

    await _auth.verifyPhoneNumber(
      // Agregar +52 para limitar el acceso a gente de México
      phoneNumber: '+52$phoneNumber',
      // Expira en 60 segundos
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  // Método para obtener el identificador único del usuario
  String? getUid() {
    return _auth.currentUser?.uid;
  }

  // Método para verificar el código de verificación
  Future<bool> verifyPhoneCode({required String smsCode}) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    try {
      await _auth.signInWithCredential(credential);
      debugPrint('Should go to the next screen by now! Usuario: ${getUid()}');
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  // Método para cerrar la sesión del usuario
  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
    prefs.remove('isLoggedIn');
    await _auth.signOut();
  }
}
