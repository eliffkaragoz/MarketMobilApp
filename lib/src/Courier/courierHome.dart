import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/BackGround/BackGroundMain.dart';
//import '../Courier/Courier.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Manager/ManagerHome/CourierManagement/CourierCRUDPage.dart';
import 'courierOrderRoute.dart';

class courierHome extends StatefulWidget {
  courierHome(String email) {
    this.email = email;
  }
  String email;
  @override
  _courierHomeState createState() => _courierHomeState(email);
}

class _courierHomeState extends State<courierHome> {
  _courierHomeState(String email) {
    this.email = email;
  }
  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getlocation() {
    DocumentReference document =
        FirebaseFirestore.instance.collection('CourierCRUD').doc('$email');
    document.get().then((DocumentSnapshot ds) {
      ds['order'].get().then((DocumentSnapshot dp) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapSample(dp['location'], document)));
      });
    });
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'COURIER PAGE',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget routeButton() {
    return InkWell(
      onTap: () {
        getlocation(); //TODO
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: Colors.orange, width: 5),
        ),
        child: Text(
          'ROUTE MAP',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
      ),
    );
  }

  Widget courierManagementButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CourierManagement()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Colors.orange, width: 5),
        ),
        child: Text(
          'ROUTE MAP',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BackGroundMain()),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 220),
                    _title(),
                    SizedBox(height: 45),
                    routeButton(),
                    SizedBox(height: 20),
                    //courierManagementButton(),
                    //SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
