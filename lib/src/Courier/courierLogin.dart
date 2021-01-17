import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_final_odevi/src/Courier/courierHome.dart';
//import 'package:flutter_final_odevi/src/Manager/products.dart';
import 'package:google_fonts/google_fonts.dart';

class courierLogin extends StatefulWidget {
  @override
  _courierLoginState createState() => _courierLoginState();
}

class _courierLoginState extends State<courierLogin> {
  String _email;
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
              text: 'Courier Login',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 40),
            ),
          ]),
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
            onChanged: (input) => _email =
                input, // Input taki değeri email değişkenine aktarıyor..
            decoration: InputDecoration(labelText: 'Email'),
          ),
          RaisedButton(
            onPressed: () => push(), //TODO
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

  void push() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => courierHome(_email)));
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
