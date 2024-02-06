import 'package:flutter/material.dart';

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFCEE5D0)
      ..style = PaintingStyle.fill;

    // Dibuja un rectángulo en la parte superior de la pantalla
    double rectWidth = size.width * 200;
    double rectHeight = size.height * 2;

    double rectLeft = (size.width - rectWidth) / 2;
    double rectTop = 0;

    Rect rect = Rect.fromLTRB(
        rectLeft, rectTop, rectLeft + rectWidth, rectTop + rectHeight);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyPruebaWidget extends StatefulWidget {
  const MyPruebaWidget({Key? key}) : super(key: key);

  @override
  MyPruebaWidgetState createState() => MyPruebaWidgetState();
}

class MyPruebaWidgetState extends State<MyPruebaWidget> {
  double containerHeight = 0.3; // Altura inicial

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            left: screenSize.width * 0.0,
            top: screenSize.height * 0.0,
            child: CustomPaint(
              painter: CustomShapePainter(),
              child: Container(
                width: screenSize.width * 0.01,
                height: screenSize.height * 0.10,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                ),
                // Otros atributos para el contenedor según sea necesario
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.10,
            top: screenSize.height * 0.07,
            child: Text(
              'Iniciar Sesión',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenSize.width * 0.10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.10,
            top: screenSize.height * 0.14,
            child: Text(
              'Hola, Bienvenido a custodes',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF595959),
                fontSize: screenSize.width * 0.040,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.09,
            top: screenSize.height * 0.65,
            child: Opacity(
              opacity: 0.70,
              child: Container(
                width: screenSize.width * 0.80,
                height: screenSize.height * 0.07,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.20, -0.98),
                    end: Alignment(-0.2, 0.98),
                    colors: [Color.fromRGBO(243, 240, 215, 1), Color.fromRGBO(206, 229, 208, 1)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.02),
                  ),
                ),
                alignment: Alignment
                    .center, // Alinea el texto al centro del contenedor
                child: Text(
                  'Verificacion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5E454B),
                    fontSize: screenSize.width * 0.035,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.088,
            top: screenSize.height * 0.465,
            child: Text(
              'Ingrese numero celular',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF595959),
                fontSize: screenSize.width * 0.035,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.08,
            top: screenSize.height * 0.50,
            child: Container(
              width: screenSize.width * 0.83,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFF979797),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.40,
            top: screenSize.height * 0.27,
            child: Container(
              width: screenSize.width * 0.2,
              height: screenSize.height * 0.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/icon.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
