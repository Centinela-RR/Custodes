import 'dart:convert';

import 'package:flutter/material.dart';

class Reportes {
  // Almacena la información del reporte
  String _reporte = '';

  // Recibir la información, crear reportes y enviarlos a la db
  void generarReporte(
      {String idUsuario = 'DefaultUser',
      String ubicacion = 'DefaultLocation',
      int tipoReporte = 0}) {
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
