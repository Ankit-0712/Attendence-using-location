import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutePoint {
  double lat;
  double lng;

  RoutePoint({required this.lat, required this.lng});
}

class Member {
  String name;
  String id;

  Member({required this.name, required this.id});
}

class RouteGenerationScreen extends StatefulWidget {
  final Member member;

  RouteGenerationScreen({required this.member});

  @override
  _RouteGenerationScreenState createState() => _RouteGenerationScreenState();
}

class _RouteGenerationScreenState extends State<RouteGenerationScreen> {
  GoogleMapController? _mapController; // Use a nullable type
  List<RoutePoint> _routePoints = [
    RoutePoint(lat: 37.7749, lng: -122.4194),
    RoutePoint(lat: 34.0522, lng: -118.2437),
    // Add more route points to the list
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Generation'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller; // Assign the controller to the variable
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 12,
            ),
            polylines: {
              Polyline(
                polylineId: PolylineId('route'),
                color: Colors.blue,
                width: 5,
                points: _routePoints.map((point) => LatLng(point.lat, point.lng)).toList(),
              ),
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Start Location: ${_routePoints.first.lat}, ${_routePoints.first.lng}'),
                Text('Stop Location: ${_routePoints.last.lat}, ${_routePoints.last.lng}'),
                Text('Total KMs: 100'),
                Text('Total Duration: 2 hours'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}