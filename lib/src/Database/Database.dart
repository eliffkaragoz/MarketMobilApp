import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addProduct(Map<String, String> product) async {
    await _db.collection('ProductCRUD').doc().set(product).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<void> updateProduct(
      String id, Map<String, String> product) async {
    await _db.collection('ProductCRUD').doc(id).update(product).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<void> deleteProduct(String id) async {
    await _db
        .collection('ProductCRUD')
        .doc(id) //document id sini alman gerek
        .delete()
        .catchError((e) {
      print(e);
    });
    print("scsess");
    return true;
  }
}
