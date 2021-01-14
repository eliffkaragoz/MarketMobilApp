import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/BackGround/BackGroundMain.dart';
import 'package:flutter_final_odevi/src/Manager/ManagerHome/CourierManagement.dart';
import 'package:flutter_final_odevi/src/Manager/ManagerHome/courierTracking.dart';
//import '../Courier/courier.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserHome extends StatefulWidget {
  UserHome({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'USER',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 60,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'PAGE',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget createOrderButton() {
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
          'CREATE ORDER',
          style: TextStyle(fontSize: 40, color: Colors.brown),
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
          style: TextStyle(fontSize: 35, color: Colors.brown),
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
                    SizedBox(height: 90),
                    createOrderButton(),
                    SizedBox(height: 50),
                    CourierTrackingButton(),
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
