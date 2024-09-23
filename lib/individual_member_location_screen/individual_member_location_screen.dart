import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Member {
  String name;
  String id;

  Member({required this.name, required this.id});
}

class VisitedLocation {
  String location;
  String timestamp;

  VisitedLocation({required this.location, required this.timestamp});
}

class IndividualMemberLocationScreen extends StatefulWidget {
  final Member member;

  IndividualMemberLocationScreen({required this.member});

  @override
  _IndividualMemberLocationScreenState createState() => _IndividualMemberLocationScreenState();
}

class _IndividualMemberLocationScreenState extends State<IndividualMemberLocationScreen> {
  GoogleMapController? _mapController; // Use a nullable type
  List<VisitedLocation> _visitedLocations = [
    VisitedLocation(location: 'New York', timestamp: '10:00 AM'),
    VisitedLocation(location: 'Los Angeles', timestamp: '11:00 AM'),
    // Add more visited locations to the list
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Location'),
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
          ),
          ListView.builder(
            itemCount: _visitedLocations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_visitedLocations[index].location),
                subtitle: Text(_visitedLocations[index].timestamp),
              );
            },
          ),
        ],
      ),
    );
  }
}