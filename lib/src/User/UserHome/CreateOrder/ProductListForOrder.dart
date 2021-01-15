import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
              children: <Widget>[
                FlatButton(
                  //Bu butona tıklandığında Tıklanan veri myOrdere yazılmalı Nasıl yapcazz:/
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPayPage()));
                  },
                  color: Colors.orangeAccent,
                  child:
                      Text('Sipariş Et', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
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
}
