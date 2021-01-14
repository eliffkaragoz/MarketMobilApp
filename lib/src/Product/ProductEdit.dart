import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/src/Product/ProductEditPage.dart';

import 'Product.dart';

class ProductEdit extends StatefulWidget {
  ProductEdit({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
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

  void Edit() {}

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Product.fromSnapshot(data);

    Widget product;

    Widget productButton() {
      return ListTile(
          title: Text(record.name),
          trailing: Text(record.price),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductEditPage(record.reference.id))));
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
      appBar: AppBar(title: Text('Ürün Düzenleme')),
      body: _buildBody(context),
    );
  }
}
