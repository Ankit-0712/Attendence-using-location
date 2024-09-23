import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart'; // For loading map style JSON

class AttendanceListScreen extends StatefulWidget {
  @override
  _AttendanceListScreenState createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  List<Member> _members = [
    Member(name: 'John Doe', location: LatLng(37.7749, -122.4194), avatar: 'assets/avatar1.png'),
    Member(name: 'Maria Johns', location: LatLng(34.0522, -118.2437), avatar: 'assets/avatar2.png'),
    // Add more members with their LatLng location and avatar
  ];

  bool _isMapView = true; // Toggle between map and list view
  late GoogleMapController _mapController;
  String _mapStyle = ''; // For custom map styling

  @override
  void initState() {
    super.initState();
    // Load the custom map style
    rootBundle.loadString('assets/map_style.json').then((style) {
      _mapStyle = style;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle drawer opening (if you want to implement later)
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle filter action
            },
            child: Row(
              children: [
                Icon(Icons.filter_list, color: Colors.blue),
                Text("All Members", style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
        ],
      ),
      body: _isMapView ? _buildMapView() : _buildListView(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isMapView = !_isMapView;
            });
          },
          child: Text(_isMapView ? 'Show List View' : 'Show Map View'),
        ),
      ),
    );
  }

  Widget _buildMapView() {
    return GoogleMap(
      onMapCreated: (controller) {
        _mapController = controller;
        _mapController.setMapStyle(_mapStyle); // Apply the custom map style
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(37.7749, -122.4194), // Default to San Francisco
        zoom: 12,
      ),
      markers: _members.map((member) {
        return Marker(
          markerId: MarkerId(member.name),
          position: member.location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(
            title: member.name,
            onTap: () {
              // Navigate to the individual member screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualMemberLocationScreen(member: member),
                ),
              );
            },
          ),
        );
      }).toSet(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _members.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(_members[index].avatar),
            ),
            title: Text(_members[index].name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {
                    // Navigate to individual member location screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividualMemberLocationScreen(
                          member: _members[index],
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.route),
                  onPressed: () {
                    // Navigate to route generation screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RouteGenerationScreen(
                          member: _members[index],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class IndividualMemberLocationScreen extends StatelessWidget {
  final Member member;

  IndividualMemberLocationScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${member.name} Location'),
      ),
      body: Center(
        child: Text('Member Location: ${member.location.latitude}, ${member.location.longitude}'),
      ),
    );
  }
}

class RouteGenerationScreen extends StatelessWidget {
  final Member member;

  RouteGenerationScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Generation'),
      ),
      body: Center(
        child: Text('Generating route for ${member.name}...'),
      ),
    );
  }
}

class Member {
  String name;
  LatLng location; // Use LatLng for map coordinates
  String avatar;

  Member({required this.name, required this.location, required this.avatar});
}
