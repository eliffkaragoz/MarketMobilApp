import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/src/User/UserHome/createOrder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderPayPage extends StatefulWidget {
  OrderPayPage(DocumentSnapshot doc) {
    this.doc = doc;
  }
  DocumentSnapshot doc;
  @override
  _OrderPayPageState createState() => _OrderPayPageState(doc);
}

class _OrderPayPageState extends State<OrderPayPage> {
  _OrderPayPageState(DocumentSnapshot doc) {
    this.doc = doc;
  }
  DocumentSnapshot doc;

  GoogleMapController mapController;
  static final LatLng _center = const LatLng(41.521563, 33.677433);
  final Set<Marker> _markers = {};
  LatLng _currentMapPosition = _center;

  void _onAddMarkerButtonPressed() {
    createData();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => createOrder()));
  }

  void createData() async {
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('Siparis').add({
      'name': doc['name'],
      'price': doc['price'],
      'location':
          GeoPoint(_currentMapPosition.latitude, _currentMapPosition.longitude)
    });
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Maps Demo'),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10.0,
                ),
                markers: _markers,
                onCameraMove: _onCameraMove),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: _onAddMarkerButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
