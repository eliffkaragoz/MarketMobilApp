import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/src/Courier/Courier.dart';
import 'package:flutter_final_odevi/src/Manager/ManagerHome/orderList.dart';

class courierList extends StatefulWidget {
  courierList(DocumentReference ordr) {
    this.ordr = ordr;
  }
  DocumentReference ordr;
  @override
  _courierListState createState() => _courierListState(ordr);
}

class _courierListState extends State<courierList> {
  _courierListState(DocumentReference ordr) {
    this.ordr = ordr;
  }
  DocumentReference ordr;
  String pname;

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('CourierCRUD').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        // ignore: deprecated_member_use
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Courier.fromSnapshot(data);

    Future<void> giveCourier() async {
      record.order = ordr;
      ordr.get().then((DocumentSnapshot ds) {
        if (ds.exists) {
          pname = ds.data()['name'];
          record.reference
              .update(<String, dynamic>{'order': ordr, 'ordr_name': pname});
        }
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => orderList()));
    }

    Widget product;

    Widget productButton() {
      return ListTile(
          title: Text(record.name),
          trailing: Text(record.id),
          onTap: () => giveCourier());
    }

    product = productButton();

    return Padding(
      key: ValueKey(record.reference.id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COURIER LIST',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildBody(context),
    );
  }
}
