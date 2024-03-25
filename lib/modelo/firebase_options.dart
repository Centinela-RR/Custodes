// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB8fvC2xTFZ09UhwDtK3Q24leztcJMCgf8',
    appId: '1:528581573998:web:19ef5ed439e6d9bd00157f',
    messagingSenderId: '528581573998',
    projectId: 'custodes-97a6a',
    authDomain: 'custodes-97a6a.firebaseapp.com',
    databaseURL: 'https://custodes-97a6a-default-rtdb.firebaseio.com',
    storageBucket: 'custodes-97a6a.appspot.com',
    measurementId: 'G-JBN87FJTPB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCOFvybDdGT0C6IJXIYHQE0dGbCY6o8eo',
    appId: '1:528581573998:android:69b72c6cfe5aa2a700157f',
    messagingSenderId: '528581573998',
    projectId: 'custodes-97a6a',
    databaseURL: 'https://custodes-97a6a-default-rtdb.firebaseio.com',
    storageBucket: 'custodes-97a6a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDJgBVybuThwVUXWh_dP3a6FddXBAeln0',
    appId: '1:528581573998:ios:e85e72c830391c4b00157f',
    messagingSenderId: '528581573998',
    projectId: 'custodes-97a6a',
    databaseURL: 'https://custodes-97a6a-default-rtdb.firebaseio.com',
    storageBucket: 'custodes-97a6a.appspot.com',
    androidClientId:
        '528581573998-7qop20tk8ocbbs573gb6c537rnit17gd.apps.googleusercontent.com',
    iosClientId:
        '528581573998-juacckc3inmo2ahh7kbt6llscnjgkamh.apps.googleusercontent.com',
    iosBundleId: 'com.centinela.custodes',
  );
}
