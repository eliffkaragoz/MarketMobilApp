import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/BackGround/BackGroundMain.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ProductEdit.dart';
import 'productAdd.dart';
import 'productDelete.dart';

class ProductManagement extends StatefulWidget {
  ProductManagement({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ProductManagementState createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'PRODUCTS ',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget ProductAddButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductAdd()));
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
          'PRODUCT ADD',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
      ),
    );
  }

  Widget ProductDeleteButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductDelete()));
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
          'PRODUCT DELETE',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
      ),
    );
  }

  Widget ProductEditButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductEdit()));
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
          'PRODUCT EDIT',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
      ),
    );
  }

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
                    ProductAddButton(),
                    SizedBox(height: 20),
                    ProductDeleteButton(),
                    SizedBox(height: 20),
                    ProductEditButton(),
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
