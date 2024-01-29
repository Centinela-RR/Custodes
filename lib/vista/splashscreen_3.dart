// I think this is shit, it ain't working when implemented like brooo :(
import 'package:flutter/material.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 470,
          height: 1014,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF2C2C2C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 60,
                offset: Offset(80, 60),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 277,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 7,
                        height: 13,
                        decoration: const BoxDecoration(color: Color(0xFF131313)),
                      ),
                    ),
                    Positioned(
                      left: 270,
                      top: 0,
                      child: Container(
                        width: 7,
                        height: 13,
                        decoration: const BoxDecoration(color: Color(0xFF131313)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 456,
                height: 988,
                decoration: ShapeDecoration(
                  color: const Color(0xFF2C2C2C),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Color(0xFF0D0D0D)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(
                width: 30.16,
                height: 3.63,
                child: Stack(
                  children: [
                    Positioned(
                      left: 6.63,
                      top: 0,
                      child: Container(
                        width: 3.63,
                        height: 3.63,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF131313),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 13.26,
                      top: 0,
                      child: Container(
                        width: 3.63,
                        height: 3.63,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF131313),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 19.89,
                      top: 0,
                      child: Container(
                        width: 3.63,
                        height: 3.63,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF131313),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 26.53,
                      top: 0,
                      child: Container(
                        width: 3.63,
                        height: 3.63,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF131313),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 3.63,
                        height: 3.63,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF131313),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 97.12,
                height: 101,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/97x101"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 228,
                height: 47,
                child: Text(
                  'ustodes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Cantata One',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                width: 277,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 7,
                        height: 13,
                        decoration: const BoxDecoration(color: Color(0xFF131313)),
                      ),
                    ),
                    Positioned(
                      left: 270,
                      top: 0,
                      child: Container(
                        width: 7,
                        height: 13,
                        decoration: const BoxDecoration(color: Color(0xFF131313)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}