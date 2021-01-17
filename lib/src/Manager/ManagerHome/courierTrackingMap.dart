import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class courierTrackingMap extends StatefulWidget {
  courierTrackingMap(String email) {
    this.email = email;
  }
  String email;
  @override
  _courierTrackingMapState createState() => _courierTrackingMapState(email);
}

class _courierTrackingMapState extends State<courierTrackingMap> {
  StreamSubscription _locationSubscription;
  Marker marker;
  Circle circle;
  DocumentSnapshot courier;
  GoogleMapController _controller;

  _courierTrackingMapState(String email) {
    this.email = email;
  }
  String email;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void updateMarkerAndCircle(LatLng newLatLng) {
    this.setState(() {
      circle = Circle(
          circleId: CircleId("car"),
          radius: 5,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: newLatLng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courier Tracking"),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 680,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: initialLocation,
              markers: Set.of((marker != null) ? [marker] : []),
              circles: Set.of((circle != null) ? [circle] : []),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('CourierCRUD')
                .doc('$email')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data['courier_location']);
                courier = snapshot.data;
                if (_controller != null) {
                  _controller.animateCamera(CameraUpdate.newCameraPosition(
                      new CameraPosition(
                          bearing: 192.8334901395799,
                          target: LatLng(courier['courier_location'].latitude,
                              courier['courier_location'].longitude),
                          tilt: 0,
                          zoom: 18.00)));
                  updateMarkerAndCircle(LatLng(
                      courier['courier_location'].latitude,
                      courier['courier_location'].longitude));
                }
                return Container();
              } else {}
              return Container();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching), onPressed: () {}),
    );
  }
}
