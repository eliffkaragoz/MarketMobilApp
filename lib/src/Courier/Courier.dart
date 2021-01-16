import 'package:cloud_firestore/cloud_firestore.dart';

class Courier {
  String id;
  String name;
  String email;
  String ordr_name;
  DocumentReference order;
  final DocumentReference reference;

  Courier.fromMap(Map<String, dynamic> map, {this.reference})
      : //assert(map['name'] != null),
        //assert(map['votes'] != null),
        id = map['id'],
        name = map['name'],
        email = map['email'];

  Courier.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
