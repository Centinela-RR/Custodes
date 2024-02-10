import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
- ....
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
