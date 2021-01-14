import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/src/Database/Database.dart';

import 'Product.dart';

class ProductDelete extends StatefulWidget {
  ProductDelete({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ProductDeleteState createState() => _ProductDeleteState();
}

class _ProductDeleteState extends State<ProductDelete> {
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ProductCRUD').snapshots(),
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

  void delete() {}

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Product.fromSnapshot(data);

    Widget product;

    Widget productDelete() {
      setState(() {
        product = Container();
        Database.deleteProduct(record.reference.id);
      });
    }

    Widget productButton() {
      return ListTile(
          title: Text(record.name),
          trailing: Text(record.price),
          onTap: () => productDelete());
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
      appBar: AppBar(title: Text('Ürün Silme')),
      body: _buildBody(context),
    );
  }
}
