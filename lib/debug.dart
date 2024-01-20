import 'package:flutter/material.dart';

class DebugApp extends StatelessWidget {
  const DebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debug App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Connection Test'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // Your Firebase connection test logic here
              print('Testing Firebase connection...');
            },
            child: const Text('Test Firebase Connection'),
          ),
        ),
      ),
    );
  }
}
