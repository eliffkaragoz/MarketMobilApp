import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourierManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: CourierCRUD(),
    );
  }
}

class CourierCRUD extends StatefulWidget {
  @override
  _CourierCRUDState createState() => _CourierCRUDState();
}

class _CourierCRUDState extends State<CourierCRUD> {
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  //String price;

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      color: Colors.white12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'COURIER ID :  ${doc['id']} ',
              style: TextStyle(color: Colors.brown, fontSize: 24),
            ),
            Text(
              'COURIER NAME:  ${doc['name']}',
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
        hintText: 'Enter the ID of courier',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onSaved: (value) => id = value,
    );
  }

  TextFormField buildTextFormField2() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter the name of courier',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD COURİER',
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
            stream: db.collection('CourierCRUD').snapshots(),
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
          .collection('CourierCRUD')
          .add({'name': '$name ', 'id': '$id'});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('CourierCRUD').document(doc.documentID).updateData({});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('CourierCRUD').document(doc.documentID).delete();
    setState(() => id = null);
  }
}
