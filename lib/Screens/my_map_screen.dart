import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MyMap extends StatefulWidget {
  final String user_id;

  MyMap(this.user_id);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final user = FirebaseAuth.instance.currentUser!;
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('location').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (_added) {
            mymap(snapshot);
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            mapType: MapType.normal,
            markers: {
              Marker(
                position: LatLng(
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.user_id)['latitude'],
                    snapshot.data!.docs.singleWhere((element) =>
                        element.id == widget.user_id)['longitude']),
                markerId: MarkerId('id'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta),
                infoWindow: InfoWindow(
                  title: user.displayName,
                  snippet:
                      'Lat: ${snapshot.data!.docs.singleWhere((element) => element.id == widget.user_id)['latitude']}, Lng: ${snapshot.data!.docs.singleWhere((element) => element.id == widget.user_id)['longitude']}',
                ),
              )
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.user_id)['latitude'],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.user_id)['longitude']),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) async {
              setState(() {
                _controller = controller;
                _added = true;
              });
            },
          );
        },
      ),
    );
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
          snapshot.data!.docs.singleWhere(
              (element) => element.id == widget.user_id)['latitude'],
          snapshot.data!.docs.singleWhere(
              (element) => element.id == widget.user_id)['longitude']),
      zoom: 14,
    )));
  }
}
