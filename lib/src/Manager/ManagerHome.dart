import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/BackGround/BackGroundMain.dart';
import 'package:flutter_final_odevi/src/Manager/ManagerHome/CourierManagement.dart';
import 'package:flutter_final_odevi/src/Manager/ManagerHome/courierTracking.dart';
import 'file:///D:/flutter_calismalar/flutter_final_odevi/lib/src/Courier/courier.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ManagerHome extends StatefulWidget {
  ManagerHome({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'ADMIN PAGE ',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget productManagementButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => productManagementButton()));
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
          'PRODUCT MANAGEMENT',
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
          'COURİER MANAGEMENT',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
      ),
    );
  }

  Widget orderListButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => orderListButton()));
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
          'ORDER LIST',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
      ),
    );
  }

  Widget orderManagementButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => orderManagementButton()));
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
          'ORDER MANAGEMENT',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
      ),
    );
  }

  Widget CourierTrackingButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => courierTracking()));
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
          'WHERE IS THE COURIER?',
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
                    SizedBox(height: 160),
                    _title(),
                    SizedBox(height: 45),
                    productManagementButton(),
                    SizedBox(height: 20),
                    courierManagementButton(),
                    SizedBox(height: 20),
                    orderListButton(),
                    SizedBox(height: 20),
                    orderManagementButton(),
                    SizedBox(height: 20),
                    CourierTrackingButton(),
                    SizedBox(height: 20),
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
