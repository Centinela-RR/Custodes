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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: ***REMOVED***,
    appId: '1:528581573998:web:19ef5ed439e6d9bd00157f',
    messagingSenderId: ***REMOVED***,
    projectId: ***REMOVED***,
    authDomain: 'custodes-97a6a.firebaseapp.com',
    databaseURL: 'https://custodes-97a6a-default-rtdb.firebaseio.com',
    storageBucket: 'custodes-97a6a.appspot.com',
    measurementId: ***REMOVED***,
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: ***REMOVED***,
    appId: '1:528581573998:android:69b72c6cfe5aa2a700157f',
    messagingSenderId: ***REMOVED***,
    projectId: ***REMOVED***,
    databaseURL: 'https://custodes-97a6a-default-rtdb.firebaseio.com',
    storageBucket: 'custodes-97a6a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: ***REMOVED***,
    appId: '1:528581573998:ios:e85e72c830391c4b00157f',
    messagingSenderId: ***REMOVED***,
    projectId: ***REMOVED***,
    databaseURL: 'https://custodes-97a6a-default-rtdb.firebaseio.com',
    storageBucket: 'custodes-97a6a.appspot.com',
    iosBundleId: 'com.centinela.custodes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: ***REMOVED***,
    appId: '1:528581573998:ios:00894e0560ef728d00157f',
    messagingSenderId: ***REMOVED***,
    projectId: ***REMOVED***,
    databaseURL: 'https://custodes-97a6a-default-rtdb.firebaseio.com',
    storageBucket: 'custodes-97a6a.appspot.com',
    iosBundleId: 'com.example.custodes.RunnerTests',
  );
}