import 'dart:async' show Future;
import 'dart:convert' show jsonEncode;

import 'package:custodes/controlador/sistema/auth.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart'
    show
        BuildContext,
        CircleBorder,
        EdgeInsets,
        ElevatedButton,
        Icon,
        debugPrint;

import 'package:custodes/controlador/sistema/general.dart' as sysfunc;

class Functions {
  // Almacena la información del reporte
  String _reporte = '';

  // Todo en uno
  Future<String> hacerReporte(
      {String idUsuario = 'DefaultUser',
      String ubicacion = 'DefaultLocation',
      int tipoReporte = 0}) async {
    generarReporte(idUsuario, ubicacion, tipoReporte);
    return await enviarReporte();
  }

  // Recibir la información, crear reportes y enviarlos a la db
  void generarReporte(String idUsuario, String ubicacion, int tipoReporte) {
    // Hacer un arreglo de JSON con los datos del reporte
    var reporte = {
      'idUsuario': idUsuario,
      'ubicacion': ubicacion,
      'tiempo': DateTime.now().toString(),
      'tipoReporte': tipoReporte
    };
    // Convertir el arreglo a JSON
    _reporte = jsonEncode(reporte);
  }

  // Enviar reporte a la db
  Future<String> enviarReporte() async {
    // Guardar el JSON en la db
    // Enviar reporte
    try {
      return _reporte.toString();
    } catch (e) {
      debugPrint('Error al enviar reporte: $e');
      return 'Error: ${e.toString()}';
    }
  }
}

class Buttons {
  Functions fun = Functions();
  sysfunc.Functions sysfun = sysfunc.Functions();
  // User authentication controller
  UserAuth auth = UserAuth();

  BuildContext? localContext;

  ElevatedButton buttonRep(
      {required BuildContext context,
      required String ubicacion,
      required int tipoReporte}) {
    Icon iconToUse;
    switch (tipoReporte) {
      case 1:
        iconToUse = const Icon(CupertinoIcons.burn);
        break;
      case 2:
        iconToUse = const Icon(CupertinoIcons.checkmark_shield_fill);
        break;
      default:
        iconToUse = const Icon(CupertinoIcons.exclamationmark_circle);
        break;
    }
    return ElevatedButton(
        onPressed: () async {
          if ((auth.getUid() ?? 'null') == "null") {
            //debugPrint('lmao, no id');
            return;
          }
          localContext = context;
          String usuario = auth.getUid() ?? 'null';
          String ubicacionTr = ubicacion;
          int reporteType = tipoReporte;

          (() async {
            String res = await fun.hacerReporte(
              idUsuario: usuario,
              ubicacion: ubicacionTr,
              tipoReporte: reporteType,
            );

            if (localContext == null) {
              debugPrint('aaa');
              return;
            }
            if (!res.contains("Error")) {
              sysfun.showAlertDialog(
                  localContext!,
                  "Éxito!",
                  "Reporte enviado satisfactoriamente!\nDetalles: \nidUsuario: $usuario \nubicacion: $ubicacionTr \ntipoReporte: $reporteType",
                  'OK');
            } else {
              sysfun.showAlertDialog(localContext!, "Error", res, 'OK');
              return;
            }
          })();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
        ),
        child: iconToUse);
  }
}
