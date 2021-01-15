import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String id;
  String name;
  String price;
  final DocumentReference reference;

  Order.fromMap(Map<String, dynamic> map, {this.reference})
      : //assert(map['name'] != null),
        //assert(map['votes'] != null),
        name = map['name'],
        price = map['price'];

  Order.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
