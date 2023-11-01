// Importing necessary packages
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'all_users_location.dart';
import 'my_map_screen.dart';

// Creating a StatefulWidget named Homepage
class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

// Creating the state for Homepage
class _HomepageState extends State<Homepage> {
  // Getting the current user
  final user = FirebaseAuth.instance.currentUser!;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(user.email!),
            // Displaying user email
            Text(user.uid!),
            // Displaying user UID
            TextButton(
                onPressed: () {
                  _getLocation(user.uid);
                  print(
                      'get location working'); // Triggering location retrieval
                },
                child: Text('Add Location')),
            // Button to add location
            TextButton(
                onPressed: () {
                  _listenLocation(user.uid);
                },
                child: Text('Enable Live Location')),
            // Button to enable live location
            TextButton(
                onPressed: () {
                  _stopListening();
                },
                child: Text('Disable live location')),
            // Button to disable live location
            Expanded(
                child: StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('location').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title:
                            Text(snapshot.data!.docs[index]['name'].toString()),
                            // Displaying name
                            subtitle: Row(
                              children: [
                                Text(snapshot.data!.docs[index]['latitude']
                                    .toString()), // Displaying latitude
                                SizedBox(
                                  width: 20,
                                ),
                                Text(snapshot.data!.docs[index]['longitude']
                                    .toString()), // Displaying longitude
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.directions),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MyMap(snapshot.data!.docs[index]
                                            .id))); // Navigating to map screen
                              },
                            ),
                          );
                        });
                  },
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          AllUsers())); // Navigating to all users location screen
                },
                child: Text('Show live location')),
            // Button to show live locations
            ElevatedButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              // Signing out user
              child: Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }

  // Function to get current location and add it to Firestore
  _getLocation(String userId) async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc(userId).set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': user.displayName,
      }, SetOptions(merge: true)); // Setting location data in Firestore
    } catch (error) {
      print(error);
    }
  }

  // Function to start listening for live location updates
  Future<void> _listenLocation(String userId) async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc(userId).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': user.displayName,
      }, SetOptions(merge: true)); // Updating location data in Firestore
    });
  }

  // Function to stop listening for live location updates
  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  // Function to request location permission
  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('permission granted');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Open app settings to allow location access
    }
  }
}
