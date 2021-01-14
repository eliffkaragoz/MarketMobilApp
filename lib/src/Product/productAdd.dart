import 'package:flutter/material.dart';

import '../Database/Database.dart';

class ProductAdd extends StatefulWidget {
  ProductAdd({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  //TODO: Veritabanına gönderildiğine dair onay kutusu oluştur

  String _product_name;
  String _price;

  var _controller_name = TextEditingController();
  var _controller_price = TextEditingController();

  void confirm() {
    _controller_name.clear();
    _controller_price.clear();
    Database.addProduct({'name': _product_name, 'price': _price});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ürün Ekleme')),
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
