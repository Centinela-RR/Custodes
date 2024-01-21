import 'package:flutter/material.dart';
import '../modelo/db.dart';

class DebugApp extends StatefulWidget {
  const DebugApp({super.key});

  @override
  DebugAppState createState() => DebugAppState();
}

class DebugAppState extends State<DebugApp> {
  String buttonText = 'Sugma';
  // Create new instance of FirebaseConnection called fb
  FirebaseConnection fb = FirebaseConnection();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debug App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(buttonText),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // Your Firebase connection test logic here:
              // When the button is pressed, call the function fetchElement
              //fb.fetchElement();
              // For a demo on playing with Flutter, 
              // we'll change the button text
              setState(() {
                buttonText = fb.generateLocalIdentifier();
                /*buttonText = buttonText == 'Sugma'
                    ? 'BALLS'
                    : 'Sugma';*/
                
              });
            },
            child: Text(buttonText),
          ),
        ),
      ),
    );
  }
}

