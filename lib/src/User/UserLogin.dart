import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/BackGround/BackGroundMain.dart';
import 'package:flutter_final_odevi/src/Manager/ManagerHome.dart';
import 'package:flutter_final_odevi/src/User/userHome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              text: 'LOGIN',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  //fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // todo implement fields
          TextFormField(
            // ignore: missing_return
            validator: (input) {
              if (input.isEmpty) {
                return 'Lütfen email girişi yapınız';
                // ignore: missing_return
              }
            },
            onSaved: (input) => _email =
                input, // Input taki değeri email değişkenine aktarıyor..
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            // ignore: missing_return
            validator: (input) {
              if (input.length < 6) {
                return 'Lütfen 6 karakterden büyük şifre girişi yapınız';
                // ignore: missing_return
              }
            },
            onSaved: (input) => _password = input,
            decoration: InputDecoration(labelText: 'Şifre'),
            obscureText: true,
          ),

          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserHome()));
            },
            color: Colors.orangeAccent,
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Container(
              child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey
        .currentState; //FormKey formu temsil eden bir değişken   ///Formda bulunan tüm bilgileri içerisinde bulunduracak!!
    if (formState.validate()) {
      // todo login to firebase
      formState.save();
      try {
        // Firebase ile iletişim noktası
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ManagerHome()));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Back",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.orangeAccent,
        ),
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BackGroundMain()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 150),
                      _title(),
                      SizedBox(height: 60),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password ?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height: height * .055),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
