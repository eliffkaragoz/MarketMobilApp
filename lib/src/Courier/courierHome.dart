import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/BackGround/BackGroundMain.dart';
//import '../Courier/Courier.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Manager/ManagerHome/CourierManagement/CourierCRUDPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class courierHome extends StatefulWidget {
  courierHome({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _courierHomeState createState() => _courierHomeState();
}

class _courierHomeState extends State<courierHome> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'COURIER PAGE ',
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
        /*Navigator.push(context,
            MaterialPageRoute(builder: (context) => MapSample())); //TODO*/
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
