import 'package:flutter/material.dart';

class MyPruebaWidget extends StatefulWidget {
  const MyPruebaWidget({super.key});

  @override
  MyPruebaWidgetState createState() => MyPruebaWidgetState();
}

//animacion para caja de botones
//colores aun no determinados
class MyPruebaWidgetState extends State<MyPruebaWidget> {
  double containerHeight = 0.3; // Altura inicial

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

//Haciendo pruebas con la animacion tengo que estudiar mejor esta cosa aaaaa
//jajaja esta toda cuacha
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba Widget'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          // Si el usuario desliza hacia arriba, incrementa la altura del contenedor poco a poco
          if (details.primaryDelta! > 0) {
            setState(() {
              containerHeight += 0.01;
              if (containerHeight > 0.8) {
                containerHeight = 0.8; // Límite superior
              }
            });
          }
          // Si el usuario desliza hacia arriba, disminuye la altura del contenedor poco a poco
          else if (details.primaryDelta! < 0) {
            setState(() {
              containerHeight -= 0.01;
              if (containerHeight < 0.3) {
                containerHeight = 0.3; // Límite inferior
              }
            });
          }
        },
        onVerticalDragEnd: (details) {
          // Si el usuario suelta el gesto hacia abajo, establece la posición máxima
          if (details.primaryVelocity! > 0) {
            setState(() {
              containerHeight = 0.8;
            });
          }
          // Si el usuario suelta el gesto hacia arriba, establece la posición inicial
          else if (details.primaryVelocity! < 0) {
            setState(() {
              containerHeight = 0.3;
            });
          }
        },
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          clipBehavior: Clip.antiAlias,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: screenSize.height * containerHeight,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height * (1 - containerHeight),
                  decoration: const ShapeDecoration(
                    color: Color(0xFFF3F0D7),
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
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: screenSize.width *0.35, // Ajuste según el ancho de la pantalla
                top: screenSize.height * (containerHeight + 0.01),
                child: Container(
                  width: screenSize.width * 0.3,
                  height: 3,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCEE5D0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              Positioned(
              // Posición del botón, arriba del último contenedor
              left: screenSize.width * 0.4,
              top: screenSize.height * (1 - containerHeight) - 50,
              child: ElevatedButton(
                onPressed: () {
                  // Acciones al presionar el botón
                  debugPrint('Botón presionado');
                },
                child: const Text('Presionar'),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
