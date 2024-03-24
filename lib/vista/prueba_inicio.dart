import 'package:custodes/vista/map.dart';
import 'package:flutter/material.dart'
    show
        AnimatedContainer,
        AppBar,
        BoxDecoration,
        BuildContext,
        Clip,
        Color,
        Colors,
        Column,
        Container,
        Curves,
        GestureDetector,
        Icon,
        IconButton,
        Icons,
        ListTile,
        MainAxisAlignment,
        MaterialPageRoute,
        Matrix4,
        MediaQuery,
        Navigator,
        Positioned,
        Scaffold,
        Size,
        Stack,
        State,
        StatefulWidget,
        Text,
        Widget,
        showModalBottomSheet;
import 'package:connectivity_wrapper/connectivity_wrapper.dart'
    show ConnectivityWidgetWrapper;
import 'package:custodes/controlador/sistema/auth.dart'
    show AuthCheck, UserAuth;
import 'package:custodes/controlador/sistema/widgets.dart' as syswid;
import 'package:custodes/controlador/sistema/general.dart' as sysfun;

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
    //bool menuOpen = false;
    return ConnectivityWidgetWrapper(
        offlineWidget: syswid.Widgets.offlineMessage(context),
        disableInteraction: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Prueba Inicio'),
            automaticallyImplyLeading: false,
          ),
          body: GestureDetector(
            /*onTap: () {
              setState(() {
                containerHeight = containerHeight == 0.3 ? 0.1 : 0.3;
              });
            },*/
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
                    // Posición del botón, arriba del último contenedor
                    left: screenSize.width * 0.4,
                    top: screenSize.height * (1 - containerHeight) - 50,
                    child: IconButton(
                      onPressed: showMenu,
                      icon: const Icon(Icons.menu), // Icono de menú
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
              // TODO: Hacer que no se abra verticalmente, sino horizontalmente
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
                        //Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapBuild()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Cerrar Sesión'),
                      onTap: () async {
                        // Acciones cuando se selecciona la opción "Cerrar Sesión"
                        await sysfun.FutureFunctions().showConfirmationDialog(
                          context,
                          "Estas seguro de querer cerrar sesión?",
                          "¿Estás seguro de que deseas continuar?",
                          "Cancelar",
                          "Cerrar Sesión",
                          () async {
                            // Acciones adicionales después de cerrar el diálogo
                            await sysfun.FutureFunctions().showAlertDialog(
                                context,
                                "Gracias por utilizar Custodes!",
                                "Esperamos que hayas tenido una buena experiencia. ¡Hasta luego!",
                                "Nos vemos!");
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
                        );
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
