import 'package:flutter/material.dart';

class Widgets {
  static Widget offlineMessage(BuildContext context) {
    return Opacity(
      opacity: 0.9, // Increase this value to make the whole thing more opaque
      child: Stack(
        children: [
          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height /
                  11, // Make the box bigger
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20.0), // Add rounded corners
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.deepPurple.withOpacity(0.5),
                    Colors.purpleAccent.withOpacity(0.5)
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Lo sentimos! \nCustodes requiere una conexión a internet para funcionar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Damascus',
                    inherit: false,
                    color: Colors
                        .white, // This is necessary for the ShaderMask to work
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
