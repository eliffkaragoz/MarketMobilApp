import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  MapSample(GeoPoint path, DocumentReference courier) {
    this.path = path;
    this.courier = courier;
  }
  GeoPoint path;
  DocumentReference courier;
  @override
  State<MapSample> createState() => MapSampleState(path, courier);
}

class MapSampleState extends State<MapSample> {
  MapSampleState(GeoPoint path, DocumentReference courier) {
    this.path = path;
    this.courier = courier;
  }

  DocumentReference courier;
  GeoPoint path;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();

  void getCurrentLocation() async {
    try {
      var location = await _locationTracker.getLocation();

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          courier.update({
            'courier_location':
                GeoPoint(newLocalData.latitude, newLocalData.longitude)
          });
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CameraPosition _kLake;

  void initState() {
    // TODO: implement initState
    super.initState();
    _kLake = CameraPosition(
        bearing: 0.0,
        target: LatLng(path.latitude, path.longitude),
        tilt: 0.0,
        zoom: 19.151926040649414);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the Order Location'),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
