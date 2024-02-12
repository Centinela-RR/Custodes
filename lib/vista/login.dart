import 'package:custodes/modelo/db.dart';
import 'package:custodes/vista/prueba_inicio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // ! This is the widget to show after login
  final Widget afterLogin = const MyPruebaWidget();

  // User authentication controller
  UserAuth auth = UserAuth();

  // Controllers for the text fields
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  Future<void> persistLogin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  Future<void> _verifyPhoneNumber() async {
    // Validar que el número de teléfono no esté vacío
    // TODO: No ejecutar la espera si el número de teléfono está vacío
    // TODO: Solicitar confirmación al usuario de si su teléfono está correcto o no
    // TODO: Asegurarse que sean 10 dígitos o cancelar la operación
    // TODO: Cambiar la caja de texto para que solo acepte números, usando teclado numérico
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
    auth.signInWithPhone(phoneNumber: _phoneNumberController.text);
  }

  Future<void> _signInWithPhoneNumber() async {
    if (_smsCodeController.text.isEmpty) {
      // Mostar alerta
      await showAdaptiveDialog(
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
    Future<bool> res = auth.verifyPhoneCode(smsCode: _smsCodeController.text);
    if (await res && context.mounted) {
      persistLogin(true);
      await showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
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
              ));
      // Repeat cuz if alert isn't closed, it will throw an error
      if (!context.mounted) return;
      Navigator.push(
          context,
          MaterialPageRoute<void>(
            // Aquí se cambia el widget a mostrar
            builder: (BuildContext context) => afterLogin,
          ));
    } else if (!await res && context.mounted) {
      await showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
                title: const Text('Error'),
                content: const Text(
                    'Algo ha salido mal, por favor espere unos minutos e inténtelo de nuevo.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
    }
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
