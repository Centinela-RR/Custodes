import 'package:flutter/material.dart' show debugPrint;
import 'package:geolocator/geolocator.dart'
    show Geolocator, LocationPermission, Position;

class UserFunctions {}

class LocationFunctions {
  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied');
        return false;
      }
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    // We got perms, fuck yea.
    return true;
  }

  Future<Position> getCurrentLocation() async {
    final Position defaultPosition = Position(
        longitude: -98.836012,
        latitude: 26.316685,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 90,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0);

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      return defaultPosition;
    }

    // Check if we have permission to access location
    bool gotLocPerms = await LocationFunctions().checkLocationPermission();
    if (!gotLocPerms) {
      debugPrint('Location permissions are denied');
      return defaultPosition;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(seconds: 2));
      debugPrint('Got current position: $position');
      return position;
    } catch (e) {
      debugPrint(e.toString());
      return defaultPosition;
    }
  }
}
