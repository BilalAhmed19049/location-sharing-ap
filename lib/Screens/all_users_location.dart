// AllUsers.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AllUsers extends StatefulWidget {
  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('location').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            mapType: MapType.normal,
            markers: Set<Marker>.from(snapshot.data!.docs.map((doc) {
              double latitude = doc['latitude'];
              double longitude = doc['longitude'];
              String userName = doc['name'];
              return Marker(
                markerId: MarkerId(doc.id),
                position: LatLng(latitude, longitude),
                infoWindow: InfoWindow(
                  title: userName,
                  snippet: 'Lat: $latitude, Lng: $longitude',
                ),
              );
            })),
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0), // Set initial camera position as needed
              zoom: 2, // Set initial zoom level as needed
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _controller = controller;
              });
            },
          );
        },
      ),
    );
  }
}
