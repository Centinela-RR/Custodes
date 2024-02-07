import 'package:flutter/material.dart';
class CustomShapePainter4 extends CustomPainter {
  final Size screenSize;

  CustomShapePainter4(this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5E454B) // Color #5E454B
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
      ..color = Color(0xFFCEE5D0) // Color #CEE5D0
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
      ..color = Color(0xFFCEE5D0)
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
      ..color = Color(0xFF5E454B)
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
  const MyPruebaWidget({Key? key}) : super(key: key);

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
              color: const Color(0xFFEEE0C7)
            ),
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
              child: Container(
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
                    colors: [
                      Color.fromRGBO(243, 240, 215, 1),
                      Color.fromRGBO(206, 229, 208, 1)
                    ],
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
                  colorFilter: ColorFilter.mode(
                    Colors.transparent, // Color transparente para la imagen
                    BlendMode.dst, // Mezcla de color para aplicar el filtro de transparencia
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
