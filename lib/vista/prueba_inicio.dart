import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:custodes/controlador/sistema/auth.dart';
import 'package:flutter/material.dart';
import 'package:custodes/controlador/sistema/widgets.dart' as syswid;

class MyPruebaWidget extends StatefulWidget {
  const MyPruebaWidget({super.key});

  @override
  MyPruebaWidgetState createState() => MyPruebaWidgetState();
}

class MyPruebaWidgetState extends State<MyPruebaWidget> {
  double containerHeight = 0.3; // Altura inicial
  UserAuth auth = UserAuth();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    bool menuOpen = false;
    return Scaffold(
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
          // Si el usuario desliza hacia abajo, disminuye la altura del contenedor poco a poco
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
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
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
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // Posición del botón, arriba del último contenedor
                left: screenSize.width * 0.4,
                top: screenSize.height * (1 - containerHeight) - 50,
                child: IconButton(
                  onPressed: showMenu,
                  icon: Icon(Icons.menu), // Icono de menú
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMenu() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                MediaQuery.of(context).size.width * -0.2,
                0,
                0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Opción 1'),
                      onTap: () {
                        // Acciones cuando se selecciona la opción 1
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Cerrar Sesión'),
                      onTap: () async {
                        // Acciones cuando se selecciona la opción "Cerrar Sesión"
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  const Text('Gracias por utilizar Custodes!'),
                              content: const Text(
                                  'Esperamos que hayas tenido una buena experiencia. ¡Hasta luego!'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Nos vemos!'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        // Acciones adicionales después de cerrar el diálogo
                        // Por ejemplo, cerrar sesión
                        await auth.signOut();
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthCheck()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
