import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_final_odevi/BackGround/BackGroundMain.dart';
import 'package:flutter_final_odevi/src/User/UserLogin.dart';
import 'package:flutter_final_odevi/src/User/UserRegister.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BackGround/BackGroundEffect.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserPage extends StatefulWidget {
  UserPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'MARKET',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 60,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'APP',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget RegisterButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserRegister()));
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
          'REGISTER',
          style: TextStyle(fontSize: 30, color: Colors.brown),
        ),
      ),
    );
  }

  Widget LoginButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserLogin()));
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
          'LOGIN',
          style: TextStyle(fontSize: 30, color: Colors.brown),
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
                    SizedBox(height: 200),
                    _title(),
                    SizedBox(height: 80),
                    RegisterButton(),
                    SizedBox(height: 50),
                    LoginButton(),
                    SizedBox(height: 20),
                    SizedBox(height: height * .055),
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
