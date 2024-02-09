import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformApp extends StatelessWidget {
  final Widget home;

  const PlatformApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoApp(
        title: 'Custodes',
        debugShowCheckedModeBanner: false,
        theme: const CupertinoThemeData(
          primaryColor: Colors.deepPurple,
        ),
        home: home,
      );
    } else {
      return MaterialApp(
        title: 'Custodes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: home,
      );
    }
  }
}
