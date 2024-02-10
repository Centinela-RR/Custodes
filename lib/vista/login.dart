import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  late String _verificationId;
  int? _resendToken;

  Future<void> _verifyPhoneNumber() async {
    // Validar que el número de teléfono no esté vacío
    // TODO: No ejecutar la espera si el número de teléfono está vacío
    if (_phoneNumberController.text.isEmpty) {
      //Show alert dialog
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('Error'),
            content:
                const Text('Por favor introduzca un número de teléfono válido'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    verificationCompleted(AuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
    }

    verificationFailed(FirebaseAuthException authException) {
      debugPrint('${authException.message}');
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
      phoneNumber: '+52${_phoneNumberController.text}',
      // Expira en 60 segundos
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> _signInWithPhoneNumber() async {
    if (_smsCodeController.text.isEmpty) {
      // Mostar alerta
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('Error'),
            content: const Text(
                'Por favor introduzca su código SMS recibido, si no lo ha recibido solicite uno nuevo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsCodeController.text,
    );

    await _auth.signInWithCredential(credential);
    debugPrint(
        'Should go to the next screen by now! Usuario: ${_auth.currentUser!.uid}');
    // TODO: How can we go to the next screen without using buildContext since it's not available here?
    // FIXME: This alert isn't showing up
    AlertDialog.adaptive(
      title: const Text('Éxito'),
      content: const Text('Inicio de sesión exitoso'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
    // ! Don't use 'BuildContext's across async gaps.
    // ! This is a bad practice and can lead to memory leaks.
    // ! Use a 'StatefulWidget' to handle the 'BuildContext' and pass it to the function.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                  labelText: 'Número celular',
                  prefixIcon: Icon(Icons.phone),
                  prefixText: '+52 '),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _smsCodeController,
              decoration: const InputDecoration(
                  labelText: 'Código SMS', prefixIcon: Icon(Icons.sms)),
            ),
            const SizedBox(height: 16.0),
            BtnSms(onButtonPressed: _verifyPhoneNumber),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signInWithPhoneNumber,
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

class BtnSms extends StatefulWidget {
  final VoidCallback onButtonPressed;
  const BtnSms({super.key, required this.onButtonPressed});

  @override
  BtnSmsState createState() => BtnSmsState();
}

class BtnSmsState extends State<BtnSms> {
  late Timer _timer;
  int _start = 60;
  bool _isButtonDisabled = false;
  String _buttonText = 'Enviar código SMS';

  void startTimer() {
    _isButtonDisabled = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start < 1) {
          timer.cancel();
          _buttonText = 'Enviar código SMS';
          _isButtonDisabled = false;
          if (mounted) {
            setState(() {});
          }
        } else {
          _start = _start - 1;
          _buttonText = 'Reenviar código en $_start';
          if (mounted) {
            setState(() {});
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isButtonDisabled
          ? null
          : () {
              widget.onButtonPressed();
              setState(() {
                _start = 60;
                _buttonText = 'Reenviar código en $_start';
              });
              startTimer();
            },
      child: Text(_buttonText),
    );
  }
}
