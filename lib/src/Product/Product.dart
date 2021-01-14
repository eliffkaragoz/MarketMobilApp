import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String price;
  final DocumentReference reference;

  Product.fromMap(Map<String, dynamic> map, {this.reference})
      : //assert(map['name'] != null),
        //assert(map['votes'] != null),
        name = map['name'],
        price = map['price'];

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
