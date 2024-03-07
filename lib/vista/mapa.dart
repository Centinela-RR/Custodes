import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

//Recordar hacer clean y pub get. Tambien eliminar  el .lock del directorio principal. Ademas de comandos para borrar el cache de flutter y grandle que puede romper la pc y dependencias.

//Wtf 500mb?

/*Cosas para el mapa faltante:
- Botones de la interfaz
- Que tenga solo la region ribereña
- Ver como poner wayponts
- Capturar posicion al dar clic
- Usar la base de datos
- Arreglar el servidor solo quitar (a) del archivo
- Como integrar localizacion actual permanente sin que sea manual
- ....
*/

// Orden de tareas para avanzar algo.
/*  
    * 1. Establecer el subdominio correcto
    * 2. Averiguar sobre los controles del mapa (es incomodo de usar con dos dedos asi que se debe eliminar la rotacion de preferencia (Pedir opinion al grupo))
    * 3. Eliminar botones que no son necesarios.
    * 4. Capturar las ubicaciones
    * 5. Enviar los datos a la BD
    ! Revisar como lograr que los dispositivos por defecto tenga usar ubicacion en tiempo real siempre.
    ?. Integrar al proyecto principal
    ?. Modificar carpetas del proyecto para tener mejor control
*/

class _MapaState extends State<Mapa> {
  String address = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mapa"),
        ),
        body: OpenStreetMapSearchAndPick(
          buttonTextStyle:
              const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
          buttonColor: Colors.blue,
          buttonText: 'Set Current Location',
          onPicked: (pickedData) {
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
            print(pickedData.address);
            print(pickedData.addressName);
          },
        ));
  }
}
