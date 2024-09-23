import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController; // Make it nullable
  Set<Marker> _markers = {}; // Add a set to store markers
  Set<Polyline> _polylines = {}; // Add a set to store polylines

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller; // Assign the controller to the variable
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 12,
        ),
        markers: _markers, // Use the _markers set
        polylines: _polylines, // Use the _polylines set
        onLongPress: (LatLng latLng) {
          // Add a marker on long press
          setState(() {
            _markers.add(Marker(
              markerId: MarkerId(latLng.toString()),
              position: latLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ));
          });
        },
      ),
    );
  }
}