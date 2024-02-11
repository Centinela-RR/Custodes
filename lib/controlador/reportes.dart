import 'dart:convert';

import 'package:flutter/material.dart';

class Reportes {
  // Parámetros para generar reportes: usuario, ubicación, tiempo, hora, tipo de reporte
  String _idUsuario = 'DefaultUser';
  String _ubicacion = 'DefaultLocation';
  DateTime _tiempo = DateTime.now();
  int _tipoReporte = 0;

  // Almacena la información del reporte
  String _reporte = '';

  // Recibir la información, crear reportes y enviarlos a la db
  void generarReporte(
      {String idUsuario = 'DefaultUser',
      String ubicacion = 'DefaultLocation',
      int tipoReporte = 0}) {
    // Hacer un arreglo de JSON con los datos del reporte
    var reporte = {
      'idUsuario': _idUsuario,
      'ubicacion': _ubicacion,
      'tiempo': DateTime.now().toString(),
      'tipoReporte': _tipoReporte
    };
    // Convertir el arreglo a JSON
    _reporte = jsonEncode(reporte);
  }

  // Enviar reporte a la db
  int enviarReporte() {
    // Guardar el JSON en la db
    // Enviar reporte
    debugPrint(_reporte);
    return 0;
  }
}
