import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        ConnectionState,
        FutureBuilder,
        Scaffold,
        State,
        StatefulWidget,
        StatelessWidget,
        Widget,
        debugPrint;
import 'package:flutter_map/flutter_map.dart'
    show FlutterMap, MapController, MapOptions, TapPosition, TileLayer;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart'
    show CurrentLocationLayer;
import 'package:geolocator/geolocator.dart'
    show Geolocator, LocationPermission, Position;
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
  final ubicacionBase = const LatLng(26.316685, -98.836012);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    if (!permissionGranted) {
      _mapController.move(ubicacionBase, 8);
      return;
    }
    Stream<Position> positionStream = Geolocator.getPositionStream();

    positionStream.listen((Position position) {
      _mapController.move(LatLng(position.latitude, position.longitude),
          _mapController.camera.zoom);
    });
  }

  final mapOptions = MapOptions(
    keepAlive: true,
    initialCenter: const LatLng(26.316685, -98.836012),
    initialZoom: 16,
    minZoom: 14,
    maxZoom: 18,
    onTap: (TapPosition tapPosition, LatLng latLng) {
      debugPrint('onTap: $latLng');
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
          CurrentLocationLayer(
              //positionStream: _positionStream,
              ),
        ],
      ),
    );
  }
}

class MapBuild extends StatelessWidget {
  const MapBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _checkLocationPermission(),
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

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
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
}
