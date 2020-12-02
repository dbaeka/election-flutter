import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Capture/capture_screen.dart';
import 'package:flutter_auth/Screens/Dashboard/components/background.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/controllers/my-functions.dart';

class AdminScreen extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  AdminScreen({Key key}) : super(key: key);

  @override
  AdminScreenState createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
//class Body extends StatelessWidget {

  String name="";

  @override
  void initState() {
    super.initState();

    _loggedInDetails();
  }

  _loggedInDetails() async {
    String data = await MyFunctions.loggedInDetails();

    setState(() {
       name = jsonDecode(data)["name"].toUpperCase();
    });
   
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "GHANA DECIDES'20",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              "WELCOME $name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            /*SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),*/
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "ADD USER",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CaptureScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "USERS",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('System Administrator')),
      //appBar: "System Administrator",
      body: AdminScreen(),
    );
  }
}
