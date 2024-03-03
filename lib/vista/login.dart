import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:custodes/controlador/sistema/auth.dart';
//import 'package:custodes/vista/debug.dart';
import 'package:custodes/vista/prueba_inicio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart'
    show MaskedInputFormatter, toNumericString;
import 'dart:async';
import 'package:custodes/controlador/sistema/widgets.dart' as syswid;

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // This is the widget to show after login
  final Widget afterLogin = const MyPruebaWidget();

  // User authentication controller
  UserAuth auth = UserAuth();

  // Controllers for the text fields
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  Future<void> persistLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = UserAuth().getUid() ?? '';
    if (uid.isEmpty) return;
    prefs.setString('uid', uid);
    prefs.setBool('isLoggedIn', true);
  }

  Future<void> _verifyPhoneNumber() async {
    // No ejecuta la espera si el número de teléfono está vacío, contiene texto o son menos de 10 dígitos
    // La caja de texto solo acepta números, usando teclado numérico
    String phone = toNumericString(_phoneNumberController.text);
    if (!phone.contains('Reenviar')) {
      auth.signInWithPhone(phoneNumber: phone).catchError((error) {
        // Si encuentra una excepción, imprime el error y muestra un diálogo de alerta
        debugPrint(error.toString());
        showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              title: const Text('Error'),
              content: const Text(
                  'Ha sucedido un error, por favor asegúrese de contar con una conexión a internet estable y vuelva a intentarlo más tarde.'),
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
      });
    }
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
      persistLogin();
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
    return ConnectivityWidgetWrapper(
        offlineWidget: syswid.Widgets.offlineMessage(context),
        disableInteraction: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Bienvenido!'),
            automaticallyImplyLeading: false,
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
                      prefixIcon: Icon(CupertinoIcons.phone_fill),
                      prefixText: '+52 '),
                  // Cambiar el teclado a numérico
                  keyboardType: TextInputType.phone,
                  // Limitar la longitud del número de teléfono a 10 dígitos
                  inputFormatters: [MaskedInputFormatter('(###) ### - ####')],
                  maxLength: 16,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _smsCodeController,
                  decoration: const InputDecoration(
                      labelText: 'Código SMS',
                      prefixIcon: Icon(CupertinoIcons.bubble_left_fill)),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                // Botón para enviar SMS
                BtnSms(
                    // Función que se ejecuta al presionar el botón
                    onButtonPressed: _verifyPhoneNumber,
                    // Controlador del número de teléfono
                    phoneController: _phoneNumberController),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _signInWithPhoneNumber,
                  child: const Text('Iniciar sesión'),
                ),
              ],
            ),
          ),
        ));
  }
}

// Widget para el botón de enviar SMS
class BtnSms extends StatefulWidget {
  final VoidCallback onButtonPressed;
  final TextEditingController phoneController;
  const BtnSms(
      {super.key,
      required this.onButtonPressed,
      required this.phoneController});

  @override
  BtnSmsState createState() => BtnSmsState();
}

class BtnSmsState extends State<BtnSms> {
  Timer? _timer;
  int _start = 60;
  bool _isButtonDisabled = false;
  String _buttonText = 'Enviar código SMS';

  // Empieza el temporizador donde se deshabilita el botón por 60 segundos
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
    if (_timer?.isActive ?? false) {
      _timer
          ?.cancel(); // Cancel the timer if it got initialized to avoid memory leaks
    }
    super.dispose();
  }

  // Verifica si el número de teléfono está vacío, contiene texto o son menos de 10 dígitos
  bool isValidPhoneNumber(String input) {
    final RegExp regex = RegExp(r'^\+?[1-9]\d{1,14}$');
    if (input.isEmpty || input.length < 10 || !regex.hasMatch(input)) {
      return false;
    }
    return true;
  }

  String formatPhoneNumber(String phone) {
    phone = toNumericString(phone);
    if (phone.length < 10) return phone;
    return '+52 (${phone.substring(0, 3)}) ${phone.substring(3, 6)} - ${phone.substring(6)}';
  }

  // Solicitar confirmación al usuario de si su teléfono está correcto o no
  Future<bool> confirmPhoneNumber() async {
    bool? result = await showAdaptiveDialog<bool>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Confirmar número de teléfono'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Es este su número de teléfono?'),
                Text(formatPhoneNumber(widget.phoneController.text)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    // If result is null, return false. Otherwise, return the result.
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isButtonDisabled
          ? null
          : () async {
              String phone = toNumericString(widget.phoneController.text);
              if (!isValidPhoneNumber(phone)) {
                //Show alert dialog with an error
                await showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: const Text('Error'),
                      content: const Text(
                          'Por favor introduzca un número de teléfono válido'),
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
              // Si todo sale bien, pedir confirmación
              bool result = await confirmPhoneNumber();
              if (!result) {
                return;
              }

              // Se establece el temporizador y se establece el estado del botón
              setState(() {
                _start = 60;
                _buttonText = 'Reenviar código en $_start';
              });
              // Se ejecuta la función que se pasa como parámetro
              widget.onButtonPressed();
              // Se inicia el temporizador
              startTimer();
            },
      child: Text(_buttonText),
    );
  }
}
