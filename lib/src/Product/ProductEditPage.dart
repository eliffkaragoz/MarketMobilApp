import 'package:flutter/material.dart';

import '../Database/Database.dart';

class ProductEditPage extends StatefulWidget {
  ProductEditPage(String id) {
    this.id = id;
  }
  String id;
  @override
  _ProductEditPageState createState() => _ProductEditPageState(id);
}

class _ProductEditPageState extends State<ProductEditPage> {
  //TODO: Veritabanına gönderildiğine dair onay kutusu oluştur

  _ProductEditPageState(String id) {
    this.id = id;
  }

  String _product_name;
  String _price;
  String id;

  var _controller_name = TextEditingController();
  var _controller_price = TextEditingController();

  void confirm() {
    print(id);
    Database.updateProduct(id, {'name': _product_name, 'price': _price});
    _controller_name.clear();
    _controller_price.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 50),
        TextField(
          controller: _controller_name,
          onChanged: (text) {
            _product_name = text;
          },
          decoration: InputDecoration(labelText: 'Product Name'),
        ),
        SizedBox(height: 50),
        TextField(
          controller: _controller_price,
          onChanged: (text) {
            _price = text;
          },
          decoration: InputDecoration(labelText: 'Product Price'),
        ),
        SizedBox(height: 50),
        RaisedButton(
          onPressed: () => confirm(),
          color: Colors.orangeAccent,
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Container(
            child: Text(
              'CONFIRM',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        )
      ]),
    );
  }
}
