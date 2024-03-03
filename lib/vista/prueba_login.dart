import 'package:flutter/material.dart';

class CustomShapePainter4 extends CustomPainter {
  final Size screenSize;

  CustomShapePainter4(this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF5E454B) // Color #5E454B
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(456, 217)
      ..lineTo(-2.00003, 217)
      ..lineTo(-2.00003, 29.278)
      ..cubicTo(
        -2.00003,
        29.278,
        105.544,
        -48.6203,
        94.3084,
        49.7103,
      )
      ..cubicTo(
        83.0724,
        148.041,
        456,
        29.278,
        456,
        29.278,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomShapePainter3 extends CustomPainter {
  final Size screenSize;

  CustomShapePainter3(this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCEE5D0) // Color #CEE5D0
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(456, 205)
      ..lineTo(-33, 205)
      ..lineTo(-33, 27.6589)
      ..cubicTo(-33, 27.6589, 81.8236, -45.9316, 69.8271, 46.9613)
      ..cubicTo(57.8306, 139.854, 456, 27.6589, 456, 27.6589)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFCEE5D0)
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, -21)
      ..lineTo(467, -21)
      ..lineTo(467, 177.103)
      ..quadraticBezierTo(357.342, 259.309, 368.799, 155.541)
      ..quadraticBezierTo(380.256, 51.7725, 0, 177.103)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomShapePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF5E454B)
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(457, 0)
      ..lineTo(457, 197.796)
      ..quadraticBezierTo(349.69, 279.874, 360.902, 176.267)
      ..quadraticBezierTo(372.113, 72.6596, 0, 197.796)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyPruebaWidget extends StatefulWidget {
  const MyPruebaWidget({super.key});

  @override
  MyPruebaWidgetState createState() => MyPruebaWidgetState();
}

class MyPruebaWidgetState extends State<MyPruebaWidget> {
  double containerHeight = 0.03; // Altura inicial

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(238, 224, 199, 1)),
          ),
          Positioned.fill(
            left: screenSize.width * 0,
            top: screenSize.height * 0.77,
            child: CustomPaint(
              painter: CustomShapePainter4(screenSize),
            ),
          ),
          Positioned.fill(
            left: screenSize.width * 0,
            top: screenSize.height * 0.8,
            child: CustomPaint(
              painter: CustomShapePainter3(screenSize),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: CustomPaint(
              painter: CustomShapePainter2(),
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.height,
                // Otros atributos para el contenedor según sea necesario
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0,
            top: screenSize.height * 0,
            child: CustomPaint(
              painter: CustomShapePainter(),
              child: Container(
                width: screenSize.width * 0,
                height: screenSize.height * 0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                ),
                // Otros atributos para el contenedor según sea necesario
              ),
            ),
          ),
          Positioned(
            left: screenSize.width *
                0.1, // 10% del ancho de la pantalla desde el borde izquierdo
            top: screenSize.height *
                0.45, // 30% de la altura de la pantalla desde el borde superior
            child: SizedBox(
              width: screenSize.width * 0.8, // 80% del ancho de la pantalla
              height: screenSize.height * 0.3, // Altura fija del widget
              child: const Text(
                'Bienvenido a Custodes!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF595959),
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenSize.width *
                0.23, // 23% del ancho de la pantalla desde el borde izquierdo
            top: screenSize.height *
                0.7, // 60% de la altura de la pantalla desde el borde superior
            child: Opacity(
              opacity: 0.70,
              child: Container(
                width: 220,
                height: 54.87,
                decoration: ShapeDecoration(
                  color: const Color(0xFFCEE5D0),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Enviar código',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.1,
            top: screenSize.height * 0.5,
            child: Text(
              'Numero celular',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF595959),
                fontSize: screenSize.width * 0.035,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: screenSize.width *
                0.1, // 10% del ancho de la pantalla desde el borde izquierdo
            top: screenSize.height *
                0.55, // 40% de la altura de la pantalla desde el borde superior
            child: Container(
              width: 325, // Ancho fijo del contenedor
              height: 59, // Altura fija del contenedor
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.28,
            top: screenSize.height * 0.27,
            child: Container(
              width: screenSize.width * 0.45,
              height: screenSize.height * 0.15,
              decoration: const BoxDecoration(
                color: Colors
                    .transparent, // Establece el fondo del contenedor como transparente
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
