import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
//import 'package:flutter_final_odevi/src/Manager/products.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ManagerHome.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Manager Login',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 40),
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
            onPressed: () => signIn(), // () => signIn()
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ManagerHome()));

        ///BURADAN ÇAĞRILIYORR
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 70),
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
