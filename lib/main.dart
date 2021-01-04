import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_final_odevi/src/Manager/Product_Provider.dart';
import 'package:flutter_final_odevi/src/welcomePage.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_final_odevi/src/Manager/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Firebase e bağlanması için bu satırlar olmalııı
  await Firebase
      .initializeApp(); //Firebase e bağlanması için bu satırlar olmalııı
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root o f your application.        //Ürün ekleme çalışmam bitmedi onlar için gerekliydi !!
  @override
  Widget build(BuildContext context) {
    //final firestoreService = FirestoreService();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomePage(),
    );
  }
}
