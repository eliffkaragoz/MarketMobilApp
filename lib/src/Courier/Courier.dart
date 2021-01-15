import 'package:cloud_firestore/cloud_firestore.dart';

class Courier {
  String id;
  String name;
  final DocumentReference reference;

  Courier.fromMap(Map<String, dynamic> map, {this.reference})
      : //assert(map['name'] != null),
        //assert(map['votes'] != null),
        id = map['id'],
        name = map['name'];

  Courier.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
