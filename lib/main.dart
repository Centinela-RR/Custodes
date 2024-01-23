import 'package:custodes/vista/debug.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

export 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart'
    show
    Permission,
    PermissionStatus,
    PermissionStatusGetters,
    PermissionWithService,
    FuturePermissionStatusGetters,
    ServiceStatus,
    ServiceStatusGetters,
    FutureServiceStatusGetters;

PermissionHandlerPlatform get _handler => PermissionHandlerPlatform.instance;
void main() async {
  // Ensure that Firebase is initialized before runApp() is called
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DebugApp()); //MainApp() is default: the main app
}

/* Options:
- MainApp()
- DebugApp()
*/