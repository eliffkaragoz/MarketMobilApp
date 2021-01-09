import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductManager extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ProductCRUDPage(),
    );
  }
}

class ProductCRUDPage extends StatefulWidget {
  @override
  _ProductCRUDPageState createState() => _ProductCRUDPageState();
}

class _ProductCRUDPageState extends State<ProductCRUDPage> {
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
                  onPressed: () => updateData(doc),
                  child: Text('Update ', style: TextStyle(color: Colors.white)),
                  color: Colors.orangeAccent,
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () => deleteData(doc),
                  color: Colors.orangeAccent,
                  child: Text('Delete', style: TextStyle(color: Colors.white)),
                ),
              ],
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
        hintText: 'Enter the name of product',
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
  }

  TextFormField buildTextFormField2() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter the price of product',
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
      appBar: AppBar(
        title: Text(
          'ADD PRODUCT',
          style: TextStyle(color: Colors.white),
        ),
      ),
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
                ])),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: createData,
                color: Colors.orangeAccent,
                child: Text('CREATE', style: TextStyle(color: Colors.white)),
              ),
            ],
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
          .collection('ProductCRUD')
          .add({'price': '$price', 'name': '$name '});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('ProductCRUD').document(doc.documentID).updateData({});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('ProductCRUD').document(doc.documentID).delete();
    setState(() => id = null);
  }
}
