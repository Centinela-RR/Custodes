import 'dart:async';

import 'package:custodes/controlador/sistema/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircleBorder,
        CircularProgressIndicator,
        Colors,
        ConnectionState,
        FloatingActionButton,
        FutureBuilder,
        Icon,
        Scaffold,
        State,
        StatefulWidget,
        StatelessWidget,
        Widget,
        debugPrint;
import 'package:flutter_map/flutter_map.dart'
    show
        FlutterMap,
        MapController,
        MapOptions,
        Marker,
        MarkerLayer,
        TapPosition,
        TileLayer;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart'
    show CurrentLocationLayer;
import 'package:geolocator/geolocator.dart' show Geolocator, Position;
import 'package:latlong2/latlong.dart' show LatLng;

class MapShow extends StatefulWidget {
  final bool permissionGranted;
  const MapShow(this.permissionGranted, {super.key});
  // The permissionGranted is a boolean value that is used to determine if the user has granted location permissions
  // If the user has not granted location permissions, the map will show a default location
  // If the user has granted location permissions, the map will show the user's current location

  @override
  MapShowState createState() => MapShowState();
}

class MapShowState extends State<MapShow> {
  bool get permissionGranted => widget.permissionGranted;
  final _mapController = MapController();
  late StreamSubscription<Position> positionStreamSubscription;
  final LatLng ubicacionBase = const LatLng(26.316685, -98.836012);
  LatLng currentLocation = const LatLng(26.316685, -98.836012);
  bool isFollowing = true, isSignalLost = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _moveToCurrentLocation();
  }

  void _moveToCurrentLocation() async {
    // Did the user grant location permissions?
    if (!permissionGranted) {
      // If the user did not grant location permissions, show the default location
      _mapController.move(ubicacionBase, 8);
      currentLocation = ubicacionBase;
      return;
    }
    // If the user granted location permissions, show the user's current location,
    // whilst setting up a stream to listen for location updates, with a timeout of 3 seconds

    positionStreamSubscription = Geolocator.getPositionStream()
        .timeout(const Duration(seconds: 6))
        .listen(
      (Position position) {
        // If the user's location is updated, update the current location and move the map to the new location
        if (!mounted) return;
        setState(() {
          // If the user's location is updated, signal lost is obviously false, so set isSignalLost to false
          isSignalLost = false;
          // If the user is following their location, update the current location and move the map to the new location
          if (isFollowing) {
            currentLocation = LatLng(position.latitude, position.longitude);
            _mapController.move(currentLocation, _mapController.camera.zoom);
          }
        });
      },
      // If there is an error, set isSignalLost to true
      onError: (error) {
        if (!mounted) return;
        setState(() {
          isSignalLost = true;
        });
        positionStreamSubscription.cancel();
        _startTimer();
      },
      // If the stream is done (so there's a loss of signal), set isSignalLost to true
      onDone: () {
        if (!mounted) return;
        setState(() {
          isSignalLost = true;
        });
        _startTimer();
      },
      // If the stream is cancelled, set isSignalLost to true
      cancelOnError: true,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer t) async {
      try {
        await Geolocator.getCurrentPosition();
        _timer!.cancel();
        _timer = null;
        if (!mounted) return;
        setState(() {
          isFollowing = true;
        });
        _moveToCurrentLocation();
      } catch (e) {
        // Ignore the error and keep trying
      }
    });
  }

  void _toggleFollowing() {
    if (!mounted) return;
    setState(() {
      isFollowing = !isFollowing;
    });
    if (isFollowing) {
      _moveToCurrentLocation();
    }
  }

  MapOptions get mapOptions => MapOptions(
        keepAlive: false,
        initialCenter: const LatLng(26.316685, -98.836012),
        initialZoom: 16,
        minZoom: 14,
        maxZoom: 18,
        onTap: (TapPosition tapPosition, LatLng latLng) {
          debugPrint('onTap: $latLng');
        },
        onPositionChanged: (position, hasGesture) {
          if (hasGesture && isFollowing) {
            if (!mounted) return;
            setState(() {
              isFollowing = false;
            });
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
          options: mapOptions,
          mapController: _mapController,
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName:
                  'com.centinela.custodes', // This is the package name of the app
              maxZoom: 19,
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: currentLocation,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      
                    ),
                    child: Icon(
                        isSignalLost ? CupertinoIcons.location_solid : null,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            CurrentLocationLayer(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _toggleFollowing();
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          child: Icon(isSignalLost
              ? CupertinoIcons.location_slash
              : (isFollowing
                  ? CupertinoIcons.location_fill
                  : CupertinoIcons.location)),
        ));
  }
}

class MapBuild extends StatelessWidget {
  const MapBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: LocationFunctions().checkLocationPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data as bool) {
              return const MapShow(true);
            } else {
              return const MapShow(false);
            }
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
