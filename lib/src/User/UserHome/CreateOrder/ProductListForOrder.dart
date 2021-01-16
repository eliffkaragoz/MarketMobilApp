import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'OrderList.dart';

class ProductListForOrder extends StatefulWidget {
  @override
  _ProductListForOrderState createState() => _ProductListForOrderState();
}

class _ProductListForOrderState extends State<ProductListForOrder> {
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  String price;
  GoogleMapController mapController;
  static final LatLng _center = const LatLng(41.521563, 33.677433);
  final Set<Marker> _markers = {};
  LatLng _currentMapPosition = _center;
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_currentMapPosition.toString()),
        position: _currentMapPosition,
        infoWindow:
            InfoWindow(title: 'Nice Place', snippet: 'Welcome to Poland'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      color: Colors.white12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'NAME:  ${doc['name']}',
              style: TextStyle(color: Colors.brown, fontSize: 24),
            ),
            Text(
              'PRICE :  ${doc['price']} ₺',
              style: TextStyle(color: Colors.brown, fontSize: 24),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter the name of the product you will order',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onSaved: (value) => name = value,
    );
    // ignore: missing_return
  }

  TextFormField buildTextFormField2() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter the price of the product you will order',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onSaved: (value) => price = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Column(children: <Widget>[
            Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  buildTextFormField(),
                  SizedBox(
                    height: 25,
                  ),
                  buildTextFormField2(),
                  SizedBox(
                    height: 25,
                  ),
                ])),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: _onAddMarkerButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.map, size: 30.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          RaisedButton(
            onPressed: createData,
            color: Colors.orangeAccent,
            child: Text('Create Order', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: 25,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: db.collection('ProductCRUD').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: snapshot.data.documents
                        .map((doc) => buildItem(doc))
                        .toList());
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection('Siparis')
          .add({'price': '$price', 'name': '$name '});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }
}
