import 'package:flutter/material.dart';

class MyPruebaWidget extends StatefulWidget {
  const MyPruebaWidget({Key? key}) : super(key: key);

  @override
  _MyPruebaWidgetState createState() => _MyPruebaWidgetState();
}

class _MyPruebaWidgetState extends State<MyPruebaWidget> {
  double containerHeight = 1.0; // Altura inicial

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

//Haciendo pruebas con la animacion tengo que estudiar mejor esta cosa aaaaa

    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba Widget'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          // Si el usuario desliza hacia arriba, incrementa la altura del contenedor
          if (details.primaryDelta! < 0) {
            setState(() {
              containerHeight += 0.01;
              if (containerHeight > 0.8) {
                containerHeight = 0.8; // Límite superior
              }
            });
          }
        },
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF3F0D7)),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: screenSize.height * containerHeight,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height * (1 - containerHeight),
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(255, 146, 142, 113),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: screenSize.width * 0.35, // Ajuste según el ancho de la pantalla
                top: screenSize.height * (containerHeight - 0.01),
                child: Container(
                  width: screenSize.width * 0.3,
                  height: 8,
                  decoration: ShapeDecoration(
                    color: Color(0xFFCEE5D0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
